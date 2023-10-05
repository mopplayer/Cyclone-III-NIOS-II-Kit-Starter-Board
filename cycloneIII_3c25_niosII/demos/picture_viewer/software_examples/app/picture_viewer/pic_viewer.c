/******************************************************************************
*                                                                             *
* License Agreement                                                           *
* Copyright (c) 2007 Altera Corporation, San Jose, California, USA.           *
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
*                                                                             *
******************************************************************************/
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "includes.h"
#include "priv/alt_file.h"
#include "sys/alt_cache.h"
#include "sys/alt_alarm.h"
#include "system.h"
#include "io.h"
#include "alt_types.h"

/* Altera Embedded Evaluation Kit IO drivers */
#include "alt_video_display/alt_video_display.h"
#include "graphics_lib/simple_graphics.h"
#include "alt_touchscreen/alt_touchscreen.h"
#include "alt_tpo_lcd/alt_tpo_lcd.h"

/*
 * 3rd party JPEG Library
 *
 * The JPEG decoder is a free, UNSUPPORTED library from the
 * Independent JPEG Group. Please refer to the "README" file
 * located in the ./jpeg directory for further information.
 */
#include "jpeg/jpeglib.h"
#include "jpeg/jerror.h"

/* 3rd Party Bitmap Library */
// TODO: Disclaim
#include "bmp/bmplib.h"

/* El Camino FAT File sytem & SD Card controller */
#include "elca_fat/elca_fat.h"
#include "elca_fat/elca_wrapper.h"

/* UI graphics */
#include "control.h"
#include "alteraC3.h"

/* Picture viewer application settings/parameters */
#define DEBUG_PRINT 0              // enable debug printf messages to stdout()
#define WIDTH       800            // LCD screen width
#define HEIGHT      480            // LCD sreen height
#define COLORDEPTH  32             // LCD screen color depth (bits per pixel)
#define NUMBUFFER   1              // Number of buffers for LCD driver
#define TEXT_COLOR 0xFFFFFF        // Color of text (white)
#define BACKGROUND_COLOR 0x0      
#define BACKGROUND_MASK 0x0
#define SPLASH_BG_COLOR 0xFFFFFF   // Background color for splash screen (white)
#define SPLASH_BG_MASK 0x1
#define BUFFER_NUMBER 10           // Number of images to pre-buffer
#define INITIAL_TIME 10            // Initial time (seconds) between photos
#define PHOTOS_DIRECTORY "image"   // Folder on SD card to recurse for images
#define TOUCHSCREEN_SAMPLE_RATE 50 // Sample-rate for touch screen (Hz)
#define BMP      0
#define JPEG     1
#define UNKNOWN -1

/* Definition of Task Priorities */
#define UI_PRIORITY         1
#define DISPLAY_PRIORITY    2
#define FILETASK_PRIORITY   3

typedef struct 
{
  unsigned int framebuffer[HEIGHT][WIDTH];
  char text_string[100];
  unsigned short show_text;
  unsigned short data_ready;
  unsigned short lock;
  struct display_buffer *next;
  struct display_buffer *prev;
} display_buffer;

typedef struct
{
  alt_tpo_lcd lcd;
  alt_touchscreen touchscreen;
  alt_video_display *display;
  int ui_command;
  int ui_visible;
  int timer;
  unsigned int back_shadow_buffer[25][55];
  display_buffer *read_ptr;
  display_buffer *write_ptr;
} picture_viewer_control;

/* Prototypes */
void draw_time_delay(picture_viewer_control *pic_viewer);

void draw_toolbox(picture_viewer_control *pic_viewer);

void draw_paused_button(picture_viewer_control *pic_viewer);

void draw_play_button(picture_viewer_control *pic_viewer);

void draw_thumbnail_of_next_picture(picture_viewer_control *pic_viewer);

void draw_array(
  unsigned int *buffer, int x_size, int y_size,
  alt_video_display* display, int x_offset,
  int y_offset, unsigned int transparent_color);

void create_shadow(
  unsigned int *buffer, int x_size, int y_size,
  alt_video_display* display, int x_offset, int y_offset);

void draw_thumbnail(
  unsigned int *buffer, int x_size, int y_size,
  alt_video_display* display, int x_offset, int y_offset);

void lcd_display_error(picture_viewer_control *pic_viewer, char * error_str);

void jpeg_decode(
  picture_viewer_control *pic_viewer, FILE * infile, char * filename);

void bmp_decode(
  picture_viewer_control *pic_viewer, FILE * infile, char * filename);

void ui_pen_down_handler(int pen_up, int x, int y, void* context);

void ui_task(picture_viewer_control *pic_viewer);

int main();

/* Definition of Task Stacks */
#define TASK_STACKSIZE 2048
OS_STK filetask_stk[TASK_STACKSIZE];
OS_STK display_stk[TASK_STACKSIZE];
OS_STK ui_stk[TASK_STACKSIZE];

/* UI (button press) definitions */
#define UI_BACK 1
#define UI_FORWARD 2
#define UI_PLAY 3
#define UI_SHOWHIDE 4
#define UI_ADDDELAY 5
#define UI_MINUSDELAY 6

/* 
 * Size of area around button for which a touch event will land on that button
 * This helps with large fingers on the touch panel as opposed to a small
 * stylys device.
 */
#define UI_MARGIN 20

#define BACK_BUTTON_X_MIN (50 - UI_MARGIN)
#define BACK_BUTTON_X_MAX (BACK_BUTTON_X_MIN + backward_b_w + UI_MARGIN)
#define BACK_BUTTON_Y_MIN ((HEIGHT/2) - UI_MARGIN)
#define BACK_BUTTON_Y_MAX (BACK_BUTTON_Y_MIN + backward_b_h + UI_MARGIN)

