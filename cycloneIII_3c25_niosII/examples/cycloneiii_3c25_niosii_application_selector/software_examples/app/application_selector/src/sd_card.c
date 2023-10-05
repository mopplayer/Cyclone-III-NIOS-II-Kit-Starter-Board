
/*****************************************************************************
 *  File: sd_card.c
 * 
 *  This file contains functions for performing general tasks associated
 *  with the sd card.
 * 
 ****************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "includes.h"
#include "elca_fat.h"
#include "sd_card.h"
#include "os_utils.h"


// Message boxes for communication with the SD Card task.
OS_EVENT* As_SDCardComMbox;
OS_EVENT* As_SDCardRespMbox;

/*****************************************************************************
 *  Function: SDChdirLongName
 *
 *  Purpose: Changes directories in the SD Card to a directory with the long
 *           filename "dirname[]"
 * 
 *  Returns: 0 - Success
 *          -1 - Failure
 ****************************************************************************/
int SDChdirLongName( char dirname[] )
{
  int found_dir = 0;
  int ret_code = 0;
  char fixed_shortname[16];

  // Clear the shortname and longname since the elca_findx functions dont do it for us.
  memset( ffblk.ff_longname, 0x0, _MAX_NAME );
  memset( ffblk.ff_name, 0x0, 12 );

  // Look for any directories who's long or short names match ours
  if( elca_findfirst() != 0 ) //Find first file
  {
    do
    {
       // Reformat the short filename from the weird way El Camino does it.
       SDStringToLower( ffblk.ff_name, fixed_shortname );
       if( memchr( fixed_shortname, '.', strlen( fixed_shortname ) ))
       {
         *((char*)strrchr( fixed_shortname, '.' )) = '\0';
       }
      
      if (( ffblk.ff_attr == ATTR_DIRECTORY ) && ( ffblk.ff_name[0] != '.' ))
      {
        if(( !strcmp( fixed_shortname, dirname )) ||
           ( !strcmp( ffblk.ff_longname, dirname )))
        {
          found_dir = 1;
          break;
        }
      }
      // Clear the shortname and longname since the elca_findx functions dont do it for us.
      memset( ffblk.ff_longname, 0x0, _MAX_NAME );
      memset( ffblk.ff_name, 0x0, 12 );
    } while( elca_findnext() != 0 ); //Find next file or directory
  }

  if( found_dir )
  {
    ret_code = elca_chdir( ffblk.ff_name );
  }
  else
  {
    ret_code = -1;
  }

  return( ret_code );
}


/*****************************************************************************
 *  Function: SDOpenLongName
 *
 *  Purpose: Opens a file on the SD Card with the long
 *           filename "filename[]"
 * 
 *  Returns: file_handle > 0 - Success
 *          -1               - Failure
 ****************************************************************************/
char SDOpenLongName( char filename[], unsigned char attr )
{
  int found_file = 0;
  char ret_code;
  char fixed_shortname[16];

  // Look for any directories who's long or short names match ours
  if( elca_findfirst() != 0 ) //Find first file
  {
    do
    {
      // Reformat the short filename from the weird way El Camino does it.
      SDStringToLower( ffblk.ff_name, fixed_shortname );
      
      if (( ffblk.ff_attr == ATTR_FILE ) && ( ffblk.ff_name[0] != '.' ))
      {
        if(( !strcmp( fixed_shortname, filename )) ||
           ( !strcmp( ffblk.ff_longname, filename )))
        {
          found_file = 1;
          break;
        }
      }
    } while( elca_findnext() != 0 ); //Find next file or directory
  }

  if( found_file )
  {
    ret_code = elca_fopen( ffblk.ff_name, attr );
  }
  else
  {
    ret_code = -1;
  }

  return( ret_code );
}

