/*****************************************************************************
 *  File: app_selector.c
 * 
 *  This file contains functions for performing general tasks associated
 *  with the application selector.
 * 
 ****************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <sys/alt_alarm.h>
#include <string.h>
#include "includes.h"
#include "os_utils.h"
#include "webserver.h"
#include "sys/alt_cache.h"
#include "sys/alt_flash.h"
#include "sys/alt_flash_dev.h"
#include "system.h"
#include "alt_types.h"
#include "io.h"
#include "app_selector.h"
#include "app_selector_gui.h"
#include "altera_avalon_pio_regs.h"
#include "alt_video_display.h"
#include "alt_tpo_lcd.h"
#include "elca_fat.h"
#include "srec/srec.h"
#include "flash_intel_p30.h"
#include "sd_card.h"

// Flash semaphore
extern OS_EVENT *FlashSem;

/*****************************************************************************
 *  Function: AsInitTpoLcd
 *
 *  Purpose: Initializes the gamma and resolution of the LCD screen
 * 
 *  Returns: 0
 ****************************************************************************/
int AsInitTpoLcd( alt_tpo_lcd* lcd_serial )
{

  // Specify base addresses of the each communication bus PIO,
  // as defined in system.h
  lcd_serial->scen_pio = LCD_I2C_EN_BASE;
  lcd_serial->scl_pio  = LCD_I2C_SCL_BASE;
  lcd_serial->sda_pio  = LCD_I2C_SDAT_BASE;

  // Write the default gamma curve, use 800x480 resolution (default),
  // and verify that the LCD is alive by reading back its Chip/ID
  // register. Most users will only need to call this routine, and
  // verify that it completed successfully.
  alt_tpo_lcd_init( lcd_serial, ALT_VIDEO_DISPLAY_COLS, ALT_VIDEO_DISPLAY_ROWS );

  return( 0 );
}