#define FORWARD_BUTTON_X_MIN ( (WIDTH-forward_b_w-50) - UI_MARGIN)
#define FORWARD_BUTTON_X_MAX (FORWARD_BUTTON_X_MIN + forward_b_w + UI_MARGIN)
#define FORWARD_BUTTON_Y_MIN ((HEIGHT/2) - UI_MARGIN)
#define FORWARD_BUTTON_Y_MAX (FORWARD_BUTTON_Y_MIN + forward_b_h + UI_MARGIN)

#define PLAY_BUTTON_X_MIN ( ((WIDTH-play_b_w)/2) - UI_MARGIN)
#define PLAY_BUTTON_X_MAX (PLAY_BUTTON_X_MIN + play_b_w + UI_MARGIN)
#define PLAY_BUTTON_Y_MIN (HEIGHT-(play_b_h+30) - UI_MARGIN)
#define PLAY_BUTTON_Y_MAX (PLAY_BUTTON_Y_MIN + play_b_h + UI_MARGIN)

#define TOOLBOX_BUTTON_X_MIN ( 10 - UI_MARGIN)
#define TOOLBOX_BUTTON_X_MAX (TOOLBOX_BUTTON_X_MIN + toolbox_b_w + UI_MARGIN)
#define TOOLBOX_BUTTON_Y_MIN (10 - UI_MARGIN)
#define TOOLBOX_BUTTON_Y_MAX (TOOLBOX_BUTTON_Y_MIN + toolbox_b_h + UI_MARGIN)

#define ADD_BUTTON_X_MIN ( ((WIDTH-play_b_w)/2) + 50 - UI_MARGIN)
#define ADD_BUTTON_X_MAX (ADD_BUTTON_X_MIN + add_b_w + UI_MARGIN)
#define ADD_BUTTON_Y_MIN (10 - UI_MARGIN)
#define ADD_BUTTON_Y_MAX (TOOLBOX_BUTTON_Y_MIN + add_b_h + UI_MARGIN)

#define MINUS_BUTTON_X_MIN ( ((WIDTH-play_b_w)/2) - 50 - UI_MARGIN)
#define MINUS_BUTTON_X_MAX (ADD_BUTTON_X_MIN + add_b_w + UI_MARGIN)
#define MINUS_BUTTON_Y_MIN (10 - UI_MARGIN)
#define MINUS_BUTTON_Y_MAX (TOOLBOX_BUTTON_Y_MIN + add_b_h + UI_MARGIN)

/* Decode the x,y data to determine the event type. */
void ui_pen_down_handler(int pen_up, int x, int y, void* context)
{
  picture_viewer_control *pic_viewer = (picture_viewer_control *)(context);

  if(pic_viewer->ui_visible) { 
    /* Back button pressed */
    if(x>= BACK_BUTTON_X_MIN && x <= BACK_BUTTON_X_MAX &&
       y>= BACK_BUTTON_Y_MIN && y <= BACK_BUTTON_Y_MAX) {
#if DEBUG_PRINT
      printf("Back button press detected\n");
#endif
      pic_viewer->ui_command = UI_BACK;
    }
    /* Forward button pressed */
    else if (x>= FORWARD_BUTTON_X_MIN && x <= FORWARD_BUTTON_X_MAX &&
             y>= FORWARD_BUTTON_Y_MIN && y <= FORWARD_BUTTON_Y_MAX) {
#if DEBUG_PRINT
      printf("Forward button press detected\n");
#endif
      pic_viewer->ui_command = UI_FORWARD;
    }
    /* Play/pause button pressed */
    else if (x>= PLAY_BUTTON_X_MIN && x <= PLAY_BUTTON_X_MAX &&
             y>= PLAY_BUTTON_Y_MIN && y <= PLAY_BUTTON_Y_MAX) {
#if DEBUG_PRINT
      printf("Play button press detected\n");
#endif
      pic_viewer->ui_command = UI_PLAY;
    }
    /* toolbox button pressed */
    else if (x>= TOOLBOX_BUTTON_X_MIN && x <= TOOLBOX_BUTTON_X_MAX &&
             y>= TOOLBOX_BUTTON_Y_MIN && y <= TOOLBOX_BUTTON_Y_MAX) {
#if DEBUG_PRINT
      printf("Toolbox button press detected\n");
#endif
      pic_viewer->ui_visible = 0;
      pic_viewer->ui_command = UI_SHOWHIDE;
    }
    /* add button pressed */
    else if (x>= ADD_BUTTON_X_MIN && x <= ADD_BUTTON_X_MAX &&
             y>= ADD_BUTTON_Y_MIN && y <= ADD_BUTTON_Y_MAX) {
#if DEBUG_PRINT
      printf("Add button press detected\n");
#endif
      pic_viewer->ui_command = UI_ADDDELAY;
    }
    /* minus button pressed */
    else if (x>= MINUS_BUTTON_X_MIN && x <= MINUS_BUTTON_X_MAX &&
             y>= MINUS_BUTTON_Y_MIN && y <= MINUS_BUTTON_Y_MAX) {
#if DEBUG_PRINT
      printf("Minus button press detected\n");
#endif
      pic_viewer->ui_command = UI_MINUSDELAY;
    }
  }
  else {
    pic_viewer->ui_visible = 1;
    pic_viewer->ui_command = UI_SHOWHIDE;
#if DEBUG_PRINT
    printf("UI off & touch detected. Turning UI on\n");
#endif
  }
}

void ui_task(picture_viewer_control *pic_viewer)
{
  pic_viewer->ui_command = 0;
  pic_viewer->ui_visible = 1;
  pic_viewer->timer = INITIAL_TIME * 10;
         
  /* 
   * Periodically check for registered events. The 
   * alt_touchscreen_event_loop_update routine will 
   * call the registered handlers, which execute as 
   * part of this task.
   */
  while(1) {
    OSTimeDlyHMSM(0, 0, 0, (1000 / TOUCHSCREEN_SAMPLE_RATE));
    alt_touchscreen_event_loop_update(&pic_viewer->touchscreen);
  }
}

