

#ifndef __SD_CARD_H__
#define __SD_CARD_H__

// SD Card command definitions
#define SDCARD_READ       1
#define SDCARD_WRITE      2
#define SDCARD_OPEN       3
#define SDCARD_CLOSE      4
#define SDCARD_FILELENGTH 5
#define SDCARD_LISTING    6
#define SDCARD_ERROR      7

#define SD_MAX_DIRS          50

// Message sent to SD Card task
typedef struct {
  unsigned char command;   // SDCARD_READ, SDCARD_WRITE, SDCARD_OPEN, SDCARD_CLOSE
  void* data;              // Data to read or write
  unsigned int num_bytes;  // Number of bytes to read or write
  char filepath[256];      // Name of file to open.
  unsigned char flag;      // File open options
  char file_handle;        // File handle of currently open file, if there is one.
} sdcard_com_message;

// Message returned from SD Card task.
typedef struct {
  unsigned char command;   // SDCARD_READ, SDCARD_WRITE, SDCARD_OPEN, SDCARD_CLOSE
  void* data;             // Data read or written.
  unsigned int num_bytes;  // Number of bytes read or written.
  char file_handle;        // File handle of file opened or closed
  char error;
} sdcard_resp_message;

// Directory listing from SD Card.
typedef struct {
  char dirpath[256];                        // Name of directory to open.
  char filenames[SD_MAX_DIRS][256];         // Names of files/directories found
  unsigned int num_found;                   // number of files/directories found
  char error;
} sdcard_dir_listing;



// Function Prototypes
int SDChdirLongName( char dirname[] );
char SDOpenLongName( char filename[], unsigned char attr );
int SDStringToLower( char src_string[], char dest_string[] );
void SDCardTask( void* pdata );
char SDOpen( char fullfilename[], unsigned char flag );
void SDClose( char filehandle );
int SDFilelength( char filehandle );
unsigned int SDRead( char* buffer, unsigned int bytecount, char filehandle );
int SDChdirAbsPath( char abspath[] );
int SDls( sdcard_dir_listing* dir_listing );

#endif /* __SD_CARD_H__ */