/*****************************************************************************
 *  Function: SDStringToLower
 *
 *  Purpose: Converts a string to lower case, and removes any spaces from it.
 *           The space-removal is neccessary because the El Camino FAT
 *           fat filesystem code returns short filenames with spaces between
 *           the filename and the "." if the filename is fewer than 8 
 *           characters
 * 
 *  Returns: 0
 ****************************************************************************/
int SDStringToLower( char src_string[], char dest_string[] )
{
  int src_index = 0;
  int dest_index = 0;
  
  while( src_string[src_index] != '\0' )
  {
    if( src_string[src_index] != ' ' )
    {
      if(( src_string[src_index] >= 'A' ) &&
         ( src_string[src_index] <= 'Z' ))
      {
        dest_string[dest_index] = src_string[src_index] + 32;
      }
      else
      {
        dest_string[dest_index] = src_string[src_index];
      }
      dest_index++;
    }
    src_index++;
  }
  dest_string[dest_index] = '\0';
  
  return( 0 );
}


/*****************************************************************************
 *  Function: SDls
 *
 *  Purpose: Parses the contents of the SD directory dir_listing->dirpath
 *           and returns it in the structure "dir_listing"
 * 
 *  Returns: 0 - success
 *          -1 - failure
 ****************************************************************************/
int SDls( sdcard_dir_listing* dir_listing )
{
  
  sdcard_com_message sdcard_com_message;
  sdcard_resp_message* sdcard_resp_message;
  INT8U err;
    
  sdcard_com_message.command = SDCARD_LISTING;
  strcpy( sdcard_com_message.filepath, dir_listing->dirpath );
  sdcard_com_message.data = (void*)dir_listing;
  while( OSMboxPost( As_SDCardComMbox, &sdcard_com_message ) != OS_NO_ERR );
  sdcard_resp_message = OSMboxPend( As_SDCardRespMbox, 0, &err );
  
  if( err || sdcard_resp_message->error || dir_listing->error )
  { 
    return( -1 );
  }
  else
  {
    return( 0 );
  }
}
 

/*****************************************************************************
 *  Function: SDChdirAbsPath
 *
 *  Purpose: Changes to an absolute path directory.  Supports both long 
 *           and short names.  Can also put a filename on the end of the path
 *           However if you pass in a directory only (no file on end), the
 *           path must end with a /.
 * 
 *  Returns: Number of directory levels descended to reach target directory
 * 
 ****************************************************************************/
int SDChdirAbsPath( char abspath[] )
{
  int num_levels;
  char temppathstaticarray[256];
  char* temppath = &(temppathstaticarray[0]);
  char tempdir[256];
  char* slashptr; 
  
  strcpy( temppath, abspath );
  
  for( num_levels = 0; ; num_levels++ )
  {
    slashptr = strchr( temppath, '/' );
    if( !slashptr )
    {
      // There was no slash in the remaining path, so lets make sure what remains
      // is a directory by trying to cd to it.
      if( SDChdirLongName( temppath ) == ELCA_F_OK )
      {
        num_levels++;
      }
      // If what's left is not a directory, we should return 0 to indicate failure
      // But first, we need to walk back up whatever directories we've descended. 
      else
      {
        while( num_levels > 0 )
        {
          elca_chdir( ".." );
          num_levels--;
        }
      }
      break;
    }
    else
    {
      // Clear tempdir before we copy anything into it since it may contain
      // stale data
      memset( tempdir, 0x0, 256 );
      strncpy( tempdir, temppath, slashptr - temppath );
      if( SDChdirLongName( tempdir ) != ELCA_F_OK )
        break;
      temppath = slashptr + 1;
    }
  }
  
  return( num_levels );
}


