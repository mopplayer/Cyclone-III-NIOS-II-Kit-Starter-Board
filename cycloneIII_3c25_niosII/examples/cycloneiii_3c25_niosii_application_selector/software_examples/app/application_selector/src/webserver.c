/******************************************************************************
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
* All rights reserved. All use of this software and documentation is          *
* subject to the License Agreement located at the end of this file below.     *
*******************************************************************************
*                                                                             *
* File: webserver.c                                                                *
*                                                                             *
* A rough imlementation of HTTP. This is not intended to be a complete        *
* implementation, just enough for a demo simple web server. This example      *
* application is more complex than the telnet serer example in that it uses   *
* non-blocking IO & multiplexing to allow for multiple simultaneous HTTP      *
* sessions.                                                                   *            
*                                                                             *
* This example uses the sockets interface. A good introduction to sockets     *
* programming is the book Unix Network Programming by Richard Stevens         *
*                                                                             *
* Please refer to file ReadMe.txt for notes on this software example.         *
*******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <alt_iniche_dev.h>
#include <sys/param.h>
#include <sys/fcntl.h>
#include "webserver.h"
#include "sys/alt_alarm.h"
#include "alt_types.h"
#include "alt_2_wire.h"
#include "alt_eeprom.h"
#include "sys/alt_flash.h"
#include "io.h"
#include "srec.h"
#include "flash_intel_p30.h"

/* Iniche Specific includes. */
#include "includes.h"
#include "ipport.h"
#include "libport.h"
#include "osport.h"
#include "tcpport.h"
#include "os_utils.h"
#include "net.h"
#include "dhcpclnt.h"
#include "icmp.h"

/* El Camino FAT SD Card */
#include "elca_fat.h"
#include "sd_card.h"

/* App Selector include. */
#include "app_selector.h"

/* Low-level network */
#include "triple_speed_ethernet_regs.h"
#include "iniche/triple_speed_ethernet_iniche.h"
#include "iniche/ins_tse_mac.h"

#ifdef DEBUG
  #include alt_debug.h
#else
  #define ALT_DEBUG_ASSERT(a) 
#endif /* DEBUG */

#define IP4_ADDR(ipaddr, a,b,c,d) ipaddr = \
    htonl((((alt_u32)(a & 0xff) << 24) | ((alt_u32)(b & 0xff) << 16) | \
          ((alt_u32)(c & 0xff) << 8) | (alt_u32)(d & 0xff)))


struct device devices[] = {
    { 0,    0x10,   0xA0,   0xA1    },
    { 8,    0x400,  0xA0,   0xA1    },
    { 16,   0x800,  0xA0,   0xA1    },
};

struct device *device = &(devices[0]);

// Global variable which lets me know when the user is using the GUI's main
// menu.
extern int InMainMenu;

// Use the standard AsReconfigFPGA function.
extern int AsReconfigFPGA(int hw_offset);

// dhc_set_state
extern int dhc_set_state( int iface, int state );

// Reference to hostname global.
char * system_dhcp_hostname;


OS_STK netman_task_stk[AS_NETMAN_TASK_STACKSIZE]; 
extern OS_EVENT* As_WebserverStatusMbox;
char ws_msg_string[256];
//Need the following for detecting the state of the ethernet PHY, after
//networking is initialized.
extern ins_tse_info tse;


/*****************************************************************************
 *   Declarations for creating a task with TK_NEWTASK.  
 *   All tasks which use NicheStack (those that use sockets) must be created 
 *   this way.  TK_OBJECT macro creates the static task object used by 
 *   NicheStack during operation.  TK_ENTRY macro corresponds to the entry 
 *   point, or defined function name, of the task.  inet_taskinfo is the 
 *   structure used by TK_NEWTASK to create the task.
 ****************************************************************************/
TK_OBJECT(to_wstask);
TK_ENTRY(WSTask);
struct inet_taskinfo wstask = {
      &to_wstask,
      "web server",
      WSTask,
      AS_HTTP_PRIO,
      AS_HTTP_TASK_STACKSIZE,
};

/* 
 * TX & RX buffers. 
 * 
 * These are declared globally to prevent the MicroC/OS-II thread from
 * consuming too much OS-stack space
 */
alt_u8 http_rx_buffer[HTTP_NUM_CONNECTIONS][HTTP_RX_BUF_SIZE];
alt_u8 http_tx_buffer[HTTP_NUM_CONNECTIONS][HTTP_TX_BUF_SIZE];

/*Function prototypes and external functions. */

extern void reconfig_fpga();
int http_find_file();

/* 
 * This canned HTTP reply will serve as a "404 - Not Found" Web page. HTTP
 * headers and HTML embedded into the single string.
 */
static const alt_8 canned_http_response[] = {"\
HTTP/1.0 404 Not Found\r\n\
Content-Type: text/html\r\n\
Content-Length: 272\r\n\r\n\
<HTML><HEAD><TITLE>Nios II Web Server Demonstration</TITLE></HEAD>\
<title>NicheStack on Nios II</title><BODY><h1>HTTP Error 404</h1>\
<center><h2>Nios II Web Server Demonstration</h2>\
Can't find the requested file file. \
Have you programmed the flash filing system into flash?</html>\
"};

static const alt_8 canned_response2[] = {"\
HTTP/1.0 200 OK\r\n\
Content-Type: text/html\r\n\
Content-Length: 2000\r\n\r\n\
<HTML><HEAD><TITLE>Nios II Web Server Demonstration</TITLE></HEAD>\
<title>NicheStack on Nios II</title><BODY>\
<center><h2>Nios II Web Server Hardware Report</h2>\
</center>\
"};
/* 
 * Mapping between pages to post to and functions to call: This allows us to
 * have the HTTP server respond to a POST requset saying "print" by calling
 * a "print" routine (below).
 */
typedef struct funcs
{
  alt_u8*  name;
  void (*func)(); 
}post_funcs;

/*
 * Mapping between pages to GET and functions to call: This allows us to
 * have the HTTP server respond to a GET request that maps to a function call. 
 *   - A good example of this is to return Javascript JSON responses for status
 *     information. 
 */


typedef struct func_mapping
{
  alt_u8* name;
  void (*func)();
}get_funcs;

struct {
  alt_u8 state[9];
  int percent_done;
  int speed;
} progress;

struct http_form_data board_funcs;

int current_flash_block;

/* Data structure holding the line fragment (leftover) info. */

struct {
  int len;
  char data[MAXLINE];
} frag;

/* Global line count variable. */

int line_count;

/* 
 * print()
 * 
 * This routine is called to demonstrate doing something server-side when an
 * HTTP "POST" command is received.
 */
void print()
{
  printf("WS INFO:  POST received.\n");
}

void stats( http_conn* conn )
{
  printf("\n\tWS INFO:  Packets Sent %lu", tcpstat.tcps_sndtotal );
  printf("\n\tWS INFO:  Packets Received %lu\n", tcpstat.tcps_rcvtotal );
}

int get_content_disposition_field( alt_u8* field_name_to_get, alt_u8* field_value_to_return, alt_u8* line_buffer )
{
  int ret_code = 0;
  alt_u8* temp_ptr;
  int length;
  
  // strstr here is okay because line_buffer will only ever be text.  Never binary
  temp_ptr = strstr( line_buffer, field_name_to_get );
  if( temp_ptr != NULL )
  {
    temp_ptr = strchr( temp_ptr, '\"' ) + 1;
    length = (int)strchr( temp_ptr, '\"' ) - (int)temp_ptr;
    strncpy( field_value_to_return, temp_ptr, length );
  }
  else
  {
    ret_code = -1;
  }
  return( ret_code );
}

// This is essentally a binary-safe version of strstr.  NULL characters and other ASCII control stuff is ignored.
alt_u8* find_string_in_buf( alt_u8* buf_start, alt_u8* string, int length )
{
  alt_u8* temp_buf_ptr = buf_start;
  alt_u8* temp_string_ptr = string;
  alt_u8* ret_ptr = NULL;
  int string_length = strlen( string );
  int i, j;
  
  length -= string_length;
  
  for( i = 0; i < length; i++ )
  {
    for( j = 0; j < string_length; j++ )
    {
      if( temp_buf_ptr[j] != temp_string_ptr[j] )
      {
        break;
      }
    }

    if( j == string_length )
    {
      ret_ptr = temp_buf_ptr;
      break;
    }

    temp_buf_ptr++;
  }
  
  return( ret_ptr );
}