/*****************************************************************************
 *  Function: AsLoadAppFromSDCard
 *
 *  Purpose: Loads both the hardware and software elements of an application 
 *           from the SD Card into flash, then reconfigures the FPGA to run 
 *           the application.
 * 
 *           This function uses a simple caching mechanism to hold recently 
 *           used hardware images in CFI flash to avoid having to spend time
 *           loading frequently used applications from SD Card and 
 *           programming them to flash.  Only hardware images are cached.
 *           Software images are typically smaller, and do not consume as much
 *           time to load from SD Card.
 * 
 *           The caching mechanism uses a flash cataloging scheme referred to
 *           as "Zero = Spent, 'F' = Available", or ZSFA.  This scheme avoids
 *           erasing entire flash sectors when only a few words need to be 
 *           written to the flash.  Using ZSFA, a word in the flash which is 
 *           0x0 is considered "spent" and cannot be used to store data.  A
 *           word which is 0xFFFFFFFF is "available" since it is in its
 *           erased state.  Every other value is considered a valid entry
 *           in the catalog.
 * 
 *           The way ZSFA works is that whenever a catalog entry needs to be
 *           read, the sector is scanned from its lowest address until the
 *           first 0xFFFFFFFF value is encountered.  Every non-zero value
 *           encountered along the way is a valid atalog entry.  When a 
 *           catalog entry needs to be written, the sector is scanned until 
 *           the first 0xFFFFFFFF value is found, and the new catalog entry 
 *           is written to that offset.  To erase a catalog entry, you scan
 *           for it in the sector, then write 0x0 to it to mark it as "spent"
 * 
 *           The cache works by storing the "AS_MAX_FLASH_IMAGES" most
 *           recently loaded hardware images in fixed slots in flash starting
 *           at "AS_HW_IMAGE_OFFSET_START".  The ZSFA catalog holds the
 *           information about the timestamp value of each hardware image
 *           stored in one of those slots.  When it's time to load a new 
 *           hardware image, this function looks up the timestamp of the
 *           hw image on the SD Card (the timestamp is a special S0 record
 *           at the top of the SREC file).  It then compares that timestamp
 *           to all the timestamps stored in the ZSFA catalog.  If any of 
 *           them match, it skips copying  the hardware image from SD Card 
 *           since the image is already in flash.  If none of the catalog
 *           entries match, the hardware image is copied from SD Card into
 *           flash, then that hardware image's timestamp is recorded in the
 *           catalog.
 * 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsLoadAppFromSDCard( char app_to_import[],
                         alt_video_display* display,
                         alt_touchscreen* touchscreen )
{
  volatile int ret_code = 0;
  char hw_filename[256];
  char sw_filename[256];
  char string[64];
  int hw_flash_offset;
  int sw_flash_offset;
  progress_window prog_window;
  int total_bytes_complete = 0;
  int total_bytes = 0;
  int need_to_load_hw_image;
  int timestamp = 0;
  sdcard_dir_listing* dir_listing;
  INT8U err;

  sw_flash_offset = AS_SW_IMAGE_OFFSET;
  hw_flash_offset = AS_HW_IMAGE_OFFSET_START;

  dir_listing = malloc( sizeof( sdcard_dir_listing ));
  if( dir_listing )
  {
    sprintf( dir_listing->dirpath, "%s/%s", AS_SDCARD_APP_DIRECTORY, app_to_import );
    SDls( dir_listing );

    if( !dir_listing->error )
    {
      // Grab the flash semaphore since we'll likely need it here.
      OSSemPend( FlashSem, 0, &err );
      if( err == OS_NO_ERR )
      {
        if( AsGetFullFileName( hw_filename, "_hw.flash", dir_listing ) == AS_SUCCESS )    
        {
          // Get the timestamp from the first S0 record in the SREC file
          timestamp = AsGetSRECTimestamp( hw_filename );
          
          // If the timestamp is not valid, then we're going to have to load
          // the image from the SD Card.
          if( timestamp < 0 )
          {
            need_to_load_hw_image = 1;
          }
          else
          {
            // Look for a ZSFA cataloged image in flash whos timestamp matches this 
            // one to determine if the image is already in flash or if we need to copy 
            // it from the SD Card. 
            hw_flash_offset = AsFindHWImageInFlash( timestamp );
          
            // If an image with a matching timestamp is not found in flash, 
            // then we'll need to copy it in from SD Card.
            if( hw_flash_offset == AS_IMAGE_NOT_IN_FLASH)
              need_to_load_hw_image = 1;
            else
              need_to_load_hw_image = 0;
          }
          
          // If we need to load the image from SD Card, lets find a suitable
          // location to copy to by parsing the ZSFA catalog.  The
          // AsFindFlashLocationForHWImage() function also removes the
          // catalog entry for the offset it finds, so that the app selector
          // will not see it as a valid image until the relevant offset is 
          // re-written with the new image, then a new catalog entry 
          // is added for it.
          // Then we add the file size to the total number of bytes to be copied.
          if( need_to_load_hw_image )
          {
            hw_flash_offset = AsFindFlashLocationForHWImage();
            total_bytes += AsGetFileSize( hw_filename );
          }
        }
          
        // Grab the full filename of the file in the directory ending in _sw.flash and
        // add the SW image filesize to the total number of bytes we need to copy from SD
        if( AsGetFullFileName( sw_filename, "_sw.flash", dir_listing ) == AS_SUCCESS )
        {
          total_bytes += AsGetFileSize( sw_filename );
        }
  
        // Display a progess bar so the user knows how far along we are.
        sprintf( string, "Loading \"%s\"", app_to_import );
        AsBuildProgressWindow( string, &prog_window );
        AsPrintProgressWindow( &prog_window, display );
          
        // If neccessary, copy the HW image from SD Card to flash.
        if( need_to_load_hw_image )
        {
          ret_code |= AsCopySRECFromSDCardToFlash( hw_filename,
                                                   hw_flash_offset,
                                                   display,
                                                   touchscreen,
                                                   &prog_window,
                                                   &total_bytes_complete,
                                                   total_bytes );
          
          // Only record this image in the ZSFA catalog if the timestamp is valid.
          if( timestamp > 0 )
          {
            AsRecordHWImageInZSFACatalog( hw_flash_offset, timestamp );
          }
        }
  
        //Copy the SW image from SD Card to flash.
        ret_code |= AsCopySRECFromSDCardToFlash( sw_filename,
                                                 sw_flash_offset,
                                                 display,
                                                 touchscreen,
                                                 &prog_window,
                                                 &total_bytes_complete,
                                                 total_bytes );
  
        // If everything went well, lets shut things down and reconfigure ourselves
        if(( total_bytes_complete == total_bytes ) &&
           ( ret_code == 0x0 ))
        {
          // Stop the video display before reconfiguring.
          alt_video_display_close( display, ALT_VIDEO_DISPLAY_USE_HEAP, ALT_VIDEO_DISPLAY_USE_HEAP );
          free( dir_listing );
          AsReconfigFPGA( hw_flash_offset );
        }
        else
        {
          free( dir_listing );
          sprintf( string, "Error Loading Application %s", app_to_import );
          AsConfirmInfoWindow( display,
                               touchscreen,
                               string,
                               OK_ONLY );
        }

        // Release the Flash semaphore
        err = OSSemPost( FlashSem );
      }  
    }
  }
  
  return( ret_code );
}


/*****************************************************************************
 *  Function: AsRecordHWImageInZSFACatalog
 *
 *  Purpose: Records the location and timestamp of a hardware image in the
 *           ZSFA catalog.  Catalog entries are in the following format:
 * 
 *                 +--------+--------+--------+--------+
 *                 | Byte 3 | Byte 2 | Byte 1 | Byte 0 |
 *                 +========+========+========+========+
 *        Word 0   |   32-bit timestamp of hw image    |
 *                 +-----------------------------------+
 *        Word 1   |    32-bit offset of hw image      |
 *                 +-----------------------------------+
 * 
 *           The function scans through the ZSFA catalog until it encounters
 *           a value of 0xFFFFFFFF, indicating the end of valid catalog 
 *           entries, and the beginning of the writable area.  The function
 *           then overwrites that location with the new catalog entry. 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsRecordHWImageInZSFACatalog( int hw_offset, int timestamp )
{
	
	int i;
  int ret_code;
  unsigned int* flash_ptr;

  
  // Traverse the catalog until we find an unused spot.
 	flash_ptr = (unsigned int*)( EXT_FLASH_BASE + AS_FLASH_IMAGE_CATALOG_OFFSET );
 	
	for( i = 0; i < AS_FLASH_IMAGE_CATALOG_SIZE; i += 8 )
	{
    // A 0xFFFFFFFF means we've reached the unused portion of the catalog,
    // which means we can program our entry here.
    if( *flash_ptr == 0xFFFFFFFF )
    {
    	ret_code = flash_intel_p30_write ( EXT_FLASH_BASE, (int)(flash_ptr) - EXT_FLASH_BASE, (void*)(&timestamp), 2 );
    	ret_code |= flash_intel_p30_write ( EXT_FLASH_BASE, (int)(flash_ptr + 1) - EXT_FLASH_BASE, (void*)(&hw_offset), 2 );
    	break;
    }
    flash_ptr += 2;
  }
  
  // If we reached the end of the catalog area, we need to clear it and start over
  if( i == AS_FLASH_IMAGE_CATALOG_SIZE )
  {
    AsRefreshCatalog();
  }
  	
	return( ret_code );
}


/*****************************************************************************
 *  Function: AsRecordHWImageInZSFACatalog
 *
 *  Purpose: Ideally, this function would save off all the entries found in 
 *           the catalog, erase the catalog sector of flash, then write back 
 *           the entries.  But since refreshing the catalog will happen so 
 *           infrequently (every 4096 unique hardware images), we'll just erase 
 *           the catalog sector and effectively clear the cache.  The only 
 *           difference the user will notice is that every 4096 unique 
 *           application loads, the first few application loads will take a 
 *           few seconds longer
 * 
 *  Returns: 0
 ****************************************************************************/