void SDCardTask( void* pdata )
{
  int num_levels;
  int i;
  INT8U err;
  
  char* filename;  
  char* slashptr;
  char tempname[256];
  
  sdcard_com_message* sdcard_com_message;
  sdcard_resp_message sdcard_resp_message;

  As_SDCardComMbox = OSMboxCreate((void *)0);  
  As_SDCardRespMbox = OSMboxCreate((void *)0);  


  // Mount the SD Card.  Make 100 attempts before giving up.
  for( i = 0; i < 100; i++ )
  {
    if( elca_fat_mount( EL_CAMINO_SD_CARD_CONTROLLER_NAME ) >= 0 )
      break;
  }

  if( i == 100 )
  {
//    OSPrintf("ERROR: Failed to mount %s\n", EL_CAMINO_SD_CARD_CONTROLLER_NAME );
  }
    
  while (1)
  {
    // Wait for a message asking for SD Card action
    sdcard_com_message = OSMboxPend( As_SDCardComMbox, 0, &err );
    if ( err == OS_NO_ERR ) 
    {
      // Task implementation of elca_fopen
      if( sdcard_com_message->command == SDCARD_OPEN )
      {
        slashptr = strrchr( sdcard_com_message->filepath, '/' );
        filename = slashptr + 1;
        *slashptr = 0x0;
        num_levels = SDChdirAbsPath( sdcard_com_message->filepath );

        sdcard_resp_message.file_handle = (char) SDOpenLongName( filename, sdcard_com_message->flag );
        if( sdcard_resp_message.file_handle < 0 )
        {
          sdcard_resp_message.error = SDCARD_ERROR;
        }
        else
        {
          sdcard_resp_message.error = 0;
        }

        // Walk back down the dir tree for next time since el camino doesnt let you 
        // change back to the root.
        for( ; num_levels > 0; num_levels-- )
        {
          elca_chdir( ".." );
        }
      }
      // Task implementation of elca_filelength
      else if( sdcard_com_message->command == SDCARD_FILELENGTH )
      {
        if( sdcard_com_message->file_handle >= 0 )
        {
          sdcard_resp_message.num_bytes = elca_filelength( sdcard_com_message->file_handle );
          sdcard_resp_message.error = 0;
        }
        else
        {
          sdcard_resp_message.error = SDCARD_ERROR;
        }
      }
      // Task implementation of elca_fread
      else if( sdcard_com_message->command == SDCARD_READ )
      {
        if( sdcard_com_message->file_handle >= 0 )
        {
          sdcard_resp_message.num_bytes = elca_fread( sdcard_com_message->data, 
                                                      sdcard_com_message->num_bytes, 
                                                      sdcard_com_message->file_handle );
          sdcard_resp_message.error = 0;
        }
        else
        {
          sdcard_resp_message.error = SDCARD_ERROR;
        }
      } 
      // Task implementation of elca_fclose
      else if( sdcard_com_message->command == SDCARD_CLOSE )
      {
        // El Camino provides no error detection capability for closing a file, so 
        // we'll just do it blindly.
        elca_fclose( sdcard_com_message->file_handle );
      }
      else if( sdcard_com_message->command == SDCARD_LISTING )
      {
        sdcard_dir_listing* dir_listing = (sdcard_dir_listing*)sdcard_com_message->data;
        dir_listing->num_found = 0;
        num_levels = SDChdirAbsPath( sdcard_com_message->filepath );
        if( num_levels > 0 )
        {
          // El Camino does not clean the name fields between "finds", so we do it manually.
          memset( ffblk.ff_longname, 0x0, _MAX_NAME );
          // Find all the sub-dirs in the app root dir
          if( elca_findfirst() != 0 ) //Find first file
          {
            i = 0;
            do
            {
              // Save off our directory name, because it gets overwritten when we
              // look at the files contained within it.
              if( ffblk.ff_longname[0] != 0 )
              {
                strcpy( tempname, ffblk.ff_longname );
              }
              // If the name was a short filename only, El Camino does not copy it to the
              // longname structure element, so we need to go get the short name and format
              // it properly.
              else
              {
                // Deal with the strange way El Camino formats the short filename.
                SDStringToLower( ffblk.ff_name, tempname );
                // Remove the '.' from the end of the name if it's a dir.
                if(( memchr( tempname, '.', _MAX_NAME )) &&
                   ( ffblk.ff_attr == ATTR_DIRECTORY ))
                {
                  *((char*)strrchr( tempname, '.' )) = '\0';
                }
              }
              strcpy( dir_listing->filenames[i], tempname );
              i++;
              
              // El Camino does not clean the name fields between "finds", so we do it manually.
              memset( ffblk.ff_longname, 0x0, _MAX_NAME );
            } while ( elca_findnext() != 0 ); //Find next file or directory
          }
          
          // Walk back down the dir tree for next time since el camino doesnt let you 
          // change back to the root.
          for( ; num_levels > 0; num_levels-- )
          {
            elca_chdir( ".." );
          }
          
          dir_listing->num_found = i;
          dir_listing->error = 0;
          sdcard_resp_message.error = 0;
        }
        else
        {
          sdcard_resp_message.error = SDCARD_ERROR;          
        }
      }
      
      while( OSMboxPost( As_SDCardRespMbox, &sdcard_resp_message ) != OS_NO_ERR );
    }
  }
}