int http_parse_multipart_header( http_conn* conn )
{
  /* Most of the information is on the first line following the boundary. */
//  alt_u8* cr_pos;
  alt_u8* temp_pos;
  alt_u8 temp_line[256];
  alt_u8 line_length = 0;
  alt_u8* ext;

  /* 
   * For now, make the assumption that no multipart headers are split
   * across packets.  This is a reasonable assumption, but not a surety.
   *
   */
  // Here we use find_string_in_buf() instead of strstr() because there could be some binary junk just in front of the boundary string.
  if(( temp_pos = find_string_in_buf( conn->rx_rd_pos, conn->boundary, strlen( conn->boundary ) + 10 )))
  {
    // Move up to the beginning of Content-Disposition
    // strstr() is okay here because at this point we're sure to be dealing with text only.
    if(( temp_pos = strstr( conn->rx_rd_pos, "Content-Disposition" )))
    {
      conn->rx_rd_pos = temp_pos;
      line_length = (int)strstr( conn->rx_rd_pos, HTTP_CR_LF ) - (int)conn->rx_rd_pos;
      strncpy( temp_line, conn->rx_rd_pos, line_length );
      get_content_disposition_field( "name=", conn->post_name, temp_line );
      get_content_disposition_field( "filename=", conn->upload_filename, temp_line );
      conn->rx_rd_pos += line_length;

      ext = strchr( conn->upload_filename, '.' );
      if( !strcasecmp( ext, ".flash" ) || !strcasecmp( ext, ".srec" ))
      {
        conn->filetype = FILE_TYPE_SREC;
      }
      else if( !strcasecmp( ext, ".bin" ) || !strcasecmp( ext, ".rbf" ))
      {
        conn->filetype = FILE_TYPE_BINARY;
      }
      else
      {
        conn->filetype = -1;
      }

      conn->rx_rd_pos = strstr( conn->rx_rd_pos, HTTP_END_OF_HEADER ) + 4;
    }
    else if(( temp_pos = strstr( conn->rx_rd_pos, "\r\n" )))
    {
      // transaction is complete.
      conn->file_upload = 0;
      conn->rx_rd_pos = temp_pos + 2;
    }
  }
  return(0);
}

int write_flash( unsigned int flash_base, unsigned int offset, void* buffer, int byte_count )
{
  int ret_code = 0;
  
  //printf( "DEBUG: Prog Flash b=0x%X, o=0x%X, bytes=0x%x\n", flash_base, offset, byte_count );
  
  ret_code |= flash_intel_p30_erase ( flash_base, offset, byte_count );
  ret_code |= flash_intel_p30_write ( flash_base, offset, (void*)buffer, byte_count / 2 );
  IOWR_16DIRECT( flash_base, offset, 0xFF ); // restore read mode

  if( memcmp( (void*)(flash_base + offset ), buffer, byte_count ))
      {
    ret_code |= -1;
      }

  if( ret_code != 0 )
  {
    printf( "ERROR: Flash Programming Failed: base=0x%X, offset=0x%X\n", flash_base, offset );
  }
    
  return( ret_code );
}


int process_uploaded_data( upld_buf* upload_buffer, int filetype, int flash_base, int *flash_offset, int force_flash_write )
{
  srec_t srec;
  int bytes_in_bin_buffer;
  int ret_code = 0;
  int bytes_processed;
  alt_u8* temp;
  
  // Since we technically have two flash devices, if the offset is within the second flash,
  // we set the flash base to the base of the second flash device.
  
  // TODO: deal with binary data too, use filetype variable to detect data type.
  while( srec_decode( &srec, upload_buffer->srec_rd_pos ) == SREC_OK )
  {
    // Before processing the data, find next beginning of next SREC line.  
    // If a /n character is not found in the next 80 characters, or if the write 
    // pointer is found first, then this is technically an incomplete line.  We need 
    // to break out of the loop and wait for more SREC data.
    temp = memchr( upload_buffer->srec_rd_pos, '\n', 80 );
    if(( temp == NULL ) || ( temp >= upload_buffer->srec_wr_pos ))
    {
      break;
    }
    else    
    {      
      upload_buffer->srec_rd_pos = temp + 1 ;
    }
    
    // Now process the data
    if( srec.type != 0 )
    {
      memcpy( upload_buffer->bin_wr_pos, srec.data, srec.count );
      upload_buffer->bin_wr_pos += srec.count;
      bytes_in_bin_buffer = upload_buffer->bin_wr_pos - upload_buffer->bin_rd_pos;
      if( bytes_in_bin_buffer >= FLASH_WRITE_THRESHOLD )
      {
        ret_code = write_flash( flash_base, *flash_offset, (void*)upload_buffer->bin_rd_pos, FLASH_WRITE_THRESHOLD );

        if( !ret_code )
        {
          // Increment flash offset to next sector
          *flash_offset += FLASH_SECTOR_SIZE;
          
          // Manage binary data buffer
          upload_buffer->bin_rd_pos += FLASH_WRITE_THRESHOLD;
          memmove( upload_buffer->bin_buffer, upload_buffer->bin_rd_pos, upload_buffer->bin_wr_pos - upload_buffer->bin_rd_pos );
          upload_buffer->bin_wr_pos -= ( upload_buffer->bin_rd_pos - upload_buffer->bin_buffer );
          upload_buffer->bin_rd_pos = upload_buffer->bin_buffer;
        }
        else
        {
          break;
        }
      }
    }
    
  }
  
  bytes_in_bin_buffer = upload_buffer->bin_wr_pos - upload_buffer->bin_rd_pos;
  if( force_flash_write && bytes_in_bin_buffer )
  {
    ret_code = write_flash( flash_base, *flash_offset, (void*)upload_buffer->bin_rd_pos, bytes_in_bin_buffer );
    if( !ret_code )
    {
      *flash_offset += bytes_in_bin_buffer;
      
      // Manage binary data buffer
      upload_buffer->bin_rd_pos += bytes_in_bin_buffer;
      if( upload_buffer->bin_wr_pos > upload_buffer->bin_rd_pos )
      {
        memmove( upload_buffer->bin_buffer, upload_buffer->bin_rd_pos, upload_buffer->bin_wr_pos - upload_buffer->bin_rd_pos );
      } 
      upload_buffer->bin_wr_pos -= ( upload_buffer->bin_rd_pos - upload_buffer->bin_buffer );
      upload_buffer->bin_rd_pos = upload_buffer->bin_buffer;
    }
  }    
  
  // Manage upload buffer
  bytes_processed = upload_buffer->srec_rd_pos - upload_buffer->srec_buffer;
  if( upload_buffer->srec_wr_pos > upload_buffer->srec_rd_pos )
  {
    memmove( upload_buffer->srec_buffer, upload_buffer->srec_rd_pos, upload_buffer->srec_wr_pos - upload_buffer->srec_rd_pos );
  }
  upload_buffer->srec_wr_pos -= bytes_processed;
  upload_buffer->srec_rd_pos = upload_buffer->srec_buffer;
  memset( upload_buffer->srec_wr_pos, 0, bytes_processed );

  return( ret_code );
}

int lookup_flash_offset( alt_u8* description, int* flash_base, int* flash_offset )
{
  
  if( !strcmp( description, "hw_filename" ))
  {
    *flash_offset = USER_HW_IMAGE_OFFSET;
  }
  else if( !strcmp( description, "sw_filename" ))
  {
    *flash_offset = USER_SW_IMAGE_OFFSET;
  }
  else
  {
    *flash_offset = -1; // -1 is always invalid
  }

  // Hardcode flash_base....since it's always the same for this design.

  *flash_base = EXT_FLASH_BASE;
  
  return( 0 );
}