int AsRefreshCatalog( void )
{
  flash_intel_p30_erase ( EXT_FLASH_BASE, AS_FLASH_IMAGE_CATALOG_OFFSET, AS_FLASH_SECTOR_SIZE );

  return( AS_SUCCESS );
}

int AsFindImagesInFlash( unsigned int slots_in_use[] )
{
  int i;
  int num_images_in_flash = 0;  
  unsigned int* flash_ptr;
    
  // Traverse the catalog to count the entries.
  flash_ptr = (unsigned int*)( EXT_FLASH_BASE + AS_FLASH_IMAGE_CATALOG_OFFSET );
  
  for( i = 0; i < AS_FLASH_IMAGE_CATALOG_SIZE; i += 8 )
  {
    // A 0xFFFFFFFF means we've reached the unused portion of the catalog,
    // which means no more entries will be found, so we'll stop looking for them.
    if( *flash_ptr == 0xFFFFFFFF )
      break;

    // Any non-zero, non-0xFFFFFFFF value is considered a valid catalog entry.
    else if( *flash_ptr != 0x00000000 )
    {
      // Record the image offset value from this entry
      slots_in_use[num_images_in_flash] = *(flash_ptr + 1);
      num_images_in_flash++;
    }
    flash_ptr += 2;
  }
  
  return( num_images_in_flash );
  
}


/*****************************************************************************
 *  Function: AsFindFlashLocationForHWImage
 *
 *  Purpose: This function scans the ZSFA catalog to find which hardware image
 *           slot in flash was written least recently.  It then erases that 
 *           catalog entry so a new one can be written once the new hw image
 *           is copied to that slot.
 * 
 *  Returns: The offset in flash to which the hw image should be copied.
 ****************************************************************************/