void filetask(picture_viewer_control *pic_viewer)
{
  int filetype = BMP;
  char filename[100], error_string[100], filescan[13], filename_ext[3];
  int filescan_loop = 0; 
  int file_counter = 0;
  int first_level_folder = 0;
  FILE * infile;
    
  /* 
   * Use the file system's "findfirst" and "findnext" routines to loop 
   * through the files in a directory. "findnext" must be primed by 
   * calling "findfirst", um, first.
   */
  if( !elca_findfirst() ) {
    printf("No Files found!\n");
    return;  // TODO: handle destruction gracefully
  }
  
  while (1) {
    /* 
     * The file basename from the last "findnext" or "findfirst" attempt
     * is located in a (public) struct "ffblk" within the file system.
     * Copy the (lower case) name out, figure its absolute path, 
     * and derive its file extension.
     */ 
    for (filescan_loop = 0; filescan_loop < 13; filescan_loop ++) {
      filescan[filescan_loop] = tolower(ffblk.ff_name[filescan_loop]);
    }
    
    // Folder structure
    if( (ffblk.ff_attr==ATTR_DIRECTORY) && 
        (filescan[0] != '.') && 
        (first_level_folder == 0) )
    {
            char folder_name[10];
            first_level_folder = file_counter;
            strncpy(folder_name, filescan, 8);
            folder_name[8] = 0;
            if(elca_chdir(folder_name) != ELCA_F_OK) {
                printf("  Error changing to '%s' dir\n", folder_name);
            }
            if( !elca_findfirst() ) {
                printf("No File in subfolder !!!\n");
            }
            file_counter = 0;
    }
    // File structure
    else if(ffblk.ff_attr==ATTR_FILE)
    {
        sprintf(filename, "/dev/sdcard/%s", filescan);    
        sprintf(filename_ext, "%c%c%c", 
          filename[strlen(filename)-3],
          filename[strlen(filename)-2],
          filename[strlen(filename)-1]);        
              
        if (strcmp(filename_ext,"jpg") == 0)
          filetype = JPEG;
        else if (strcmp(filename_ext,"bmp") == 0)
          filetype = BMP;
        else 
          filetype = UNKNOWN;            
         
        while(pic_viewer->write_ptr->lock == 1) {
          OSTimeDlyHMSM(0, 0, 0, 100);
        }
            
        pic_viewer->write_ptr->lock = 1;
        memset(pic_viewer->write_ptr->framebuffer,BACKGROUND_COLOR,4*WIDTH*HEIGHT);

        if ((infile = fopen(filename, "rb")) == NULL) {
          sprintf(error_string, 
            "Can't open file '%s' for read. Skipping file.", filename);
          printf("%s\n",error_string);
          lcd_display_error(pic_viewer, error_string);
          continue;
        } 
        else {   
          printf("\nNow processing file: %s\n", filename);
        }
               
        if (filetype == BMP) {
          bmp_decode(pic_viewer, infile, filename);
        }
        else if (filetype == JPEG) {
          jpeg_decode(pic_viewer, infile, filename);
        }
        else {
          sprintf(error_string,
            "Unknown file extension '%s'. Skipping file", filename_ext);
          printf("%s\n",error_string);
          lcd_display_error(pic_viewer, error_string);
        }
        
        fclose(infile);
        
        pic_viewer->write_ptr->lock = 0;
        pic_viewer->write_ptr = (display_buffer *)pic_viewer->write_ptr->next;
           
        OSTimeDlyHMSM(0, 0, 0, 100); 
    }
    
    /* Goto next file, or loop around once we reach the end */
    if( !elca_findnext() ) {
      if(first_level_folder != 0) {
        if(elca_chdir("..") != ELCA_F_OK) {
            printf("  Error changing to parent dir\n");
        }
        if( !elca_findfirst() ) {
            printf("No File in Parent, Structure has been changed\n");
            return; // TODO: handle destruction gracefully
        }
        file_counter = 0;
        while (file_counter < first_level_folder+1) {
            if( !elca_findnext() ) {
              if( !elca_findfirst() ) {
                printf("No File !!!\n");
                return; // TODO: handle destruction gracefully
              }
              file_counter = 0;
              first_level_folder  = 0;
            }
            else
                file_counter ++;
        }
        
        first_level_folder = 0;
      }
      else {
          if( !elca_findfirst() ) {
            printf("No File !!!\n");
            return; // TODO: handle destruction gracefully
          }
          file_counter = 0; //reset file counter if findfirst is successfull
      }
    }
    else {
        file_counter ++;    //increment file counter so we will know where we are
    }
  } /* while(1) */
}


