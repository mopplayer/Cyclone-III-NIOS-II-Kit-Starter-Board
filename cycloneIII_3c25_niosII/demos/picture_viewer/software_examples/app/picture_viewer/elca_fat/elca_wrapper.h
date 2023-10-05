#ifndef ELCA_WRAPPER_H_
#define ELCA_WRAPPER_H_

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stddef.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/alt_dev.h> 
#include <sys/alt_llist.h>
#include <sys/stat.h>
#include <sys/unistd.h>
#include <sys/param.h>

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"
#include "sys/alt_warning.h"
#include "sys/alt_irq.h"
#include "sys/alt_alarm.h"
#include "sys/ioctl.h"


#include "elca_fat.h"

#ifndef ELCA_F_OK
#define ELCA_F_OK 1
#endif

typedef struct
{
  alt_dev fs_dev;
  alt_u8* base;
  alt_u8* directory; 
} alt_sd_dev;


//prototype
void elca_wrapper_init(void);

int my_sd_open(alt_fd* fd, const char* name, int flags, int mode);
int my_sd_close(alt_fd* fd);
int my_sd_read(alt_fd* fd, char* ptr, int len);
int my_sd_write(alt_fd* fd, const char* ptr, int len);
int my_sd_seek(alt_fd* fd, int ptr, int dir);
int my_sd_fstat(alt_fd* fd, struct stat* buf);






#endif /*ELCA_WRAPPER_H_*/