int AsFindFlashLocationForHWImage( void )
{
	int i;
	int ret_code = AS_SUCCESS;
	int hw_offset = AS_HW_IMAGE_OFFSET_START;
	int num_images_in_flash = 0;
	unsigned int catalog_spent_mask[2] = {0x0, 0x0};
	unsigned int slots_in_use[AS_MAX_FLASH_IMAGES];
  unsigned int* flash_ptr;
  unsigned int slot_is_free;
	
  num_images_in_flash = AsFindImagesInFlash( slots_in_use );
  
  // If there are fewer images in flash than AS_MAX_FLASH_IMAGES, then it means
  // we have at least one unused slot.  Let's find it.
  if( num_images_in_flash < AS_MAX_FLASH_IMAGES )
  {
  	// Index through all the slots where an image can reside, and cross-check them
  	// against the array of used slots we collected above.  When we come across
  	// a slot which is not in the array, it means we've found an empty slot.
  	for( hw_offset = AS_HW_IMAGE_OFFSET_START; hw_offset < AS_HW_IMAGE_OFFSET_END; hw_offset += AS_BYTES_FOR_HW_IMAGE )
  	{
  		slot_is_free = 1;
  		for( i = 0; i < num_images_in_flash; i++ )
  		{
  			if( hw_offset == slots_in_use[i] )
  			{
  				slot_is_free = 0;
  				break;
  			}
  		}
  		if( slot_is_free )
  		{
  		  break;
  		}
  	}
  	if( !slot_is_free )
  	{
  		// This should technically never happen, but we should flag it just in case.
  		ret_code = AS_FAILURE;
  	}
  }
  else
	// If there are AS_MAX_FLASH_IMAGES in flash, we need to decide which one to 
	// overwrite.  Ideally, this would be the one least recently run.  But that's
	// is a bit difficult to calculate  because we dont keep track of the run 
	// history.  So instead, we'll just overwrite the image copied to flash least 
	// recently, which will be the first one we find in the image catalog.
  {
  	// Traverse the catalog to  until we find an entry.
   	flash_ptr = (unsigned int*)( EXT_FLASH_BASE + AS_FLASH_IMAGE_CATALOG_OFFSET );
	  for( i = 0; i < AS_FLASH_IMAGE_CATALOG_SIZE; i += 8 )
    {
      if( *flash_ptr == 0xFFFFFFFF )
      {
        // We should never reach the end of the catalog here before finding an entry.
        ret_code = AS_FAILURE;
      	break;
      }
      // The first non-zero entry  contains the offset we will grab
      else if( *flash_ptr != 0x00000000 )
      {
      	// Save the offset
      	hw_offset = *( flash_ptr + 1 );
      	
      	// Mark catalog entry as spent because we're going to create a new one with this offset.
      	ret_code |= flash_intel_p30_write ( EXT_FLASH_BASE, (int)(flash_ptr) - EXT_FLASH_BASE, (void*)(&catalog_spent_mask), 4 );
      	break;
      }
    
      flash_ptr += 2;
    }
  }
  
  if( ret_code == AS_SUCCESS )
  	ret_code = hw_offset;

  return( ret_code );	
}


/*****************************************************************************
 *  Function: AsGetSRECTimestamp
 *
 *  Purpose: Opens the srec file "filename", and grabs the timestamp from the
 *           first S0 record in the file.  If the first S0 record does not
 *           meet the format requirements for a 32-bit timestamp, the function
 *           returns an error.
 * 
 *  Returns: Success - 32-bit unsigned timestamp, or 
 *           Failure - AS_ERROR_SREC_HAS_NO_TIMESTAMP
 ****************************************************************************/
int AsGetSRECTimestamp( char* filename )
{
  int ret_code;
  char* srec_buffer;
  char sdcard_fd;  
  srec_t srec;
  unsigned int timestamp;
  
  // Get our buffers
  srec_buffer = malloc( 100 );

  // Open the flash and the sdcard
  sdcard_fd = SDOpen( filename, F_READ );

  if(( srec_buffer == NULL ) ||
     ( sdcard_fd < 0 ))
  {
    free( srec_buffer );
    SDClose( sdcard_fd );
    ret_code = AS_FAILURE;
  }
  else
  {
    // Read what should be at least one line from the SREC file.
  	SDRead( srec_buffer, 100, sdcard_fd );
    // Decode the first record, which should be an S0 record.
  	srec_decode( &srec, srec_buffer );

    // If it is not an S0 record and of length 13, it does not fit
    // our requirements, so should be considered corrupt.
    if(( srec.type == 0 ) && ( srec.count == 13 ))
    {
    	// Value is in milliseconds, so we divide by 1000 to get seconds
      // by terminating the string 3 characters early.
      srec.data[srec.count - 3] = '\0';
    	sscanf ( srec.data, "%u", &timestamp );
      ret_code = timestamp;
    }
    else
    {
    	ret_code = AS_ERROR_SREC_HAS_NO_TIMESTAMP;
    }

   	free( srec_buffer );
    SDClose( sdcard_fd );
  }
  return( ret_code );
}  