/* Display picture */
void display(picture_viewer_control *pic_viewer)
{
  int loop = 0, paused = 0, image_switched = 0;
  display_buffer *tempprev;
  display_buffer *tempnext;

  /* Extract address of frame buffer that is being displayed on LCD */
  int addr = ( (int)(pic_viewer->display->buffer_ptrs[pic_viewer->display->buffer_being_written]->buffer) );
  
  /* Clear display & show Cyclone III logo */
  memset((void*)addr, SPLASH_BG_COLOR, 4*WIDTH*HEIGHT);
  draw_array( 
    (unsigned int *)alterac3, 
    alterac3_w, 
    alterac3_h, 
    pic_viewer->display, 
    (WIDTH-alterac3_w)/2, 
    (HEIGHT-alterac3_h)/2, 
    SPLASH_BG_MASK);

  /* 
   * Lock this thread until the 1st images is written...
   * Progressively draw a thumbnail of first photo while we're at it...
   */
  while( (pic_viewer->read_ptr->lock == 1) ||
         (pic_viewer->read_ptr == pic_viewer->write_ptr)) {
    draw_thumbnail_of_next_picture(pic_viewer);
    OSTimeDlyHMSM(0, 0, 0, 100);
  }
  pic_viewer->read_ptr->lock=1;
      
  while (1) {
    int thumbnail_drawn = 0;    

    /* Copy decoded image to buffer the video driver is reading from */
    memcpy((void*)addr,pic_viewer->read_ptr->framebuffer, 4*WIDTH*HEIGHT);

    create_shadow(
      (unsigned int *)pic_viewer->back_shadow_buffer,
      backward_b_w, backward_b_h, pic_viewer->display, 50, HEIGHT/2);

    /* Draw Extra text if available */
    if (pic_viewer->read_ptr->show_text) {
      vid_print_string(
        WIDTH/5, HEIGHT/2, TEXT_COLOR, cour10_font,
        pic_viewer->display, pic_viewer->read_ptr->text_string);
    }

    /* Draw UI elements */
    if(pic_viewer->ui_visible) {
      draw_toolbox(pic_viewer);

      if (paused) {
        draw_paused_button(pic_viewer);
      }
      else {
        draw_play_button(pic_viewer);
      }

      /* Draw time-delay box, plus/minus button */
      draw_time_delay(pic_viewer);

      /* Draw thumbnail (next picture already completely decoded) */
      if((display_buffer*) pic_viewer->read_ptr->next != 
         (display_buffer*) pic_viewer->write_ptr) {
        draw_thumbnail_of_next_picture(pic_viewer);
        thumbnail_drawn = 1;
      }
    }

    while (!image_switched) {
      tempnext = (display_buffer *)pic_viewer->read_ptr->next;
      tempprev = (display_buffer *)pic_viewer->read_ptr->prev;
      
      /* Progressively draw thumbnail if next image is being decoded */
      if( !thumbnail_drawn && pic_viewer->ui_visible) {
        if(tempnext != pic_viewer->write_ptr) { 
          thumbnail_drawn = 1;
        }
        draw_thumbnail_of_next_picture(pic_viewer);
      }

      /* 
       * UI Command has arrived. 
       * 
       * Go redraw the screen with/without the UI. 
       * Countdown timer is retained. 
       */                  
      if (pic_viewer->ui_command == UI_SHOWHIDE) {
          pic_viewer->ui_command = 0;  
          break;
      }

      if (pic_viewer->ui_command == UI_ADDDELAY) {
        pic_viewer->ui_command = 0;

        /* Time < 5 seconds: Up in 1-sec increments */
        if(pic_viewer->timer < 50) {
          pic_viewer->timer += 10;
        }
        /* Otherwise: 5-second increments */
        else if(pic_viewer->timer < 1200) {
          pic_viewer->timer += 50;
        }

        /* Draw new value */
        if (pic_viewer->ui_visible) {
          draw_time_delay(pic_viewer);
        }
      }

      if (pic_viewer->ui_command == UI_MINUSDELAY) {
        pic_viewer->ui_command = 0;

        /* Time >= 10 seconds; Down in 5-sec increments */
        if (pic_viewer->timer >= 100) {
          pic_viewer->timer -= 50;
        }
        /* Otherwise: 1-sec increments, down to 1 sec min */
        else if (pic_viewer->timer >= 20 && pic_viewer->timer <= 50) {
          pic_viewer->timer -= 10;
        }

        /* Draw newv alue */
        if (pic_viewer->ui_visible) {
          draw_time_delay(pic_viewer);
        }
      }
      
      /* 
       * Go forward if next image is done, AND user pressed forward button OR
       * countdown timer is expired. Draw forward button if able.
       * 
       * Note: delay may be altered up or down by the UI.
       */                  
      if (!tempnext->lock && (tempnext != pic_viewer->write_ptr)) {
        if ( (loop >= pic_viewer->timer) || 
             (pic_viewer->ui_command == UI_FORWARD) ) {
          pic_viewer->ui_command = 0;
          pic_viewer->read_ptr->lock = 0;
          pic_viewer->read_ptr = (display_buffer *)pic_viewer->read_ptr->next;
          image_switched = 1;
          pic_viewer->read_ptr->lock = 1;
          loop = 0; //if it passes through reset loop back to 0
          break;
        }
        if (1 == pic_viewer->ui_visible)
            draw_array((unsigned int *)forward_b, forward_b_w, forward_b_h, pic_viewer->display, WIDTH-forward_b_w-50, HEIGHT/2, BACKGROUND_MASK);
      }
      
      /* 
       * Go back if previous image isn't being overwritten yet and 
       * user pressed back. Draw back button if able.
       */
      if( (!tempprev->lock) &&
          (tempprev != pic_viewer->write_ptr) &&
          (pic_viewer->read_ptr != pic_viewer->write_ptr) &&
          (tempprev->data_ready)) {
        if(pic_viewer->ui_command == UI_BACK) {
          pic_viewer->ui_command = 0;
          pic_viewer->read_ptr->lock = 0;
          pic_viewer->read_ptr = (display_buffer *)pic_viewer->read_ptr->prev;
          pic_viewer->read_ptr->lock = 1;
          image_switched = 1;
          loop = 0; //if it passes through reset loop back to 0
          break;  //previous
        }
        if (1 == pic_viewer->ui_visible) {
          draw_array((unsigned int *)backward_b, backward_b_w, backward_b_h, pic_viewer->display, 50, HEIGHT/2, BACKGROUND_MASK);
        }
      }
      else {
        draw_array((unsigned int *)pic_viewer->back_shadow_buffer, backward_b_w, backward_b_h, pic_viewer->display, 50, HEIGHT/2, BACKGROUND_MASK);
      }
      
      /* Handle pause/play control */ 
      if(pic_viewer->ui_command == UI_PLAY) {
        pic_viewer->ui_command = 0;
        
        if(!paused) {
          paused = 1;
          if (pic_viewer->ui_visible) {
            draw_paused_button(pic_viewer);
          }
        }
        else {
          paused = 0;
          if (pic_viewer->ui_visible) {
            draw_play_button(pic_viewer);
          }
        }
      }

      /* Count as long as we're not paused */
      if (!paused) {
        loop++;
      }  
      
      OSTimeDlyHMSM(0, 0, 0, 100); 
    } /* while (delay between images & image not changed) */

    image_switched = 0; // reset
    
  } /* while(1) */
}