void file_upload( http_conn* conn )
{
  alt_u8* end_of_multipart_data;
  int buf_len;
  int data_used;
  static int start_time = 0;
  int current_secs;
  static int flash_offset = -1;
  static int flash_base =   -1;
  int end_of_file;
  unsigned int percent_done;
  static unsigned int last_percent_done = 0;
  int kbytes_per_second;


  if( start_time == 0 )
  {
    start_time = alt_nticks();
  }

  // Extract out each multipart field found in this packet.
  do
  {
    // Look for boundary, parse multipart form "mini" header information if found.
    if( find_string_in_buf( conn->rx_rd_pos, conn->boundary, strlen( conn->boundary ) + 4 ))
    {
      if( http_parse_multipart_header( conn ) == 0 )
      {
        // Set the flash offset depending upon the submitted post field name
        lookup_flash_offset( conn->post_name, &flash_base, &flash_offset );
//        printf( "DEBUG: Uploading %s\n", conn->post_name );
      }
      else
      {
        printf( "WS ERROR:  multipart-form header parse failure...resetting connection!" );
        conn->state = RESET;
      }
    }

//    // Exception for IE.  It sometimes sends _really_ small initial packets!
//    if( strchr( conn->rx_rd_pos, ':' ) <=  conn->rx_rd_pos + 10 )
//    {
//      conn->state = READY;
//      return;
//    }

    // Calculate the data length...
    if(( end_of_multipart_data = find_string_in_buf( conn->rx_rd_pos, conn->boundary, conn->rx_wr_pos - conn->rx_rd_pos )))
    {
      buf_len = end_of_multipart_data - conn->rx_rd_pos;
      end_of_file = 1;
    }
    else
    {
      buf_len = conn->rx_wr_pos - conn->rx_rd_pos;
      end_of_file = 0;
    }
    
    conn->content_received = conn->content_received + buf_len;
      
    if( flash_offset > 0 )
    {
      // Copy all the received data into the upload buffer.
      if ( memcpy( (void*) conn->upload_buffer->srec_wr_pos, 
                   (void*) conn->rx_rd_pos, 
                   buf_len ) == NULL )
      {
        printf( "WS ERROR:  memcpy to file upload buffer failed!" );
      }
      // Increment the wr_pos pointer to just after the received data.
      conn->upload_buffer->srec_wr_pos = conn->upload_buffer->srec_wr_pos + buf_len;
      
      // Deal with upload buffer here.
      process_uploaded_data( conn->upload_buffer, conn->filetype, flash_base, &flash_offset, end_of_file );

      // DEBUG: This just throws away the uploaded data
//      conn->upload_buffer->srec_wr_pos = conn->upload_buffer->srec_rd_pos = conn->upload_buffer->srec_buffer;
      
      // If we've reached the end of a file upload, reset the srec_buffer
      if( end_of_file )
      {
        memset( conn->upload_buffer->srec_buffer, 0, conn->upload_buffer->srec_wr_pos - conn->upload_buffer->srec_buffer );
        conn->upload_buffer->srec_wr_pos = conn->upload_buffer->srec_rd_pos = conn->upload_buffer->srec_buffer;
      }
    }

    conn->rx_rd_pos = conn->rx_rd_pos + buf_len;
          
    // Reset the rx buffers after copying the data into the big intermediate 
    // buffer.
    data_used = conn->rx_rd_pos - conn->rx_buffer;
    memmove( conn->rx_buffer, conn->rx_rd_pos, conn->rx_wr_pos - conn->rx_rd_pos );
    conn->rx_rd_pos = conn->rx_buffer;
    conn->rx_wr_pos -= data_used;
    memset( conn->rx_wr_pos, 0, data_used );
    
  } while( find_string_in_buf( conn->rx_rd_pos, conn->boundary, conn->rx_wr_pos - conn->rx_rd_pos ));


  if ( conn->file_upload == 0 )
  {
    free( conn->upload_buffer->srec_buffer );
    free( conn->upload_buffer->bin_buffer );
    free( conn->upload_buffer );
    
    //printf( "Done.\n" );

    // Upload is done.  Populate the progress data structure, accordingly.
    strcpy( progress.state, "done" );
    progress.percent_done = 100;
    progress.speed = 0;

    http_find_file( conn );
    conn->close = 1;
  }
  else
  {
    conn->state = READY;
    percent_done = ( conn->content_received * 100 ) / conn->content_length;
    current_secs = ( alt_nticks() - start_time ) / alt_ticks_per_second();
    kbytes_per_second = ( conn->content_received / current_secs ) / 1024;
    if( percent_done > last_percent_done )
    {
//      printf( "%d bytes - %d secs - %d%% - %d KB/s\n", conn->content_received, current_secs, percent_done, kbytes_per_second );
      //printf( "%d%% - %d KB/s\n", percent_done, kbytes_per_second );

      last_percent_done = percent_done;
    }
    // Update the progress data structure during upload.  Use the values that are already being calculated for printf.
    strcpy( progress.state, "uploading" );
    progress.percent_done = percent_done;
    progress.speed = kbytes_per_second;
  }
}


/*
 * The mapping (using our struct defined above) between HTTP POST commands
 * that we will service and the subroutine called to service that POST
 * command.
 */
post_funcs mapping =
{
  "/PRINT",
  print
};

post_funcs stats_field =
{
  "/SWEEP",
  stats 
};

post_funcs upload_field =
{ "/reset_system.html",
  file_upload
};

post_funcs reset_field =
{
  "/RESET_SYSTEM",
  reconfig_fpga 
};

/* GET func mapping. */

get_funcs progress_field =
{
  "/PROGRESS",
  send_progress
};

/*
 * http_reset_connection()
 * 
 * This routine will clear our HTTP connection structure & prepare it to handle
 * a new HTTP connection.
 */
void http_reset_connection(http_conn* conn, int http_instance)
{
  memset(conn, 0, sizeof(http_conn));

  conn->fd = -1;
  conn->state = READY;
  conn->keep_alive_count = HTTP_KEEP_ALIVE_COUNT;
  
  conn->rx_buffer = (alt_u8 *) &http_rx_buffer[http_instance][0];
  conn->tx_buffer = (alt_u8 *) &http_tx_buffer[http_instance][0];
  conn->rx_wr_pos = (alt_u8 *) &http_rx_buffer[http_instance][0];
  conn->rx_rd_pos = (alt_u8 *) &http_rx_buffer[http_instance][0];
}

/*
 * http_manage_connection()
 * 
 * This routine performs house-keeping duties for a specific HTTP connection
 * structure. It is called from various points in the HTTP server code to
 * ensure that connections are reset properly on error, completion, and
 * to ensure that "zombie" connections are dealt with.
 */
void http_manage_connection(http_conn* conn, int http_instance)
{
  alt_u32 current_time = 0;
  
  /*
   * Keep track of whether an open connection has timed out. This will be
   * determined by comparing the current time with that of the most recent
   * activity.
   */
  if(conn->state == READY || conn->state == PROCESS || conn->state == DATA)
  {
    current_time = alt_nticks();
    
    if( ((current_time - conn->activity_time) >= HTTP_KEEP_ALIVE_TIME) && conn->file_upload != 1 )
    {
      conn->state = RESET;
    }
  }
  
  /*
   * The reply has been sent. Is is time to drop this connection, or 
   * should we persist? We'll keep track of these here and mark our
   * state machine as ready for additional connections... or not.
   *  - Only send so many files per connection. 
   *  - Stop when we reach a timeout.
   *  - If someone (like the client) asked to close the connection, do so.
   */
  if(conn->state == COMPLETE)
  {
    if(conn->file_handle >= 0)
    {
      SDClose(conn->file_handle);
    }
      
    conn->keep_alive_count--;
    conn->data_sent = 0;
  
    if(conn->keep_alive_count == 0)
    {
      conn->close = 1;
    }
    
    conn->state = conn->close ? CLOSE : READY;
  }
  
  /* 
   * Some error occured. http_reset_connection() will take care of most
   * things, but the RX buffer still needs to be cleared, and any open
   * files need to be closed. We do this in a separate state to maintain 
   * efficiency between successive (error-free) connections.
   */
  if(conn->state == RESET)
  {
    if(conn->file_handle >= 0)
    {
      SDClose(conn->file_handle);
    }
      
    memset(conn->rx_buffer, 0, HTTP_RX_BUF_SIZE);
    conn->state = CLOSE;
  }
  
  /* Close the TCP connection */
  if(conn->state == CLOSE)
  {
    close(conn->fd);
    http_reset_connection(conn, http_instance);
  }
}

/*
 * http_handle_accept()
 * 
 * A listening socket has detected someone trying to connect to us. If we have 
 * any open connection slots we will accept the connection (this creates a 
 * new socket for the data transfer), but if all available connections are in 
 * use we'll ignore the client's incoming connection request.
 */
int http_handle_accept(int listen_socket, http_conn* conn)
{
  int ret_code = 0, i, socket, len;
  struct sockaddr_in  rem;

  len = sizeof(rem);

  /* 
   * Loop through available connection slots to determine the first available
   * connection.
   */
  for(i=0; i<HTTP_NUM_CONNECTIONS; i++)
  {
    if((conn+i)->fd == -1)
    {
      break;
    }
  }
  
  /* 
   * There are no more connection slots available. Ignore the connection
   * request for now.
   */
  if(i == HTTP_NUM_CONNECTIONS)
    return -1;
      
  if((socket = accept(listen_socket,(struct sockaddr*)&rem,&len)) < 0)
  {
    fprintf(stderr, "[http_handle_accept] accept failed (%d)\n", socket);
    return socket;
  }

  (conn+i)->fd = socket;
  (conn+i)->activity_time = alt_nticks();

  return ret_code;
}

/*
 * http_read_line()
 * 
 * This routine will scan the RX data buffer for a newline, allowing us to
 * parse an in-coming HTTP request line-by-line.
 */