/*****************************************************************************
 *  Function: AsFindHWImageInFlash
 *
 *  Purpose: This function looks through the ZSFA catalog to find any  
 *           catalog entries which match the the given timestamp.
 * 
 *  Returns: Success - Offset of image in flash coresponding to timestamp
 *           Failure - AS_IMAGE_NOT_IN_FLASH
 ****************************************************************************/
int AsFindHWImageInFlash( int timestamp )
{
  
  int i;
  int ret_code;
  unsigned int* flash_ptr;
    	
 	// Check the flash catalog to see if there are any HW
 	// images in flash whos timestamp matches the image we need to load
 	flash_ptr = (unsigned int*)( EXT_FLASH_BASE + 
 	                             AS_FLASH_IMAGE_CATALOG_OFFSET );

  // Initialize ret_code to a default
  ret_code = AS_IMAGE_NOT_IN_FLASH;
  
  // Traverse the catalog
  for( i = 0; i < AS_FLASH_IMAGE_CATALOG_SIZE; i += 8 )
  {
  	if( *flash_ptr == timestamp )
  	{
  		ret_code = *(flash_ptr + 1);
  		break;
   	}
  	else if( *flash_ptr == 0xFFFFFFFF )
  	{
  		ret_code = AS_IMAGE_NOT_IN_FLASH;
  		break;
  	}
  	flash_ptr += 2;
  }
  // If we traversed the entire catalog, then it means we didnt find a
  // matching timestamp, therefore the hw image is not already in flash 
	if( i == AS_FLASH_IMAGE_CATALOG_SIZE )
	{
		ret_code = AS_IMAGE_NOT_IN_FLASH;
	}
  
  return( ret_code );
}


/*****************************************************************************
 *  Function: AsReconfigFPGA
 *
 *  Purpose: Uses the alt_remote_update megafunction to recongigure the FPGA
 *           from the byte-offset in flash, "hw_flash_offset"
 * 
 *  Returns: 0 ( but never exits since it reconfigures the FPGA )
 ****************************************************************************/
int AsReconfigFPGA( int hw_flash_offset )
{
  volatile int remote_update_base;

  remote_update_base = REMOTE_UPDATE_BASE;
  
  // Make sure the flash is in read mode
  IOWR_16DIRECT( EXT_FLASH_BASE, 0, 0xFFFF );
  IOWR_8DIRECT( EXT_FLASH_BASE, 0, 0xFF );

  // First disable the watchdog timer
  IOWR( remote_update_base, 0x3, 0  );

  usleep(1000);

  // Next write the offset of the hardware image in flash
  IOWR( remote_update_base, 0x4, hw_flash_offset >> 3  );

  usleep(1000);
  
  // Reconfigure
  IOWR( remote_update_base, 0x20, 0x1 );

  while( 1 );

  return( 0 );
}




/*****************************************************************************
 *  Function: AsCopySRECFromSDCardToFlash
 *
 *  Purpose: Copies an SREC file from the SD Card to CFI flash.  The function
 *           also displays a progress bar to indicate how far along the in
 *           loading process we are.
 * 
 *           The copy is done by reading bulk blocks of data from the SD Card,
 *           then parsing individual lines for the data contained in the 
 *           S-Records.  Once enough data is collected from S-Records to
 *           constitute a flash sector, the data is written to the appropriate
 *           sector in flash.  At the end, whatever partial-sector's worth of
 *           data is left is written to flash, then the function exits.
 * 
 *  Returns: 0 -     Success
 *           non-0 - Failure
 ****************************************************************************/