void draw_time_delay(picture_viewer_control *pic_viewer) 
{
  char delay_str[10];
  
  sprintf(delay_str,"%d sec",(pic_viewer->timer/10));
    
  vid_draw_box( 
    (WIDTH-60)/2, 15,     // Starting X & Y
    (WIDTH+60)/2, 35,     // Ending X & Y
    BACKGROUND_COLOR, 1,  // Color & do-fill-it-in-please
    pic_viewer->display);
  
  vid_print_string(
    (WIDTH-50)/2, 20,
    TEXT_COLOR, 
    cour10_font, 
    pic_viewer->display, 
    delay_str);
  
  /* + / - buttons */  
  draw_array(
    (unsigned int *)add_b, 
    add_b_w, 
    add_b_h, 
    pic_viewer->display, 
    ((WIDTH-add_b_w)/2) + 50, 
    10, 
    BACKGROUND_MASK);
    
  draw_array(
    (unsigned int *)minus_b, 
    minus_b_w, 
    minus_b_h, 
    pic_viewer->display, 
    ((WIDTH-minus_b_w)/2) - 50, 
    10, 
    BACKGROUND_MASK);
}
 
void draw_thumbnail_of_next_picture(picture_viewer_control *pic_viewer)
{
  alt_video_display *display = pic_viewer->display;
  int x_size = WIDTH/5;
  int x_offset = WIDTH-((WIDTH/5)+1);
  int y_size = HEIGHT/5;
  int y_offset = HEIGHT-((HEIGHT/5)+1);
  int x_b,y_b;
  int dx = WIDTH/x_size;
  int dy = HEIGHT/y_size;
  
  display_buffer *next_picture; 
  unsigned int *buffer; 
  
  // The "next" picture may be the 'current' one... at startup. We do this
  // to allow drawing a thrumbnail @ startup time to give user some idea
  // of what is happening until the first picture is displayed.
  if(pic_viewer->read_ptr == pic_viewer->write_ptr) {
    next_picture = (display_buffer *)pic_viewer->read_ptr;
  }
  else {
    next_picture = (display_buffer *)pic_viewer->read_ptr->next;
  }
  
  buffer = (unsigned int *) next_picture->framebuffer; 
  
  unsigned int *current_buffer = (unsigned int *)
    ( (int)(display->buffer_ptrs[display->buffer_being_written]->buffer) );
 
  for (x_b = 0; x_b<x_size; x_b ++) {
    for (y_b = 0; y_b<y_size; y_b ++) {
      current_buffer[(y_b+y_offset)*WIDTH+(x_b+x_offset)] =
        buffer[(y_b*dy)*WIDTH+(x_b*dx)];

      // Quick and dirty way to do 75% blurring and merging,
      // why use complex algorithm when we have...
      if(y_b % 3) {
        y_b ++;
      }
      if(x_b % 3) {
        x_b ++;    //God's gift of imperfect eyesight
      }
    }
  }
}

void draw_array(unsigned int *buffer, int x_size, int y_size,
  alt_video_display* display, int x_offset, int y_offset,
  unsigned int transparent_color)
{
  unsigned int *current_buffer;
  int addr = ( (int)(display->buffer_ptrs[display->buffer_being_written]->buffer) );
  current_buffer = (unsigned int *)addr;
  int x_b,y_b;
  unsigned int color;

  for (x_b = 0; x_b<x_size; x_b++) {
    for (y_b = 0; y_b<y_size; y_b++) {
      color = buffer[y_b*x_size+x_b];
      if (color != transparent_color) {
        current_buffer[(y_b+y_offset)*WIDTH+(x_b+x_offset)] = color;
      }
    }
  }
}

/* Routintes to draw UI elements */
void draw_toolbox(picture_viewer_control *pic_viewer)
{
  draw_array( 
    (unsigned int *)toolbox_b, 
    toolbox_b_w, 
    toolbox_b_h,
    pic_viewer->display, 
    10, 
    10, 
    BACKGROUND_MASK);
}

void draw_paused_button(picture_viewer_control *pic_viewer)
{
  draw_array(
    (unsigned int *)pause_b, 
    pause_b_w, 
    pause_b_h,
    pic_viewer->display, 
    (WIDTH-pause_b_w)/2, 
    HEIGHT-(pause_b_h+30),
    BACKGROUND_MASK);
}

void draw_play_button(picture_viewer_control *pic_viewer)
{
  draw_array(
    (unsigned int *)play_b, 
    play_b_w, 
    play_b_h,
    pic_viewer->display, 
    (WIDTH-play_b_w)/2, 
    HEIGHT-(play_b_h+30),
    BACKGROUND_MASK);
}

void create_shadow(unsigned int *buffer, int x_size, int y_size,
  alt_video_display* display, int x_offset, int y_offset)
{
    int x_b,y_b;
    int addr = ( (int)(display->buffer_ptrs[display->buffer_being_written]->buffer) );
    unsigned int *current_buffer = (unsigned int *)addr;

    for (x_b = 0; x_b<x_size; x_b++) {
      for (y_b = 0; y_b<y_size; y_b++) {
        buffer[y_b * x_size+x_b] =
          current_buffer[(y_b+y_offset) * WIDTH+(x_b+x_offset)];
      }
    }
}
        