int http_read_line(http_conn* conn)
{
  alt_u8* lf_addr;
  int ret_code = 0;

  /* Find the Carriage return which marks the end of the header */
  lf_addr = strchr(conn->rx_rd_pos, '\n');
  
  if (lf_addr == NULL)
  {
    ret_code = -1;
  }
  else
  {
    /* 
     * Check that the line feed has a matching CR, if so zero that
     * else zero the LF so we can use the string searching functions.
     */
    if ((lf_addr > conn->rx_buffer) && (*(lf_addr-1) == '\r'))
    {
      *(lf_addr-1) = 0;
    }

    *lf_addr = 0;
    conn->rx_rd_pos = lf_addr+1;
  }

  return ret_code;
}

/* http_process_multipart()
 * 
 * This function parses and parses relevant "header-like" information
 * from HTTP multipart forms.
 *   - Content-Type, Content-Disposition, boundary, etc.
 */
int http_parse_type_boundary( http_conn* conn,
                                char* start,
                                int len )
{
  char* delimiter;
  char* boundary_start;
  char line[HTTP_MAX_LINE_SIZE];
  
  /* Copy the Content-Type/Boundary line. */
  if( len > HTTP_MAX_LINE_SIZE )
  {
    printf( "WS ERROR process headers overflow content-type/boundary parsing.\n" );
    return(-1);
  }
  strncpy( line, start, len );
  /* Add a null byte to the end of it. */
  *(line + len) = '\0';
  /* Get the Content-Type value. */
  if( (delimiter = strchr( line, ';' )) )
  {
    /* Need to parse both a boundary and Content-Type. */
    boundary_start = strchr( line, '=' ) + 2;
    strcpy( conn->boundary, boundary_start);
    /* Insert a null space in place of the delimiter. */
    *delimiter = '\0';
    /* First part of the line is the Content-Type. */
    strcpy( conn->content_type, line);
  }
  else
  {
    strcpy( conn->content_type, line );
  }
  return 0;
}

/*
 * http_process_headers()
 * 
 * This routine looks for HTTP header commands, specified by a ":" character.
 * We will look for "Connection: Close" and "Content-length: <len>" strings. 
 * A more advanced server would parse far more header information.
 * 
 * This routine should be modified in the future not to use strtok() as its
 * a bit invasive and is not thread-safe!
 * 
 */
int http_process_headers(http_conn* conn)
{
  alt_u8* option;
  alt_u8* cr_pos;
  alt_u8* ct_start;
  alt_u8* orig_read_pos = conn->rx_rd_pos;
  alt_u8* delimiter_token;
  alt_u8 temp_null;
//  alt_u8* boundary_start;
  int ct_len;
  int opt_len;
   
  // A boundary was found.  This is a multi-part form
  // and header processing stops here!
//  if(( conn->boundary[0] == '-' ) && ( conn->content_length > 0 ))
//  {
//    boundary_start = strstr( conn->rx_rd_pos, conn->boundary );
//    // conn->rx_rd_pos = boundary_start + strlen( conn->boundary );
//    return -1;
//  }
  if( !strncmp( conn->rx_rd_pos, "\r\n", 2 ))
  {
//    conn->rx_rd_pos += 2; 
    return( -1 );
  }
  /* Skip the next section we'll chop with strtok(). Perl for Nios, anyone? */
  else if(( delimiter_token = strchr( conn->rx_rd_pos, ':' )))
  {
    conn->rx_rd_pos = delimiter_token + 1;
    conn->content_received = conn->rx_rd_pos - conn->rx_buffer;
  }
  else
  {
    return( -1 );
  }
  
  option = strtok( orig_read_pos, ":" );

  if( stricmp( option,"Connection" ) == 0 )
  {
    temp_null = *( option + 17 );
    *( option + 17 ) = 0;
    
    if( stricmp(( option+12 ), "close" ) == 0 )
    {
      conn->close = 1;
    }
    *( option + 17 ) = temp_null;
  }
  else if ( stricmp( option, "Content-Length" ) == 0 )
  {
    conn->content_length = atoi( option + 16 );
    //printf( "Content Length = %d.\n", conn->content_length );
  }
  /* When getting the Content-Type, get the whole line and throw it
   * to another function.  This will be done several times.
   */
  else if ( stricmp( option, "Content-Type" ) == 0 )
  {
    /* Determine the end of line for "Content-Type" line. */
    cr_pos = strchr( conn->rx_rd_pos, '\r' );
    /* Find the length of the string. */
    opt_len = strlen( option );
    ct_len = cr_pos - ( option + opt_len + 2 );
    /* Calculate the start of the string. */
    ct_start = cr_pos - ct_len;
    /* Pass the start of the string and the size of the string to 
     * a function.
     */
    if(( http_parse_type_boundary( conn, ct_start, ct_len ) < 0 ))
    {
      /* Something failed...return a negative value. */
      return( -1 );
    }
  }
  return( 0 );
}

/*
 * http_process_request()
 * 
 * This routine parses the beginnings of an HTTP request to extract the
 * command, version, and URI. Unsupported commands/versions/etc. will cause
 * us to error out drop the connection.
 */
int http_process_request(http_conn* conn)
{
  alt_u8* uri = 0;
  alt_u8* version = 0;
  alt_u8* temp = 0;
  if(( temp = strstr( conn->rx_rd_pos, "GET" )))
  {
    conn->action = GET;
    conn->rx_rd_pos = temp;
  }
  else if(( temp = strstr( conn->rx_rd_pos, "POST" )))
  {
    conn->action = POST;
    conn->rx_rd_pos = temp;
  }
  else
  {
    fprintf( stderr, "Unsupported (for now) request\n" );
    conn->action = UNKNOWN;
    return -1;
  }
  
  /* First space char separates action from URI */
  if(( conn->rx_rd_pos = strchr( conn->rx_rd_pos, ' ' )))
  {
    conn->rx_rd_pos++;
    uri = conn->rx_rd_pos;
  }
  else
  {
    return -1;
  }
    
  /* Second space char separates URI from HTTP version. */
  if(( conn->rx_rd_pos = strchr( conn->rx_rd_pos, ' ' )))
  {
    *conn->rx_rd_pos = 0;
    conn->rx_rd_pos++;
    version = conn->rx_rd_pos;
  }
  else
  {
    return -1;
  }
  
  /* Is this an HTTP version we support? */
  if(( version == NULL ) || ( strncmp( version, "HTTP/", 5 ) != 0 ))
  {
    return -1;
  }

  if( !isdigit( version[5] ) || version[6] != '.' || !isdigit( version[7] ))
  {
    return -1;
  }

  /* Before v1.1 we close the connection after responding to the request */
  if (((( version[5] - '0' ) * 10 ) + version[7] - '0' ) < 11 )
  {
    conn->close = 1;
  }

  strcpy( conn->uri, uri );
  return 0;
}


void send_progress(http_conn* conn)
{
  alt_u8* tx_wr_pos = conn->tx_buffer;
  alt_u8* progress_str = (alt_u8*) malloc(512);
  alt_u8* progress_str_pos = progress_str;
  int content_length;
  int result;

  // Send the version string. 
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_VERSION_STRING );
  // Send the HTTP_OK header element.
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_OK_STRING );
  // Send the content type header element.
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_CONTENT_TYPE_JS );

  // Add the cache content header element.
  tx_wr_pos += sprintf( tx_wr_pos, "Cache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0\r\n" );
  
  // Now build the content string and determine it's length. This content is in JSON (Javascript Object Notation)
  // and is easily handled by any browser that understands Javascript.


  progress_str_pos += sprintf( progress_str, "new Object ({ 'state' : '%s', 'percent' : '%d', 'speed' : '%d' })\r\n", progress.state, progress.percent_done, progress.speed );

  content_length = strlen( progress_str );

  // Add the Content-Length header element.
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_CONTENT_LENGTH );
  tx_wr_pos += sprintf( tx_wr_pos, "%d\r\n", content_length );

  // Since the connection will be closed after sending this packet, add the HTTP_CLOSE header element
  // and mark the end of headers by sending HTTP_CR_LF.

  tx_wr_pos += sprintf( tx_wr_pos, HTTP_CLOSE );
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_CR_LF );

  // Now, add in the progress_str content (actual content for a 'GET /PROGRESS' request.
    
  tx_wr_pos += sprintf( tx_wr_pos, "%s", progress_str );

  // Send the reply packet.

  result = send( conn->fd, conn->tx_buffer, (tx_wr_pos - conn->tx_buffer), 0 );
  if (result < 0)
  {
    fprintf( stderr, "[http_send_file] header send returned %d\n", result );
    conn->state = RESET;
    return;
  }
  free( progress_str );
 }  


/*
 * http_send_file_chunk()
 * 
 * This routine will send the next chunk of a file during an open HTTP session
 * where a file is being sent back to the client. This routine is called 
 * repeatedly until the file is completely sent, at which time the connection
 * state will go to "COMPLETE". Doing this rather than sending the entire
 * file allows us (in part) to multiplex between connections "simultaneously".
 */
