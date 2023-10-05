
#include "elca_wrapper.h"
char file_desc[MAX_OPEN_FILE];

int my_sd_seek(alt_fd* fd, int ptr, int dir)
{
    return 0;

}

int my_sd_fstat(alt_fd* fd, struct stat* buf)
{
  int ret_code = 0;

  buf->st_mode = S_IFREG;
  buf->st_size = (off_t)elca_filelength((char)*fd->priv);

  return ret_code;


}


int my_sd_close(alt_fd* fd)
{
    elca_fclose((char)*fd->priv);
    return 0; 
}

int my_sd_open(alt_fd* fd, const char* name, int flags, int mode)
{
        char filedesc;
        int i = 0;
        char filename[100];
        
        int namestart = -1;
    
        for (i= 0; i < 100; i++)
            filename[i] = (char)NULL;
        
        for (i = 5; i < strlen(name); i++)
        {
            if (namestart >= 0)
            {
                filename[namestart] = name[i];  
                namestart ++;  
            }
            
            if (name[i] == '/')
                namestart = 0;
        
        }
        
        
        if (flags == 1537)
            filedesc = elca_fopen(filename,F_WRITE);
        else 
            filedesc = elca_fopen(filename,F_READ);
    
        file_desc[(int)filedesc] = filedesc;
        fd->priv = (void *)&file_desc[(int)filedesc];

       if (filedesc >= 0)    
            return 0;
       else
            return -1;

}


int my_sd_write(alt_fd* fd, const char* ptr, int len)
{

    if (elca_fwrite((unsigned char *)ptr,len,(char)*fd->priv) != len) 
    {
      return -1;
    }


   
 return len;
}


int my_sd_read(alt_fd* fd, char* ptr, int len)
{
    
    
    int i=0;
    
      i=elca_fread(ptr,len,(char)*fd->priv);
      
      if(i<len){
        ptr[i] = 0;
      }

    return i;

}


void elca_wrapper_init(void)
{
   static alt_sd_dev my_sd = {
      {                                             \
        ALT_LLIST_ENTRY,                            \
        "/dev/sdcard",                              \
        my_sd_open, /* open */                      \
        my_sd_close,/* close */                     \
        my_sd_read, /* read */                      \
        my_sd_write,/* write */                     \
        my_sd_seek, /* lseek */                     \
        my_sd_fstat, /* fstat */                    \
        NULL, /* ioctl */                           \
      },                                            \
      (void*)EL_CAMINO_SD_CARD_CONTROLLER_NAME,     \
      (void*)0,                                     \
   };

   alt_fs_reg (&my_sd.fs_dev);

}