int AsCopySRECFromSDCardToFlash( char filename[],
                                 int flash_dest,
                                 alt_video_display* display,
                                 alt_touchscreen* touchscreen,
                                 void* prog_window,
                                 int* total_bytes_complete,
                                 int total_bytes )
{
  alt_flash_fd* flash_fd;
  int flash_offset = flash_dest;
  volatile char sdcard_fd;
  volatile int ret_code = 0;
  char string[64];
  char* srec_buffer;
  char* data_buffer;
  int bytes_in_data_buffer = 0;
  volatile int srec_bytes_read;
  char* srec_line_ptr;
  srec_t srec;
  volatile int leftover_srec_bytes = 0;
  int leftover_data_bytes = 0;
  int data_buffer_size = AS_FLASH_SECTOR_SIZE + 32;
  int percent = 0;
  int last_percent = 0;
  int chars_in_line;

  // Get our buffers
  srec_buffer = malloc( AS_SREC_BUFFER_SIZE );
  data_buffer = malloc( data_buffer_size );

  // Open the flash and the sdcard
  flash_fd = alt_flash_open_dev( EXT_FLASH_NAME );
  sdcard_fd = SDOpen( filename, F_READ );

  if(( srec_buffer == NULL ) ||
     ( data_buffer == NULL ) ||
     ( flash_fd == 0 )       ||
     ( sdcard_fd < 0 ))
  {
    free( srec_buffer );
    free( data_buffer );
    alt_flash_close_dev( flash_fd );
    SDClose( sdcard_fd );
    ret_code = AS_FAILURE;

    sprintf( string, " %d %d %d %d", (int)srec_buffer, (int)data_buffer, (int)flash_fd, sdcard_fd );
    AsConfirmInfoWindow( display, touchscreen, string, OK_ONLY );
  }
  else
  {
    do
    {
      // Fill (or refill) the srec buffer from SD Card
      srec_bytes_read = SDRead( srec_buffer + leftover_srec_bytes,
                                AS_SREC_BUFFER_SIZE - leftover_srec_bytes,
                                sdcard_fd );
      srec_line_ptr = srec_buffer;

      while( srec_decode( &srec, srec_line_ptr ) == SREC_OK )
      {
        if( srec.type != 0 )
        {
          memcpy(( data_buffer + bytes_in_data_buffer ), srec.data, srec.count );
          bytes_in_data_buffer += srec.count;

          // If we have a flash sector's worth of data, then write it to flash
          if( bytes_in_data_buffer >= AS_FLASH_SECTOR_SIZE )
          {
            ret_code |= flash_intel_p30_erase ( (int)flash_fd->base_addr, flash_offset, AS_FLASH_SECTOR_SIZE );
            ret_code |= flash_intel_p30_write ( (int)flash_fd->base_addr, flash_offset, (void*)data_buffer, AS_FLASH_SECTOR_SIZE / 2 );

            leftover_data_bytes = bytes_in_data_buffer - AS_FLASH_SECTOR_SIZE;
            memcpy( data_buffer, data_buffer + AS_FLASH_SECTOR_SIZE, leftover_data_bytes );
            bytes_in_data_buffer = leftover_data_bytes;
            flash_offset += AS_FLASH_SECTOR_SIZE;
          }
        }
        // Find the beginning of the next SREC line
        // memchr should never return null here because the while loop
        // above will exit if it doesnt find a '\n'
        chars_in_line = ((int)memchr( srec_line_ptr, '\n', 80 ) + 1 ) - (int)srec_line_ptr;
        *total_bytes_complete += chars_in_line;
        srec_line_ptr += chars_in_line;

        // Update the progress bar
        percent = (( *total_bytes_complete * 100 ) / total_bytes );
        if( percent > last_percent )
        {
          AsUpdateProgressWindow( (progress_window*)prog_window, display, percent );
          last_percent = percent;
        }

        // If we've decoded all the bytes we're supposed to, we're done decoding SREC data.
        // If we don't perform this check, we could end up continuing along reading old data 
        // if the leftover data in srec_buffer happens to contain valid S-records (it very well could).
        if( *total_bytes_complete >= total_bytes ) 
        {
          break;
        }
      }

      // We reached the end of some SREC data in the buffer.  If we've decoded the entire
      // SREC file, that means we're all done.  But if there's more SREC data to be read 
      // from the SD Card still, continue refilling the SREC buffer from SD Card.
      if( *total_bytes_complete >= total_bytes )
      {
        break;
      }
      else 
      {
        // calculate the length of the partial record at the end of the srec buffer
        leftover_srec_bytes = (int)(( srec_buffer + AS_SREC_BUFFER_SIZE ) - srec_line_ptr );
        // then copy them back to the beginning of the srec buffer
        memcpy( srec_buffer, srec_line_ptr, leftover_srec_bytes );
      }

    } while( srec_bytes_read != 0 );

    // Write the last partial buffer to flash
    ret_code |= flash_intel_p30_erase ( (int)flash_fd->base_addr, flash_offset, AS_FLASH_SECTOR_SIZE );
    ret_code |= flash_intel_p30_write ( (int)flash_fd->base_addr, flash_offset, (void*)data_buffer, bytes_in_data_buffer / 2 );

    SDClose( sdcard_fd );
    alt_flash_close_dev( flash_fd );
    free( data_buffer );
    free( srec_buffer );
  }
  
  return( ret_code );
}


/*****************************************************************************
 *  Function: AsInfoTxtFileExists
 *
 *  Purpose: Checks if the specified application contains an info.txt file.
 * 
 *  Returns: Success - 1
 *           Failure - 0
 ****************************************************************************/