int http_send_file_chunk(http_conn* conn)
{
  int chunk_sent = 0, ret_code = 0, file_chunk_size = 0, result = 0;
  alt_u8* tx_ptr;
  
  if(conn->data_sent < conn->file_length)
  {
    file_chunk_size = SDRead(conn->tx_buffer,
      MIN(HTTP_TX_BUF_SIZE, (conn->file_length - conn->data_sent)), 
      conn->file_handle);
    
    tx_ptr = conn->tx_buffer;
    
    while(chunk_sent < file_chunk_size)
    {
      result = send(conn->fd, tx_ptr, file_chunk_size, 0);
      
      /* Error - get out of here! */
      if(result < 0)
      {
        fprintf(stderr, "[http_send_file] file send returned %d\n", result);
        ALT_DEBUG_ASSERT(1);
        conn->state = RESET;
        return result;
      }

      /*
       * No errors, but the number of bytes sent might be less than we wanted.
       */
      else
      {
        conn->activity_time = alt_nticks();
        chunk_sent += result;
        conn->data_sent += result;
        tx_ptr += result;
        file_chunk_size -= result;
      }
    } /* while(chunk_sent < file_chunk_size) */
  } /* if(conn->data_sent < conn->file_length) */
  
  /* 
   * We managed to send all of the file contents to the IP stack successfully.
   * At this point we can mark our connection info as complete.
   */
  if(conn->data_sent >= conn->file_length)
  {
    conn->state = COMPLETE;
  }

  return ret_code;
}

/*
 * http_send_file_header()
 *
 * Construct and send an HTTP header describing the now-opened file that is
 * about to be sent to the client.
 */
int http_send_file_header(http_conn* conn, const alt_u8* name, int code)
{
  int     result = 0, ret_code = 0;
  alt_u8* tx_wr_pos = conn->tx_buffer;
  //fpos_t  end, start;
  const alt_u8* ext = strchr(name, '.');

  tx_wr_pos += sprintf(tx_wr_pos, HTTP_VERSION_STRING);

  switch(code)
  {
    /* HTTP Code: "200 OK\r\n" (we have opened the file successfully) */
    case HTTP_OK:
    {
      tx_wr_pos += sprintf(tx_wr_pos, HTTP_OK_STRING);
      break;
    }
    /* HTTP Code: "404 Not Found\r\n" (couldn't find requested file) */
    case HTTP_NOT_FOUND:
    {
      tx_wr_pos += sprintf(tx_wr_pos, HTTP_NOT_FOUND_STRING);
      break;
    }
    default:
    {
      fprintf(stderr, "[http_send_file_header] Invalid HTTP code: %d\n", code);
      conn->state = RESET;
      return -1;
      break;
    }
  }

  /* Handle the various content types */
  tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE);

  if (!strcasecmp(ext, ".html"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_HTML);
  }
  else if (!strcasecmp(ext, ".txt"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_TXT);
  }
  else if (!strcasecmp(ext, ".jpg"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_JPG);
  }
  else if (!strcasecmp(ext, ".gif"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_GIF);
  }
  else if (!strcasecmp(ext, ".png"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_PNG);
  }
  else if (!strcasecmp(ext, ".js"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_JS);
  }
  else if (!strcasecmp(ext, ".css"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_CSS);
  }
  else if (!strcasecmp(ext, ".swf"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_SWF);
  }
  else if (!strcasecmp(ext, ".ico"))
  {
    tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_TYPE_ICO);
  }
  else
  {
    fprintf(stderr, "[http_send_file] Unknown content type: \"%s\"\n", ext);
    conn->state = RESET;
    ALT_DEBUG_ASSERT(1);
    return -1;
  }

  /* Get the file length and stash it into our connection info */
  conn->file_length = SDFilelength( conn->file_handle );

  /* "Content-Length: <length bytes>\r\n" */
  tx_wr_pos += sprintf(tx_wr_pos, HTTP_CONTENT_LENGTH);
  tx_wr_pos += sprintf(tx_wr_pos, "%d\r\n", conn->file_length);

  /* 
   * 'close' will be set during header parsing if the client either specified
   * that they wanted the connection closed ("Connection: Close"), or if they
   * are using an HTTP version prior to 1.1. Otherwise, we will keep the 
   * connection alive. 
   * 
   * We send a specified number of files in a single keep-alive connection,
   * we'll also close the connection. It's best to be polite and tell the client,
   * though.
   */
  if( !conn->keep_alive_count )
  {
    conn->close = 1;
  }
  
  if( conn->close )
  {
    tx_wr_pos += sprintf( tx_wr_pos, HTTP_CLOSE );
  }
  else
  {
    tx_wr_pos += sprintf( tx_wr_pos, HTTP_KEEP_ALIVE );
  }

  /* "\r\n" (two \r\n's in a row means end of headers */
  tx_wr_pos += sprintf(tx_wr_pos, HTTP_CR_LF);

  /* Send the reply header */
  result = send(conn->fd, conn->tx_buffer, (tx_wr_pos - conn->tx_buffer), 
                0);  
                
  if(result < 0)
  {
    fprintf(stderr, "[http_send_file] header send returned %d\n", result);
    conn->state = RESET;
    return result;
  }
  else
  {
    conn->activity_time = alt_nticks();
  }
  
  return ret_code;
}


/*
 * http_find_file()
 *
 * Try to find the file requested. If nothing is requested you get /index.html
 * If we can't find it, send a "404 - Not found" message.
 */
int http_find_file( http_conn* conn )
{
  alt_u8  filename[256];
  alt_u8  full_filename[280];
  int     ret_code = 0;

  // URI of "/" means get the default, usually index.html 
  if ( (conn->uri[0] == '/') && (conn->uri[1] == '\0') )
  {
    strcpy(filename, HTTP_DEFAULT_FILE);
  }
  else
  {
    strcpy( filename, conn->uri+1);
  }

  // Now that we have the filename, let's prepend HTTP_DEFAULT_DIR so that
  //  we can use the generic SD FAT access functions.
  // 

  strcpy( full_filename, HTTP_DEFAULT_DIR );
  strcat( full_filename, "/" );
  strcat( full_filename, filename);
  
  // Try to open the file 
  
  // Open the file using the SDCard file access routines.
  if( (conn->file_handle = (char) SDOpen( full_filename, F_READ )) < 0 )
  {
    printf( "WS ERROR:  Unable to find FAT file with name %s.\n", full_filename );
  }
  
  // Can't find the requested file? Try for a 404-page.
  if (conn->file_handle < 0)
  {
    strcpy(full_filename, HTTP_NOT_FOUND_FILE);
    conn->file_handle = (char) SDOpen(full_filename, F_READ);
    
    // We located the specified "404: Not-Found" page 
    if (conn->file_handle >= 0)
    {
      ALT_DEBUG_ASSERT(fd != NULL);
      ret_code = http_send_file_header(conn, full_filename, HTTP_NOT_FOUND);
    }
    // Can't find the 404 page: This likely means there is no file system.
    else
    {
      fprintf(stderr, "Can't open the 404 File Not Found error page.\n");
      fprintf(stderr, "Have you programmed the filing system into flash?\n");
      send(conn->fd,(void*)canned_http_response,strlen(canned_http_response),0);
      
      SDClose(conn->file_handle);
      conn->state = RESET;
      return -1;  
    }
  }
  // We've found the requested file; send its header and move on.
  else
  {
    printf("\nWS INFO:  Fetching file %s.\n", full_filename );
    ret_code = http_send_file_header(conn, full_filename, HTTP_OK);
  }

  return ret_code;
}


/*
 * http_send_file()
 *
 * This function sends re-directs to either program_flash.html or
 * reset_sytem.html.
 */

void http_send_redirect( alt_u8 redirect[256] )
{
  printf ("Don't do anything....for now.\n");
}

/*
 * http_handle_post()
 *
 * Process the post request and take the appropriate action.
 */