void lcd_display_error(picture_viewer_control *pic_viewer, char * error_str)
{
  pic_viewer->write_ptr->data_ready = 1;
  strcpy(pic_viewer->write_ptr->text_string,error_str);
  pic_viewer->write_ptr->show_text = 1;
}

void jpeg_decode(picture_viewer_control *pic_viewer, FILE * infile, char * filename)
{
  int width, height, dwidth, dheight;
  int dx = 0, dy = 0;
  float dscaling = 0.0, output_scale_factor, scale_factor_x, scale_factor_y;
  int jpeg_scaled_width=0, jpeg_scaled_height=0, output_is_scaled=0;
  int rownum=0, colnum=0, outrow=0, outcol=0;
  int output_scaled_width=0, output_scaled_height=0;
  char error_string[100];

  struct jpeg_decompress_struct cinfo;
  struct jpeg_error_mgr err;
  register JSAMPROW outptr;
  JSAMPARRAY buffer;    /* Output row buffer */
  int row_stride;       /* physical row width in output buffer */
     
  cinfo.err = jpeg_std_error(&err);  
  
  jpeg_create_decompress(&cinfo);
  jpeg_stdio_src(&cinfo, infile);
  (void) jpeg_read_header(&cinfo, TRUE);

  width = cinfo.image_width;
  height = cinfo.image_height;
  
  dwidth = WIDTH - width;
  dheight = HEIGHT - height;

  /* 
   * JPEG dimensions are larger than the screen size. Figure out how 
   * much to scale the image during JPEG decode. The JPEG library 
   * supports, 1/1, 1/2, 1/4, and 1/8 scaling only.
   */
  if ((dwidth < 0)||(dheight < 0)) {
    // Calculate ratio of LCD screen size to full image size
    dscaling = (dwidth >= dheight) ? 
      ((float)HEIGHT/(float)height) : ((float)WIDTH/(float)width);
    
    // Determine the next *largest* JPEG scale size than we need so
    // that we can down-scale to fill the screen
    if ((dscaling < 1.0) && (dscaling >= 0.5))  {
        cinfo.scale_num = 1;     
        cinfo.scale_denom = 1;      
    }
    else if ((dscaling < 0.5) && (dscaling >= 0.25)) {
        cinfo.scale_num = 1;
        cinfo.scale_denom = 2;  
    }
    else if ((dscaling < 0.25) && (dscaling >= 0.125)) {
        cinfo.scale_num = 1;
        cinfo.scale_denom = 4;  
    }
    else if ((dscaling < 0.125) && (dscaling >= 0.0625)) {
      cinfo.scale_num  = 1;
      cinfo.scale_denom = 8;
    }
    else {
      sprintf(error_string,
        "Image '%s' is too lage. Skipping file.", filename);
      printf("%s\n",error_string);
      lcd_display_error(pic_viewer, error_string);
      return;
    }
    
    // Find the size of the resultant image from the jpeg decode operation
    jpeg_scaled_width = (width*((float)cinfo.scale_num/(float)cinfo.scale_denom));
    jpeg_scaled_height = (height*((float)cinfo.scale_num/(float)cinfo.scale_denom));
    
    // Determine a scaling "Factor" -- using the dimension most differing
    // from the screen size. This factor will be applied in both 
    // dimensions to keep a constant aspect ratio in the final image
    scale_factor_x = ((float)jpeg_scaled_width / (float)WIDTH);
    scale_factor_y = ((float)jpeg_scaled_height / (float)HEIGHT);
    
    if(scale_factor_y > scale_factor_x) {
      output_scale_factor = scale_factor_y;
    }
    else {
      output_scale_factor = scale_factor_x;
    }
    
    // Now calculate the final output image size which should
    // fit into the frame buffer. 
    output_scaled_width = ((float)jpeg_scaled_width / output_scale_factor);
    output_scaled_height = ((float)jpeg_scaled_height / output_scale_factor);
    
    // Allow for rounding error that may cause us to go out of bounds
    if(output_scaled_width > WIDTH) {
      output_scaled_width = WIDTH;
    }
    if(output_scaled_height > HEIGHT) {
      output_scaled_height = HEIGHT;
    }
     
    dwidth = WIDTH - output_scaled_width;
    dheight = HEIGHT - output_scaled_height;
      
    dx = (dwidth > 0) ? (dwidth / 2) : 0;
    dy = (dheight > 0) ? (dheight / 2) : 0;
      
    output_is_scaled = 1;
  }
  else {
    dx = (dwidth == 0) ? 0 : (dwidth / 2);
    dy = (dheight == 0) ? 0 : (dheight / 2);
    output_is_scaled = 0;
  }

#if DEBUG_PRINT
  printf("[jpeg_decode]: JPEG File info:\n");
  printf("  Width: %d,  Height: %d, Num components: %d, Color space: %d\n",
    cinfo.image_width, cinfo.image_height, 
    cinfo.num_components, cinfo.out_color_space);
  printf("  Scale factor: 1/%d, dwidth: %d, dheight: %d, dscaling: %f\n", 
      cinfo.scale_denom, dwidth, dheight, dscaling);   
#endif

  (void) jpeg_start_decompress(&cinfo);
  row_stride = cinfo.output_width * cinfo.output_components;
  buffer = (*cinfo.mem->alloc_sarray)((j_common_ptr) &cinfo, JPOOL_IMAGE, row_stride, 1);
    
  while (cinfo.output_scanline < cinfo.output_height) {
    // Read a scanline every time
    (void) jpeg_read_scanlines(&cinfo, buffer, 1);
    
    // Ultra-simple non-accurate scaling method: Periodically throw away one
    if(output_is_scaled) {
      if((rownum * output_scaled_height) < (outrow * jpeg_scaled_height)) {
        rownum++;
        continue;
      }
    }

    JDIMENSION num_cols = cinfo.output_width;
    outptr = *buffer;

    for (colnum = 0, outcol = 0; colnum < (num_cols); colnum++) {
      // Non-accurate scaling: Periodically throw away one
      if(output_is_scaled) {
        if( (colnum * output_scaled_width) < 
            (outcol * jpeg_scaled_width) ) {
          outptr += 3;
          continue;
        }
      }
        
      /* 
       * Copy pixel from decoded JPEG scanline buffer to buffer
       * that will be copied to video display
       */
      if ((outcol+dx< WIDTH) && (outrow+dy < HEIGHT)) {
        /* Color */
        if(cinfo.num_components == 3) {
          pic_viewer->write_ptr->framebuffer[outrow+dy][outcol+dx] =
            ( (outptr[0] << 16) + (outptr[1] << 8) + outptr[2] );
        }
        /* Grayscale */
        else if(cinfo.num_components == 1) {
          pic_viewer->write_ptr->framebuffer[rownum+dy][colnum+dx] =
            ( (outptr[0] << 16) + (outptr[0] << 8) + outptr[0] );
        }
      }
      
      if(cinfo.num_components == 3) {
        outptr += 3;
      }
      else if(cinfo.num_components == 1) {
        outptr++;
      }
      
      outcol++;
    } /* for(columns in decoded JPEG image */
    
    rownum++;
    outrow++;
  } /* while (rows in decoded JPEG image */
  
  pic_viewer->write_ptr->data_ready = 1;
  pic_viewer->write_ptr->show_text = 0;
  
  /* Finish up */
  (void) jpeg_finish_decompress(&cinfo);
  jpeg_destroy_decompress(&cinfo);
}

