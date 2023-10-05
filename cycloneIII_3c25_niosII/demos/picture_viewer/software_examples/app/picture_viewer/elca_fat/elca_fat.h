///////////////////////////////////////////////////////////////////////////////
//
//         ******                          Module Name: elca_fat.h
//     **************                      Date       : Jan. 3, 2006
//   ******************                    Author     : Klaus Brunnbauer
//  *******************                    Company    : El Camino GmbH
//  *********   ***  ***                   Tel.       : +49 (0)8751-8787-0
//  ******** ***  * *****    ***           WWW        : http://www.elca.de
//   ****** ***** * *****   *****          e-mail     : info@elca.de
//    ***** ***** * *****   *****
//       ** ***** * *****   *****          Revision   : 1.0
//          *****   *************
//          *****   ************           (c) 2007 El Camino GmbH
//          *************
//           ************
//                  *****
//                  *****
//                  *****
//           *******************
//        *************************
//            ******************
//
//   Description: Filessystem for flash devices
//
//
//
//
///////////////////////////////////////////////////////////////////////////////
//  CONFIDENTIAL
//  This code is licensed to, the licensee :
//  NOT LICENSED, EVALUATION VERSION
//  El Camino grants to the licensee a non-transferable, non-exclusive,
//  paid-up license to use this code as follows:
//  - design with, parameterize, synthesize, simulate, compile and implement
//    in ASIC or ALTERA PLD/FPGA technologies
//  - distribute, sell and otherwise market programming files, executables
//    and/or devices based on this code
//  - you may NOT use this source code except as expressly provided for above
//    or sublicense or transfer this code or rights with respect thereto.

#ifndef __ELCA_FAT_H
#define __ELCA_FAT_H

#define MAX_OPEN_FILE   3
// every 1 declared open file takes 554 Bytes for FAT12/16 only

#define USE_FATBUFFER //define this if you want to use a FAT buffer
                      //needs 517 Bytes of RAM !

#define _MAX_NAME 64


#define F_CLOSED  0
#define F_READ    1
#define F_WRITE   2
#define F_ERROR   0
#define ELCA_F_OK    1

//File/Dir Attributes
#define ATTR_FILE       0x00
#define ATTR_READ_ONLY  0x01
#define ATTR_HIDDEN     0x02
#define ATTR_SYSTEM     0x04
#define ATTR_VOLUME_ID  0x08
#define ATTR_DIRECTORY  0x10
#define ATTR_ARCHIVE    0x20
#define ATTR_LONG_NAME  0x0F
#define ATTR_NO_ATTR    0xFF


#define FAT_READ  //define this if you want to read files
#define FAT_WRITE //define this if you want to write files
#define FAT_DELETE  //define this if you want to delete files


#define FAT_CHDIR //define this if you want to go into subdirectories
#define FAT_MKDIR //define this if you want to make subdirectories

// spare program memory by deciding if we want to use FAT12, FAT16, FAT32.
// don't touch if you don't know the FAT type of your drive !
#define USE_FAT12 //define this if you want to use FAT12
#define USE_FAT16 //define this if you want to use FAT16

#define USE_FINDFILE  //define this if you want to use findfirst(); findnext();
#define USE_FINDLONG  //define this if you want to get long filenames
      //from findfirst(); findnext();

extern int elca_fat_mount(char *device);
extern void elca_fat_unmount(void);

extern char elca_fopen(char *name, unsigned char flag);
extern void elca_fclose(char fileid);

extern unsigned int elca_fread(unsigned char *buf, unsigned int count, char fileid );
extern unsigned int elca_fwrite(unsigned char *buf, unsigned int count, char fileid);
extern void elca_fflush(char fileid);

extern unsigned char elca_remove(char *name);
extern unsigned long elca_filelength(char fileid);

extern unsigned char elca_mkdir(char *name);
extern unsigned char elca_chdir(char *name);

#ifdef USE_FINDFILE

struct FindFile
{
  unsigned char ff_attr;    // attribute file or directory
  unsigned long ff_fsize;   // file size, 0 for directories
  char ff_name[13];         // 8.3 DOS filename with '.' in it and \0 at the end for fopen()
#ifdef USE_FINDLONG
  char ff_longname[_MAX_NAME];  // The very long filename.
#endif
  unsigned int newposition;   // position of this file
  unsigned int lastposition;
};

  extern unsigned char elca_findfirst(void);
  extern unsigned char elca_findnext(void);
  extern struct FindFile ffblk;
#endif



#endif //__ELCA_FAT_H