int http_handle_post( http_conn* conn  )
{
  alt_u8* tx_wr_pos = conn->tx_buffer;
  int ret_code = 0;
  
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_VERSION_STRING );
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_NO_CONTENT_STRING );
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_CLOSE );
  tx_wr_pos += sprintf( tx_wr_pos, HTTP_END_OF_HEADER );

  if ( !strcmp( conn->uri, mapping.name ))
  {
    send( conn->fd, conn->tx_buffer, ( tx_wr_pos - conn->tx_buffer ), 0 );
    conn->state = CLOSE;
    mapping.func();
  }
  else if (!strcmp(conn->uri, stats_field.name))
  {
    send( conn->fd, conn->tx_buffer, ( tx_wr_pos - conn->tx_buffer ), 0 );
    conn->state = CLOSE;
    stats_field.func(conn);
  }
  else if ( !strcmp( conn->uri, upload_field.name ))
  {
    conn->file_upload = 1;
    // Populate the progress data structure with initial values.
    //strcpy( progress.state, "starting" );
    //progress.percent_done = 0;
    //progress.speed = 0;
    // Grab some memory and initialize it.
    conn->upload_buffer = malloc( sizeof( upld_buf ));
    conn->upload_buffer->srec_buffer = calloc( SREC_UPLOAD_BUF_SIZE, 1 );
    conn->upload_buffer->srec_rd_pos = conn->upload_buffer->srec_wr_pos = conn->upload_buffer->srec_buffer;
    conn->upload_buffer->bin_buffer = malloc( BINARY_UPLOAD_BUF_SIZE );
    conn->upload_buffer->bin_rd_pos = conn->upload_buffer->bin_wr_pos = conn->upload_buffer->bin_buffer;
  }
  else if (!strcmp(conn->uri, reset_field.name))
  {
    // Close the socket. 
    send(conn->fd, conn->tx_buffer, (tx_wr_pos - conn->tx_buffer), 0);
    reset_field.func();
  }
  return ret_code;
}

int http_handle_get( http_conn* conn )
{
  int ret_code = 0;
  if ( !strcmp( conn->uri, progress_field.name ))
  {
    conn->state = CLOSE;
    progress_field.func( conn );
  }
  else 
  {
    // Find file from uri 
    ret_code = http_find_file( conn );
  }
  return ret_code;
}


/*
 * http_prepare_response()
 * 
 * Service the various HTTP commands, calling the relevant subroutine. 
 * We only handle GET and POST.
 */
int http_prepare_response(http_conn* conn)
{
  int ret_code = 0;
  
  switch( conn->action )
  {
    case GET:
    {
      ret_code = http_handle_get( conn );
      break;
    }
    case POST:
    {
      // Handle POSTs.
      ret_code = http_handle_post( conn );
      break;
    }
    default:
    {
      break;
    }
  } // switch (conn->action)
  
  return ret_code;
}


/*
 * http_handle_receive()
 *
 * Work out what the request we received was, and handle it.
 */
void http_handle_receive( http_conn* conn, int http_instance )
{
  int data_used, rx_code;
  alt_u8* read_head;
  
  if ( conn->state == READY )
  {
    rx_code = recv( conn->fd, 
                    conn->rx_wr_pos, 
                  ( HTTP_RX_BUF_SIZE - ( conn->rx_wr_pos - conn->rx_buffer ) -1 ), 
                    0 );
        
    // 
    // If valid data received, take care of buffer pointer & string 
    // termination and move on. Otherwise, we need to return and wait for more
    // data to arrive (until we time out).
    // 
    if( rx_code > 0 )
    {
      // Increment rx_wr_pos by the amount of data received.
      conn->rx_wr_pos += rx_code;
      // Place a zero just after the data received to serve as a terminator.
      *(conn->rx_wr_pos + 1 ) = 0;
      
      if( strstr( conn->rx_buffer, HTTP_END_OF_HEADER ))
      {
        conn->state = PROCESS;
      }
      // If the connection is a file upload, skip right to DATA.
      if( conn->file_upload == 1 )
      {
        conn->state = DATA;
      }
    }
  }
  
  if( conn->state == PROCESS )
  {
    // If we (think) we have valid headers, keep the connection alive a bit
    // longer.
    conn->activity_time = alt_nticks();
    
    // Attempt to process the fundamentals of the HTTP request. We may 
    // error out and reset if the request wasn't complete, or something
    // was asked from us that we can't handle.
    if( http_process_request( conn ))
    {
      fprintf( stderr, "[http_handle_receive] http_process_request failed\n" );
      conn->state = RESET;
      http_manage_connection( conn, http_instance );
    }
    
    // Step through the headers to see if there is any other useful 
    // information about our pending transaction to extract. After that's 
    // done, send some headers of our own back to let the client know 
    // what's happening. Also, once all in-coming headers have been parsed
    // we can manage our RX buffer to prepare for the next in-coming 
    // connection.
    while( conn->state == PROCESS )
    {
      if( http_read_line( conn ))
      {
        fprintf( stderr, "[http_handle_receive] error reading headers\n" );
        conn->state = RESET;
        http_manage_connection( conn, http_instance );
        break;
      }
      read_head = conn->rx_rd_pos;
      if( http_process_headers( conn ))
      {
        if(( conn->rx_rd_pos = strstr( conn->rx_rd_pos, HTTP_CR_LF )))
        {
          conn->rx_rd_pos += 2;
          conn->state = DATA;
          conn->activity_time = alt_nticks();
        }
        else
        {
          fprintf( stderr, "[http_handle_receive] Can't find end of headers!\n" );
          conn->state = RESET;
          http_manage_connection( conn, http_instance );
          break;
        }
      } 
    } // while(conn->state == PROCESS)
    
    if( http_prepare_response( conn ))
    {
      conn->state = RESET;
      fprintf( stderr, "[http_handle_receive] Error preparing response\n" );
      http_manage_connection( conn, http_instance );
    }
              
    // Manage RX Buffer: Slide any un-read data in our input buffer 
    // down over previously-read data that can now be overwritten, and 
    // zero-out any bytes in question at the top of our new un-read space. 
    if( conn->rx_rd_pos > ( conn->rx_buffer + HTTP_RX_BUF_SIZE ))
    {
      conn->rx_rd_pos = conn->rx_buffer + HTTP_RX_BUF_SIZE;
    }
        
    data_used = conn->rx_rd_pos - conn->rx_buffer;
    memmove( conn->rx_buffer, conn->rx_rd_pos, conn->rx_wr_pos-conn->rx_rd_pos );
    conn->rx_rd_pos = conn->rx_buffer;
    conn->rx_wr_pos -= data_used;
    memset( conn->rx_wr_pos, 0, data_used );
  }
   
  if ( conn->state == DATA && conn->file_upload == 1 )
  {
    // Jump to the file_upload() function....process more received data.
    upload_field.func( conn );
  }
}

/* 
 * http_handle_transmit()
 * 
 * Transmit a chunk of a file in an active HTTP connection. This routine
 * will be called from the thread's main loop when ever the socket is in 
 * the 'DATA' state and the socket is marked as available for writing (free
 * buffer space). 
 */
void http_handle_transmit(http_conn* conn, int http_instance)
{
  if( http_send_file_chunk(conn) )
  {
    fprintf(stderr, "[http_handle_transmit]: Send file chunk failed\n");
  }
}

/* Simple function which sends an IP Address to the App Selector GUI
 * via a message mailbox.
 */
void send_ip_addr()
{
  sprintf( ws_msg_string, "IP: %d.%d.%d.%d",
            ip4_addr1( nets[0]->n_ipaddr ),
            ip4_addr2( nets[0]->n_ipaddr ),
            ip4_addr3( nets[0]->n_ipaddr ),
            ip4_addr4( nets[0]->n_ipaddr ));
  if( InMainMenu )
  {
    while( OSMboxPost( As_WebserverStatusMbox, &ws_msg_string ) != OS_NO_ERR );
  }
}

/* Callback function for when the Interniche DHCP subsystem acquires
 * an IP address.  This overrides dhc_main_ipset() to add GUI messages.
 */
int ws_ipset( int iface, int state )
{
  if ( state == DHCS_BOUND )
  {
    /* print IP address acquired through DHCP Client - for user's benefit */
    printf("Acquired IP address via DHCP client for interface: %s\n",
            nets[iface]->name);

    printf("IP address : %s\n", print_ipad(nets[iface]->n_ipaddr));
    printf("Subnet Mask: %s\n", print_ipad(nets[iface]->snmask));
    printf("Gateway    : %s\n", print_ipad(nets[iface]->n_defgw));
    if( InMainMenu )
    {
      send_ip_addr();
    }
  }
  return 0;
}

INT8U suspend_network_tasks()
{
  INT8U err = OS_NO_ERR;
  err = ( OSTaskSuspend( AS_HTTP_PRIO )|
        OSTaskSuspend( TK_NETMAIN_TPRIO )|
        OSTaskSuspend( TK_NETTICK_TPRIO) );
  return( err );
}

INT8U resume_network_tasks()
{
  INT8U err = OS_NO_ERR;
  err = ( OSTaskResume( TK_NETMAIN_TPRIO )|
        OSTaskResume( TK_NETTICK_TPRIO )|
        OSTaskResume( AS_HTTP_PRIO ) );
  return( err );
}
  

/*
 * "Pre" network initialization PHY detection.
 */