int AsInfoTxtFileExists( char app_name[] )
{
  int ret_code = AS_FAILURE;
  int i;
  sdcard_dir_listing* dir_listing;
  
  dir_listing = malloc( sizeof( sdcard_dir_listing ));
  if( dir_listing )
  {
    sprintf( dir_listing->dirpath, "%s/%s", AS_SDCARD_APP_DIRECTORY, app_name );
    SDls( dir_listing );
    
    for( i = 0; i < dir_listing->num_found; i++ )
    {
      if( !strcmp( dir_listing->filenames[i], "info.txt" ))
      {
        ret_code = AS_SUCCESS;
        break;
      }
    }
    free( dir_listing );
  }
  return( ret_code );
}
  

/*****************************************************************************
 *  Function: AsGetInfoText
 *
 *  Purpose: Reads the application information text from the specified 
 *           application on the SD Card.
 * 
 *           The function mounts the SD Card, changes to the directory 
 *           of the application indicated by "app_name[]", and reads the file
 *           "info.txt" into a buffer.  If "info.txt" doesnt exist, we return
 *           an error.
 * 
 *  Returns: Success - pointer to the buffer containing the info text.
 *           Failure - error code.
 ****************************************************************************/
char* AsGetInfoText( char app_name[] )
{ 

  int total_bytes;
  int bytes_read = 0;
  int ret_code = AS_SUCCESS;
  char* info_text = NULL;
  char sdcard_fd;
  char fullpath[256];
  
  // Try to open the file
  sprintf( fullpath, "%s/%s/info.txt", AS_SDCARD_APP_DIRECTORY, app_name );
  sdcard_fd = SDOpen( fullpath, F_READ );
  if( sdcard_fd >= 0 )
  {
    total_bytes = SDFilelength( sdcard_fd );
    if( total_bytes > 0 )
    {
      // Get a buffer, and add space for a carriage return, if neccessary, and a null termination.
      info_text = malloc( total_bytes + 3 );  // We free this buffer outside this function.
      if( info_text )
      {
        // Read the info text from the file.
        bytes_read = SDRead( info_text, total_bytes, sdcard_fd );
        if( bytes_read == 0 )
        {
          ret_code = AS_ERROR_FAT_READ_ZERO_BYTES;
        }
        else
        {
          // Our text parsing routine requires a carriage return at the end of
          // the text string, so we add one here if needed.
          if( info_text[bytes_read - 1] != '\n' )
          {
            // If there's no carriage return, add one, then terminate the string
            info_text[bytes_read] = '\r';
            info_text[bytes_read+1] = '\n';
            info_text[bytes_read+2] = '\0';
          }
          else
          {
            // If there's already a carriage return, just terminate the string
            info_text[bytes_read] = '\0';
          }
        }
      }
      else
      {
        ret_code = AS_ERROR_COULD_NOT_ALLOCATE;
      }
    }
    else
    {
      ret_code = AS_ERROR_FAT_READ_ZERO_BYTES;
    }
    SDClose( sdcard_fd );
  }
  else
  {
    ret_code = AS_ERROR_FAT_COULD_NOT_FIND;
  }
  
  if( ret_code != AS_SUCCESS )
  {
    free( info_text );
    info_text = NULL;
  }   

  return( info_text );
}    
  

/*****************************************************************************
 *  Function: AsGetFullFileName
 *
 *  Purpose: Looks in the current directory of the SD Card for a file who's
 *           name ends in the string variable "filenamepart".  If it finds
 *           such a file, it returns the complete short filename of that file
 *           in the string variable "filename".
 *           If such a file does not exist, the function returns an error.
 * 
 *  Returns: Success -  0
 *           Failure - -1
 ****************************************************************************/
int AsGetFullFileName( char* filename, char* filenamepart, sdcard_dir_listing* dir_listing )
{
  int found = 0;
  int i;
  int ret_code = AS_FAILURE;

  for( i = 0; i < dir_listing->num_found; i++)
  {
    // Only look at files which dont start with a '.' (i.e. "." and "..")
    if ( dir_listing->filenames[i][0] != '.' )
    {
      if( strstr( dir_listing->filenames[i], filenamepart ))
      {
        sprintf( filename, "%s/%s", dir_listing->dirpath, dir_listing->filenames[i] );
        found = 1;
        ret_code = AS_SUCCESS;        
        break;
      }
    }
  }

  return( ret_code );
}



/*****************************************************************************
 *  Function: AsGetFileSize
 *
 *  Purpose: Looks up the filesize of a file on the SD Card.
 * 
 *  Returns: The size of the file in bytes
 ****************************************************************************/