void bmp_decode(picture_viewer_control *pic_viewer, FILE * infile, char * filename)
{
    int width, height, dwidth, dheight, x, y;
    int dx = 0;
    int dy = 0;
    float dscaling = 0.0;

    IBMP *pBmp;
    // Reading BMP 
    pBmp = BmpIO_Load( infile );
    if ( NULL == pBmp ) 
    {
        printf( "Not a valid BMP File\n" );
        return;
    }

    width = BmpIO_GetWidth( pBmp );
    height = BmpIO_GetHeight( pBmp );

    dwidth = WIDTH - width;
    dheight = HEIGHT - height;

    dscaling = 1;
    
    if ((dwidth < 0)||(dheight < 0))
    {
        dscaling = (dwidth >= dheight)?((float)HEIGHT/(float)height):((float)WIDTH/(float)width);
        dwidth = WIDTH - (width*(float)dscaling);
        dheight = HEIGHT - (height*(float)dscaling);
        dx = rand() % (dwidth);
        dy = rand() % (dheight);
    }
    else
    {
        dx = (dwidth == 0)?0:rand() % (dwidth);
        dy = (dheight == 0)?0:rand() % (dheight);
    }

#if DEBUG_PRINT    
    printf("%s \n image_width = %d\t image_height= %d\n",filename, width, height);
    printf("dwidth = %d, dheight = %d, dscaling = %f\n\n",dwidth, dheight, dscaling);
#endif

    for ( y = height - 1; y > 0 ; y = y - (1 / dscaling) ) {
      for ( x = 0; x < width; x = x + (1 / dscaling) ) {
        pic_viewer->write_ptr->framebuffer[(HEIGHT-1-y) - dy][x + dx] =
          ( (BmpIO_GetR( x, y, pBmp ) << 16) +
            (BmpIO_GetG( x, y, pBmp ) << 8)  +
            (BmpIO_GetB( x, y, pBmp ) ) );
        }
    }

    pic_viewer->write_ptr->data_ready = 1;
    pic_viewer->write_ptr->show_text = 0;
    
    BmpIO_DeleteBitmap( pBmp );
}

int create_tasks(picture_viewer_control *pic_viewer)
{
  INT8U result = 0;
  
  printf("Creating uC/OS-II tasks & resources...");
  result |= OSTaskCreateExt((void *)ui_task,
                            (void *)pic_viewer,
                            (void *)&ui_stk[TASK_STACKSIZE],
                            UI_PRIORITY,
                            UI_PRIORITY,
                            ui_stk,
                            TASK_STACKSIZE,
                            NULL,
                            0);
                    
  result |= OSTaskCreateExt((void *)filetask,
                            (void *)pic_viewer,
                            (void *)&filetask_stk[TASK_STACKSIZE],
                            FILETASK_PRIORITY,
                            FILETASK_PRIORITY,
                            filetask_stk,
                            TASK_STACKSIZE,
                            NULL,
                            0);
               
  result |= OSTaskCreateExt((void *)display,
                            (void *)pic_viewer,
                            (void *)&display_stk[TASK_STACKSIZE],
                            DISPLAY_PRIORITY,
                            DISPLAY_PRIORITY,
                            display_stk,
                            TASK_STACKSIZE,
                            NULL,
                            0);

  if(result == OS_NO_ERR) {
    printf("Success.\n");
  }
  else {
    printf("Failed.\n");
    return -1;
  }
  
  return 0;                 
}