INT8U wait_on_phy()
{
  int phyadd;
  int phyid;
  int phyid2 = 0;
  np_tse_mac* pmac;

  //Initialize the structure necessary for "pmac" to function.

  pmac = (np_tse_mac*) TSE_MAC_BASE;

  // Find phyid...assuming it's National's PHY....for now.
  
  for( phyadd = 0x00; phyadd < 0xff; phyadd++ )
  {
    IOWR(&pmac->MDIO_ADDR0, 0, phyadd);
    phyid = IORD(&pmac->mdio0.PHY_ID1, 0);
    phyid2 = IORD(&pmac->mdio0.PHY_ID2, 0);
    
    if( phyid != phyid2 )
    {
      printf("\n\n\nPHY INFO:  [phyid] 0x%x %x %x\n", phyadd, phyid, phyid2);
      phyadd = 0xff;
    }
  }

  // Issue a PHY reset.
  IOWR(&pmac->mdio0.CONTROL, 0, PCS_CTL_an_enable | PCS_CTL_sw_reset);
  if( ( ( IORD(&pmac->mdio0.CONTROL,0) & PCS_CTL_rx_slpbk) != 0 ) ||
      ( ( IORD(&pmac->mdio0.STATUS,0) & PCS_ST_an_done) == 0) )
  {
    IOWR(&pmac->mdio0.CONTROL, 0, PCS_CTL_an_enable | PCS_CTL_sw_reset);
    printf( "PHY INFO:  Issuing PHY Reset\n" );
  }

  // Holding pattern until autonegotiation completes.

  if(( IORD( &pmac->mdio0.STATUS, 0 ) & PCS_ST_an_done ) == 0 )
  {
    printf( "PHY INFO:  waiting on PHY link...\n" );
    while(( IORD( &pmac->mdio0.STATUS, 0 ) & PCS_ST_an_done ) == 0 )
    {
      OSTimeDlyHMSM( 0, 0, 0, 10 );
    }
    printf( "PHY INFO:  PHY link detected, allowing network to start.\n\n\n\n" );
    resume_network_tasks();
    printf( "WS INFO:  Connecting...\n\n\n\n" );
    sprintf( ws_msg_string, "Connecting...\n\n" );
    if( InMainMenu )
    {
      while( OSMboxPost( As_WebserverStatusMbox, &ws_msg_string ) != OS_NO_ERR );
    }
  }
  TK_SLEEP(3);
  return( 0 );
}
  

/*
 * Network initialization function.
 */

INT8U net_init()
{
  INT8U return_code = OS_NO_ERR;

  system_dhcp_hostname = "NEEK_1";

#ifdef DHCP_CLIENT
  // Register new DHCP "IP attained" callback function.
  // If DHCP is acquired, ws_ipset will be called instead of dhc_main_ipset().
  dhc_set_callback( 0, ws_ipset );
#endif /*DHCP_CLIENT*/
	
  /*
   * Initialize Altera NicheStack TCP/IP Stack - Nios II Edition specific code.
   * NicheStack is initialized from a task, so that RTOS will have started, and 
   * I/O drivers are available.  Two tasks are created:
   *    "Inet main"  task with priority 2
   *    "clock tick" task with priority 3
   */   
  alt_iniche_init();
  /* Start the Iniche-specific network tasks and initialize the network
   * devices.
   */
  netmain();
  /* Wait for the network stack to be ready before proceeding. */
  while (!iniche_net_ready)
  {
    TK_SLEEP(1);
    //Allow other tasks to run, while waiting for network.
    OSTimeDlyHMSM(0, 0, 3, 0);
  }
  TK_NEWTASK( &wstask );
  // Send the initialy acquired IP Address to the touch panel GUI.
  //send_ip_addr();
  current_flash_block = -1;
  return return_code;
}

/*
 * Network Management Task.
 */

void NetManTask()
{
  INT8U return_code = OS_NO_ERR;
  unsigned int status;

  wait_on_phy();

  if( net_init() != OS_NO_ERR )
  {
    //If network initialization fails, pass a message to the touchpanel GUI and then kill this task.
    sprintf( ws_msg_string, "Net Init Failed!" );
    if( InMainMenu )
    {
      while( OSMboxPost( As_WebserverStatusMbox, &ws_msg_string ) != OS_NO_ERR );
    }
    return_code = OSTaskDel( OS_PRIO_SELF );
  }
  // Populate the local pmac structure upon successful network initialization.
  np_tse_mac* pmac = (np_tse_mac*) tse.mi.base;
  // Set a counter to allow for a brief network disconnect.
  int disconnect_count = 0;
  // Now, start a loop that monitors the status of a single network PHY every 5 seconds
  // (approximately) and acts to maintain a "healthy" network connection.
  // The possible states are:
  //  Connected
  //  Disconnected
  //
  while(1)
  {
    OSTimeDlyHMSM(0, 0, 1, 0);
    status = IORD( &pmac->mdio0.STATUS, 0 );
    if( !(status & 0x20) )
    {
      disconnect_count++;
      if( disconnect_count == MAX_CABLE_DOWN )
      {
        sprintf( ws_msg_string, "Cable Disconnected!" );
        printf( "\nPHY ERROR:  Ethernet Cable Disconnected!\n" );
        if( suspend_network_tasks() != OS_NO_ERR )
        {
          printf( "WS INFO:  Error suspending network tasks!\n" );
        }
        if( InMainMenu )
        { 
          while( OSMboxPost( As_WebserverStatusMbox, &ws_msg_string ) != OS_NO_ERR );
        }
      }
    }
    else
    {
      // If the cable was previously disconnected, detect this, reset the PHY and
      // initiate the DHCP discovery process to obtain an IP Address.
      if( disconnect_count > 0 )
      {
        // Issue a PHY Reset.
        wait_on_phy();
        printf( "PHY INFO:  Cable Reconnected!\n" );
        TK_SLEEP(1); 
#ifdef DHCP_CLIENT
        // Force re-acquisition of existing IP Address.
		// If that fails, the Iniche DHCP state machine should
		// fall through to DHCP discovery.
        dhc_set_state( 0, DHCS_INITREBOOT );
#endif /*DHCP_CLIENT*/
      }
      // Reset the disconnect counter.
      disconnect_count = 0;
    }
  }
}

/* Function which is called from within main() to start networking. */

void NETInit()
{
  INT8U return_code = OS_NO_ERR;
  // Define the network initialization/maintenance task.

  return_code = OSTaskCreateExt( NetManTask,
                                 NULL,
                                 (void *)&netman_task_stk[AS_NETMAN_TASK_STACKSIZE],
                                 AS_NETMAN_PRIO,
                                 AS_NETMAN_PRIO,
                                 netman_task_stk,
                                 AS_NETMAN_TASK_STACKSIZE,
                                 NULL,
                                 OS_TASK_OPT_STK_CHK + OS_TASK_OPT_STK_CLR );
  alt_uCOSIIErrorHandler( return_code, 0 );

  // Initialize the "progress" data structure.

  strcpy( progress.state,"inactive" );
  progress.percent_done = 0;
  progress.speed = 0;

} 

/*
 * WStask()
 * 
 * This MicroC/OS-II thread spins forever after first establishing a listening
 * socket for HTTP connections, binding them, and listening. Once setup,
 * it perpetually waits for incoming data to either a listening socket, or
 * (if there is an active connection), an HTTP data socket. When data arrives, 
 * the approrpriate routine is called to either accept/reject a connection 
 * request, or process incoming data.
 * 
 * This routine calls "select()" to determine which sockets are ready for
 * reading or writing. This, in conjunction with the use of non-blocking 
 * send() and recv() calls and sending responses broken up into chunks lets
 * us handle multiple active HTTP requests.
 */
