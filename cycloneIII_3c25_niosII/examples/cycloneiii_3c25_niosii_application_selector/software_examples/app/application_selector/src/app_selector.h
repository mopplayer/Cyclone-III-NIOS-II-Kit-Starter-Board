/*****************************************************************************
 *  File: app_selector.h
 * 
 *  This file contains the constants, structure definitions, and funtion
 *  prototypes for the application selector.
 *
 ****************************************************************************/

#ifndef APP_SELECTOR_H_
#define APP_SELECTOR_H_

#include "alt_video_display.h"
#include "alt_tpo_lcd.h"
#include "alt_touchscreen.h"
#include "sys/alt_flash_dev.h"
#include "sd_card.h"


#define ALT_VIDEO_DISPLAY_COLS 800
#define ALT_VIDEO_DISPLAY_ROWS 480
#define ALT_VIDEO_DISPLAY_COLOR_DEPTH 32
#define ALT_VIDEO_DISPLAY_SGDMA_NAME LCD_SGDMA_NAME

#define NUM_VIDEO_FRAMES 2

// Flash memory map
// =====================================================
// Offset                Contents
// =====================================================
// 0x000000 - 0x007FFF   Application Boot Code
// 0x008000 - 0x00FFFF   HW Image Catalog
// 0x010000 - 0x01FFFF   Unused
// 0x020000 - 0x0FFFFF   Selector HW Image
// 0x100000 - 0x23FFFF   Selector SW Image
// 0x240000 - 0x63FFFF   Application SW
// 0x640000 - 0xDBFFFF   Application HW Images (10)
// 0xDC0000 - 0xFFFFFF   Unused


#define AS_FLASH_SECTOR_SIZE            0x20000  //128KB
#define AS_SIZE_3C25_SOF                703693
#define AS_SECTORS_FOR_HW_IMAGE         ((AS_SIZE_3C25_SOF / AS_FLASH_SECTOR_SIZE) + 1)
#define AS_BYTES_FOR_HW_IMAGE           (AS_SECTORS_FOR_HW_IMAGE * AS_FLASH_SECTOR_SIZE)

#define AS_FLASH_IMAGE_CATALOG_OFFSET   0x8000
#define AS_FLASH_IMAGE_CATALOG_SIZE     0x8000
#define AS_HW_IMAGE_OFFSET_START        0x640000
#define AS_HW_IMAGE_OFFSET_END          0xDC0000
#define AS_MAX_FLASH_IMAGES             ((AS_HW_IMAGE_OFFSET_END - AS_HW_IMAGE_OFFSET_START) / AS_BYTES_FOR_HW_IMAGE)

#define AS_SW_IMAGE_OFFSET              0x240000

#define AS_SREC_BUFFER_SIZE             0x20000

// Error Codes
#define AS_SUCCESS                      0
#define AS_FAILURE                     -1
#define AS_ERROR_FAT_FAILED_TO_MOUNT   -2
#define AS_ERROR_FAT_COULD_NOT_FIND    -3
#define AS_ERROR_FAT_READ_ZERO_BYTES   -4
#define AS_ERROR_SREC_HAS_NO_TIMESTAMP -5
#define AS_ERROR_COULD_NOT_ALLOCATE    -6

#define AS_MAX_SDCARD_APPS              40

// Main menu actions
#define AS_ACTION_NONE                  0
#define AS_ACTION_LOAD_APP              1
#define AS_ACTION_DISPLAY_APP_INFO      2
#define AS_ACTION_APP_SELECTOR_EXIT     3

// Confirm Window actions
#define AS_ACTION_CANCEL                0
#define AS_ACTION_OK                    1

#define AS_IMAGE_NOT_IN_FLASH          -1

#define AS_FILE_BUFFER_SIZE AS_FLASH_SECTOR_SIZE
#define AS_SDCARD_APP_DIRECTORY "Altera_EEK_Applications"

typedef struct {
  unsigned int image_offset;
  unsigned char type;
  unsigned int image_length;
  unsigned int image_crc;
  unsigned int hw_filename;
  unsigned int sw_filename;
  unsigned int directory;
  char app_name[64];
} app_info;

typedef struct {
  app_info apps[AS_MAX_SDCARD_APPS];
  int num_apps;
  int target_app;
  int action;  
} app_list_struct;


void ASInitialTask(void* pdata);

void AsInitLCD( alt_video_display *lcd_display, alt_video_frame frame_buffers[] );
void AsInitTouchPanel( alt_touchscreen *touchscreen );
int AsInitTpoLcd( alt_tpo_lcd* lcd_serial );
int AsLoadAppFromSDCard( char app_to_import[], 
                      alt_video_display* display,
                      alt_touchscreen* touchscreen );
int AsFindAppsOnSD( app_list_struct* sd_app_list );
int AsSDCheckForFlashFiles( char dirname[] );
int AsGetFileExtension( char filename[], char file_ext[] );  
int AsMemBlocksOverlap( unsigned int base1,
                        unsigned int length1, 
                        unsigned int base2,
                        unsigned int length2 );          
int AsCopyFileFromSDCardToFlash( char filename[], int flash_dest );  
int AsFindSpotInFlashForEntity( int entity_length, app_list_struct* app_list );
int AsCopySRECFromSDCardToFlash( char filename[], 
                                 int flash_dest, 
                                 alt_video_display* display,
                                 alt_touchscreen* touchscreen,
                                 void* prog_window,
                                 int* total_bytes_complete,
                                 int total_bytes );
int AsReconfigFPGA( int hw_flash_offset );
int AsGetFullFileName( char* filename, char* filenamepart, sdcard_dir_listing* dir_listing );
int AsGetFileSize( char* filename );
char* AsGetInfoText( char app_name[] );
int AsGetSRECTimestamp( char* hw_filename );
int AsFindFlashLocationForHWImage( void );
int AsRecordHWImageInZSFACatalog( int hw_offset, int timestamp );
int AsFindHWImageInFlash( int timestamp );
int AsRefreshCatalog( void );
int AsInfoTxtFileExists( char app_name[] );
int ASFatLongNameMap( char shortname[], char longname[] );
void ASls( void );

#endif /*APP_SELECTOR_H_*/