int initialize_io_devices(picture_viewer_control *pic_viewer)
{
  int result = 0, i;
  
  printf("Initializing IO devices...\n");
  
  /* 
   * SD Controller & File system 
   */
  printf("  Initializing El Camino SD/SPI controller & FAT file system..."); 
  for(i=0; i<100; i++) {
    result = elca_fat_mount(EL_CAMINO_SD_CARD_CONTROLLER_NAME);
    if(!result) {
      break;
    }
  }      
  if(result) {
     printf("Failed.\n");
     return -1;
  } 
  else {
    printf("Success.\n"); 
  }     
  
  if(elca_chdir("/") != ELCA_F_OK) {
    printf("  Error changing to root dir\n");
  }

  if(elca_chdir(PHOTOS_DIRECTORY) != ELCA_F_OK) {
    printf("  Error changing to '%s' dir\n", PHOTOS_DIRECTORY);
  }

  elca_wrapper_init();

  /* 
   * LCD display control register initialization. This sets the gamma curve.
   * 
   * Specify base addresses of the each communication bus PIO
   */
  pic_viewer->lcd.scen_pio = LCD_I2C_EN_BASE;
  pic_viewer->lcd.scl_pio  = LCD_I2C_SCL_BASE;
  pic_viewer->lcd.sda_pio  = LCD_I2C_SDAT_BASE;
     
  printf("  Intitializing LCD control registers & gamma curve...");
  if(alt_tpo_lcd_init(&pic_viewer->lcd, WIDTH, HEIGHT)) {
    /* 
     * We can tolerate this failre at the expense of 
     * less attractive images. Thus we will not return failure
     * to main()
     */
    printf("Failed.\n");
  } 
  else {
    printf("Success.\n");
  } 
    
  /* 
   * LCD Display pipeline (DMA) driver 
   */
  printf("  Intitializing video display driver...");
  pic_viewer->display = alt_video_display_init(
    "/dev/lcd_sgdma",            // char* sgdma_name
    WIDTH,                       // int width
    HEIGHT,                      // int height
    COLORDEPTH,                  // int color_depth
    ALT_VIDEO_DISPLAY_USE_HEAP,  // int buffer_location (malloc buffers)
    ALT_VIDEO_DISPLAY_USE_HEAP,  // int descriptor_location (malloc descriptors)
    NUMBUFFER);                  // int num_buffers

  if(pic_viewer->display) {
    printf("Success.\n");
  }
  else {
    printf("Failed.\n");
    return -1;
  }
  
  /* 
   * Touch screen interface 
   */
  printf("  Initializing touchscreen...");
  result = alt_touchscreen_init(
    &pic_viewer->touchscreen,
    TOUCH_PANEL_SPI_BASE,
    TOUCH_PANEL_SPI_IRQ,
    TOUCH_PANEL_PEN_IRQ_N_BASE,
    TOUCHSCREEN_SAMPLE_RATE,
    ALT_TOUCHSCREEN_SWAP_XY);
      
  /* Set calibration constants */
  alt_touchscreen_calibrate_upper_right (&pic_viewer->touchscreen, 
                     3946,   3849,    // ADC readings
                      799,      0  ); // pixel coords

  alt_touchscreen_calibrate_lower_left  (&pic_viewer->touchscreen,  
                     132,    148,     // ADC readings
                       0,    479  );  // pixel coords
  
  /* 
   * Register event handlers. For the picture viewer, we care only
   * about pen-down events (for now). Additional handlers can be
   * added should this be enhanced to support a drag-to-zoom feature
   */
   result |= alt_touchscreen_register_callback_func(
     &pic_viewer->touchscreen,                // the screen
     ALT_TOUCHSCREEN_CALLBACK_ON_PEN_DOWN,    // even to register
     ui_pen_down_handler,                     // routine to call
     pic_viewer);                             // context for routine
     
  if(result) {
    printf("Failed.\n");
    return -1;
  } else {
    printf("Success.\n");
  }
  
  /* Success */
  return 0;
}

int build_circular_image_buffer(picture_viewer_control *pic_viewer)
{
  int i = 0;
  display_buffer * temp_buffer;
  display_buffer * first_buffer;
  
  /* Build a circular linked list of buffers to hold decoded image data */
  first_buffer = calloc( sizeof(display_buffer), 1);
  if( first_buffer == NULL ) {
    printf( "Out of memory!\n" );
    return -1;
  }

  first_buffer->lock = 0;
  first_buffer->data_ready = 0;
  first_buffer->show_text = 0;
  
  pic_viewer->write_ptr = first_buffer;
  pic_viewer->read_ptr = first_buffer;

  /* Allocate subsequent buffers */
  for (i = 1; i < BUFFER_NUMBER; i++) {
    temp_buffer = calloc( sizeof(display_buffer), 1);
    if( temp_buffer == NULL ) {
      printf( "Out of memory!\n" );   
      return -1;                   
    }
    temp_buffer->lock = 0;
    temp_buffer->data_ready = 0;
    temp_buffer->show_text = 0;
  
    temp_buffer->prev = (struct display_buffer *)pic_viewer->write_ptr;
    pic_viewer->write_ptr->next = (struct display_buffer *)temp_buffer;
    pic_viewer->write_ptr = (display_buffer *)pic_viewer->write_ptr->next;
  }
  
  /* Complete the circle */
  pic_viewer->write_ptr->next = (struct display_buffer *)first_buffer;
  first_buffer->prev = (struct display_buffer *)pic_viewer->write_ptr;
  pic_viewer->write_ptr = (display_buffer *)first_buffer;
  
  return 0;
}

/* The main function creates two task and starts multi-tasking */
int main(void)
{ 
  /* Storage for the IO devices configuration structs & pointers */
  picture_viewer_control pic_viewer;
  
  printf("---------------------------------------\n");
  printf("    Nios II Embedded Evaluation Kit\n");
  printf("          Picture Viewer Demo\n");
  printf("---------------------------------------\n");
  
  if(initialize_io_devices(&pic_viewer)) {
    printf("\nError initializing IO devices. Halting.\n");
    return -1;
  }
  
  if(create_tasks(&pic_viewer)) {
    printf("\nError creating MicroC/OS-II tasks. Halting\n");
    return -1;
  }
  
  if(build_circular_image_buffer(&pic_viewer)) {
    printf("\nError allocating memory for picture viewer. Halting\n");
    return -1;
  }
  
  /* Start the OS */  
  OSStart();
    
  /* We'll never get here */
  return 0;
}