TK_ENTRY(WSTask)
{
  int     i, fd_listen, max_socket;
  struct  sockaddr_in addr;
  struct  timeval select_timeout;
  fd_set  readfds, writefds;
  static  http_conn     conn[HTTP_NUM_CONNECTIONS];

  /*
   * Sockets primer...
   * The socket() call creates an endpoint for TCP of UDP communication. It 
   * returns a descriptor (similar to a file descriptor) that we call fd_listen,
   * or, "the socket we're listening on for connection requests" in our web
   * server example.
   */ 
  if ((fd_listen = socket(AF_INET, SOCK_STREAM, 0)) < 0)
  {
    die_with_error("[WSTask] Listening socket creation failed");
  }
  
  /*
   * Sockets primer, continued...
   * Calling bind() associates a socket created with socket() to a particular IP
   * port and incoming address. In this case we're binding to HTTP_PORT and to
   * INADDR_ANY address (allowing anyone to connect to us. Bind may fail for 
   * various reasons, but the most common is that some other socket is bound to
   * the port we're requesting. 
   */ 
  addr.sin_family = AF_INET;
  addr.sin_port = htons(HTTP_PORT);
  addr.sin_addr.s_addr = INADDR_ANY;
    
  if ((bind(fd_listen,(struct sockaddr *)&addr,sizeof(addr))) < 0)
  {
    die_with_error("[WSTask] Bind failed");
  }
    
  /*
   * Sockets primer, continued...
   * The listen socket is a socket which is waiting for incoming connections.
   * This call to listen will block (i.e. not return) until someone tries to 
   * connect to this port.
   */ 
  if ((listen(fd_listen,1)) < 0)
  {
    die_with_error("[WSTask] Listen failed");
  }

  /* 
   * At this point we have successfully created a socket which is listening
   * on HTTP_PORT for connection requests from any remote address.
   */
  for(i=0; i<HTTP_NUM_CONNECTIONS; i++)
  {
    http_reset_connection(&conn[i], i);
  }
   
  while(1)
  {
    /* 
     * The select() call below tells the stack to return  from this call 
     * when any of the events we have expressed an interest in happen (it 
     * blocks until our call to select() is satisfied). 
     * 
     * In the call below we're only interested in either someone trying to 
     * connect to us, or when an existing (active) connection has new receive 
     * data, or when an existing connection is in the "DATA" state meaning that
     * we're in the middle of processing an HTTP request. If none of these 
     * conditions are satisfied, select() blocks until a timeout specified 
     * in the select_timeout struct.
     * 
     * The sockets we're interested in (for RX) are passed in inside the 
     * readfds parameter, while those we're interested in for TX as passed in 
     * inside the writefds parameter. The format of readfds and writefds is 
     * implementation dependant, hence there are standard macros for 
     * setting/reading the values:
     * 
     *   FD_ZERO  - Zero's out the sockets we're interested in
     *   FD_SET   - Adds a socket to those we're interested in
     *   FD_ISSET - Tests whether the chosen socket is set 
     */
    FD_ZERO(&readfds);
    FD_ZERO(&writefds);
    FD_SET(fd_listen, &readfds);
    
    max_socket = fd_listen+1;
    
    for(i=0; i<HTTP_NUM_CONNECTIONS; i++)
    {
      if (conn[i].fd != -1)
      {
        /* We're interested in reading any of our active sockets */
        FD_SET(conn[i].fd, &readfds);
        
        /* 
         * We're interested in writing to any of our active sockets in the DATA
         * state
         */
        if(conn[i].state == DATA)
        {
          FD_SET(conn[i].fd, &writefds);
        }
        
        /*
         * select() must be called with the maximum number of sockets to look 
         * through. This will be the largest socket number + 1 (since we start
         * at zero).
         */
        if (max_socket <= conn[i].fd)
        {
          max_socket = conn[i].fd+1;
        }
      }
    }

    /* 
     * Set timeout value for select. This must be reset for each select()
     * call.
     */
    select_timeout.tv_sec = 0;
    select_timeout.tv_usec = 500000;

    select( max_socket, &readfds, &writefds, NULL, &select_timeout );

    /* 
     * If fd_listen (the listening socket we originally created in this thread
     * is "set" in readfds, then we have an incoming connection request. 
     * We'll call a routine to explicitly accept or deny the incoming connection 
     * request.
     */
    if (FD_ISSET(fd_listen, &readfds))
    {
      http_handle_accept(fd_listen, conn);
    }

    /*
     * If http_handle_accept() accepts the connection, it creates *another*
     * socket for sending/receiving data. This socket is independant of the 
     * listening socket we created above. This socket's descriptor is stored 
     * in conn[i].fd. Therefore if conn[i].fd is set in readfs, we have
     * incoming data for our HTTP server, and we call our receive routine
     * to process it. Likewise, if conn[i].fd is set in writefds, we have
     * an open connection that is *capable* of being written to.
     */
    for(i=0; i<HTTP_NUM_CONNECTIONS; i++)
    {
      if (conn[i].fd != -1)
      { 
        if(FD_ISSET(conn[i].fd,&readfds))
        {
          http_handle_receive(&conn[i], i);
        }
        
        if(FD_ISSET(conn[i].fd,&writefds))
        {
          http_handle_transmit(&conn[i], i);
        }
        
        http_manage_connection(&conn[i], i);
      }
    }  
  } /* while(1) */
}

/*
 * die_with_error()
 * 
 * This routine is just called when a blocking error occurs with the example
 * design. It deletes the current task.
 */
void die_with_error(char err_msg[DIE_WITH_ERROR_BUFFER])
{
  printf("\n%s\n", err_msg);
  OSTaskDel(OS_PRIO_SELF);
  
  while(1);
}

error_t get_board_mac_addr(unsigned char mac_addr[6],struct device *device)
{
  error_t error = 0;

  alt_u32 signature = 0;

  alt_two_wire s_eeprom;
  alt_two_wire* eeprom = &s_eeprom;

/* Initialize the EEPROM. */
  
  eeprom->scl_pio = PIO_ID_EEPROM_SCL_BASE;
  eeprom->sda_pio = PIO_ID_EEPROM_DAT_BASE;

  alt_2_wireInit(eeprom);
  alt_2_wireSetDelay(10);

  printf("EEPROM device 24LC%d size is %x\n", device->id, device->size);

  char *buf = malloc(10);

  if (!error)
  {
    if(!readRandom(device, 0, buf, 10)) {
      printf( "Successfully read 16 bytes from EEPROM.\n");
      signature = (buf[2]*0x10000 & 0xff0000) + (buf[3]*0x100 & 0xff00) + (buf[4] & 0xff);
    }
    printf( "Signature = 0x%x.\n", (unsigned int) signature);
    if (signature != 0x0007ed)
    {
      printf( "Your EEK LCD daughtercard is not programmed with a correct MAC Address!\n");
      printf( "Please contact Altera support for instructions on how to correct this problem!\n");
    }
  }
  
  if (!error)
  {
    mac_addr[0] = buf[2] & 0xFF;
    mac_addr[1] = buf[3] & 0xFF;
    mac_addr[2] = buf[4] & 0xFF;
    mac_addr[3] = buf[5] & 0xFF;
    mac_addr[4] = buf[6] & 0xFF;
    mac_addr[5] = buf[7] & 0xFF;
    
    printf("Your Ethernet MAC address is %02x:%02x:%02x:%02x:%02x:%02x\n", 
            mac_addr[0],
            mac_addr[1],
            mac_addr[2],
            mac_addr[3],
            mac_addr[4],
            mac_addr[5]);

  }
  free(buf);
  
  return error;
}


/*
* get_mac_addr
*
* Read the MAC address in a board specific way
*
*/
int get_mac_addr(NET net, unsigned char mac_addr[6])
{
    return (get_board_mac_addr(mac_addr, device));
}

/*
 * get_ip_addr()
 * 
 * This routine is called by InterNiche to obtain an IP address for the
 * specified network adapter. Like the MAC address, obtaining an IP address is
 * very system-dependant and therefore this function is exported for the
 * developer to control.
 *
 * In our system, we are either attempting DHCP auto-negotiation of IP address,
 * or we are setting our own static IP, Gateway, and Subnet Mask addresses our
 * self. This routine is where that happens.
 */
int get_ip_addr(alt_iniche_dev *p_dev,
                ip_addr* ipaddr,
                ip_addr* netmask,
                ip_addr* gw,
                int* use_dhcp)
{

    IP4_ADDR(*ipaddr, IPADDR0, IPADDR1, IPADDR2, IPADDR3);
    IP4_ADDR(*gw, GWADDR0, GWADDR1, GWADDR2, GWADDR3);
    IP4_ADDR(*netmask, MSKADDR0, MSKADDR1, MSKADDR2, MSKADDR3);

#ifdef DHCP_CLIENT
    *use_dhcp = 1;
#else /* not DHCP_CLIENT */
    *use_dhcp = 0;

    printf("Static IP Address is %d.%d.%d.%d\n",
        ip4_addr1(*ipaddr),
        ip4_addr2(*ipaddr),
        ip4_addr3(*ipaddr),
        ip4_addr4(*ipaddr));
#endif /* not DHCP_CLIENT */

    /* Non-standard API: return 1 for success */
    return 1;
}

/* Function which resets the system.  Initiated through the Reset System form. 
 */
void reconfig_fpga()
{
  volatile int hw_offset = RECONFIG_ADDRESS;
  
  printf("WS RESET:  Reconfiguring to offset 0x%x.\n", hw_offset );
  printf("%c", 0x4);
  // Sleep...(hopefully) long enough to print out the message, then reconfigure.
  OSTimeDlyHMSM(0, 0, 3, 0);
  AsReconfigFPGA( hw_offset );
}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2008 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