char SDOpen( char fullfilename[], unsigned char flag )
{
  
  sdcard_com_message sdcard_com_message;
  sdcard_resp_message* sdcard_resp_message;
  INT8U err;
    
  sdcard_com_message.command = SDCARD_OPEN;
  sdcard_com_message.flag = flag;
  strcpy( sdcard_com_message.filepath, fullfilename );
  while( OSMboxPost( As_SDCardComMbox, &sdcard_com_message ) != OS_NO_ERR );
  sdcard_resp_message = OSMboxPend( As_SDCardRespMbox, 0, &err );
  
  if( err || sdcard_resp_message->error )
  {
    return( -1 );
  }
  else
  {
    return( sdcard_resp_message->file_handle );
  }
}

int SDFilelength( char filehandle )
{
  
  sdcard_com_message sdcard_com_message;
  sdcard_resp_message* sdcard_resp_message;
  INT8U err;

  sdcard_com_message.command = SDCARD_FILELENGTH;
  sdcard_com_message.file_handle = filehandle;
  while( OSMboxPost( As_SDCardComMbox, &sdcard_com_message ) != OS_NO_ERR );
  sdcard_resp_message = OSMboxPend( As_SDCardRespMbox, 0, &err );
  
  if( err || sdcard_resp_message->error )
  {
    return( -1 );
  }
  else
  {
    return( sdcard_resp_message->num_bytes );
  }
}


unsigned int SDRead( char* buffer, unsigned int bytecount, char filehandle )
{
  
  sdcard_com_message sdcard_com_message;
  sdcard_resp_message* sdcard_resp_message;
  INT8U err;

  sdcard_com_message.command = SDCARD_READ;
  sdcard_com_message.file_handle = filehandle;
  sdcard_com_message.data = buffer;
  sdcard_com_message.num_bytes = bytecount;
  while( OSMboxPost( As_SDCardComMbox, &sdcard_com_message ) != OS_NO_ERR );
  sdcard_resp_message = OSMboxPend( As_SDCardRespMbox, 0, &err );
  
  if( err || sdcard_resp_message->error )
  {
    return( 0 );
  }
  else
  {
    return( sdcard_resp_message->num_bytes );
  }
}

void SDClose( char filehandle )
{
  
  sdcard_com_message sdcard_com_message;
  sdcard_resp_message* sdcard_resp_message;
  INT8U err;

  sdcard_com_message.command = SDCARD_CLOSE;
  sdcard_com_message.file_handle = filehandle;
  while( OSMboxPost( As_SDCardComMbox, &sdcard_com_message ) != OS_NO_ERR );
  sdcard_resp_message = OSMboxPend( As_SDCardRespMbox, 0, &err );
  
  // There is no error detection for closing a file, so we do nothing here.  
}