int AsGetFileSize( char* filename )
{

  int file_size = 0;
  char sd_file;

  sd_file = SDOpen( filename, F_READ );
  
  if( sd_file < 0 )
  {
    file_size = 0;
  }
  else
  {
    file_size = SDFilelength( sd_file );
    SDClose( sd_file );
  }

  return( file_size );
}


/*****************************************************************************
 *  Function: AsFindAppsOnSD
 *
 *  Purpose: Looks through the directory of the SD Card where the loadable
 *           application are, and fills out a list of all the valid-looking
 *           applications it finds.
 * 
 *  Possible enhancements: Remove the error message displaying from here,
 *                         and just pass back an error code.
 * 
 *  Returns: 0     - Success
 *           non-0 - Failure
 ****************************************************************************/
int AsFindAppsOnSD( app_list_struct* sd_app_list )

{
  int i, j;
  int ret_code = 0;
  int num_flash_files;
  char file_ext[16];
  
  sdcard_dir_listing* dir_listing1;
  sdcard_dir_listing* dir_listing2;
  
  dir_listing1 = malloc( sizeof( sdcard_dir_listing ));
  dir_listing2 = malloc( sizeof( sdcard_dir_listing ));  
  
  if( dir_listing1 && dir_listing2 )
  {
    // Collect a list of the directory contents
    strcpy( dir_listing1->dirpath, AS_SDCARD_APP_DIRECTORY );
    SDls( dir_listing1 );

    // Look through all the directories found in the AS_SDCARD_APP_DIRECTORY
    sd_app_list->num_apps = 0;
    for( i = 0; i < dir_listing1->num_found; i++ )
    {
      // Skip the .. and . dirs
      if( dir_listing1->filenames[i][0] == '.' )
        continue;

      // Collect a list of all the files found in this potential application directory
      sprintf( dir_listing2->dirpath, "%s/%s", AS_SDCARD_APP_DIRECTORY, dir_listing1->filenames[i] );
      if( !SDls( dir_listing2 ))
      {        
        // Ensure there are two .flash files in the dir
        num_flash_files = 0;
        for( j = 0; j < dir_listing2->num_found; j++ )
        {
          AsGetFileExtension( dir_listing2->filenames[j], file_ext );
          if( !strcmp( file_ext, "flash" ))
          {
            num_flash_files++;
          }
        }
      }
      else // If the dir doesnt exist, there are no flash files.
      {
        num_flash_files = 0;
      }
      
      if( num_flash_files >= 2 )
      {
        strcpy( sd_app_list->apps[sd_app_list->num_apps].app_name, dir_listing1->filenames[i] );
        sd_app_list->num_apps++;
      }
    }
        
    if( sd_app_list->num_apps == 0 )
    {
      ret_code = -2;
    }

    free( dir_listing1 );
    free( dir_listing2 );
  }

  return( ret_code );
}


/*****************************************************************************
 *  Function: AsSDCheckForFlashFiles
 *
 *  Purpose: Changes to the application directory on the SD Card and looks 
 *           files ending in ".FLA", which is ".flash" when represented in
 *           short filename format.  If two "*.FLA" files are found, then
 *           the directory appears to contain a valid application.
 * 
 *  Returns: 0 - Success
 *          -1 - Failure
 ****************************************************************************/
int AsSDCheckForFlashFiles( char dirname[] )
{
  char file_ext[16];
  int ret_code = AS_SUCCESS;
  int num_flash_files = 0;

  elca_chdir( dirname );

  if( elca_findfirst() != 0 ) //Find first file
  {
    do
    {
      if( ffblk.ff_name[0] != '.' )
      {
        AsGetFileExtension( ffblk.ff_longname, file_ext );
        if( !strcmp( file_ext, "flash" ))
        {
          num_flash_files++;
        }
      }
    } while ( elca_findnext() != 0 ); //Find next file or directory
  }

  if( num_flash_files < 2 )
  {
    ret_code = AS_FAILURE;
  }

  elca_chdir( ".." );

  return( ret_code );
}


/*****************************************************************************
 *  Function: AsGetFileExtension
 *
 *  Purpose: Reads the 3-character file extension of the short filename file 
 *           "filename[]"
 * 
 *  Returns: 0
 ****************************************************************************/
int AsGetFileExtension( char filename[], char file_ext[] )
{
  char* pointer_to_file_extension;
  int ret_code;

  if(( ffblk.ff_name[0] != '.' ) && ( ffblk.ff_name[1] != '.' ))
  {
    pointer_to_file_extension = strrchr( filename , '.' ) + 1;
    strcpy( file_ext, pointer_to_file_extension );
    ret_code = 0;
  }
  else
  {
    file_ext[0] = '\0';
    ret_code = 1;
  }

  return( 0 );
}



