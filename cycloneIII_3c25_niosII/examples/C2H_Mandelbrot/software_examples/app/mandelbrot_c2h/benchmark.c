#include "buttons.h"
#include "settings.h"
#include "stdio.h"
#include "system.h"
#include "sys/alt_alarm.h"
#include "altera_avalon_pio_regs.h"
#include "simple_graphics.h"

#if (DISPLAY_PRESENT == 1)
  static char screen_output[40];
#endif

static unsigned long frame_counter;
static unsigned long ticks1 = 0, ticks2 = 0;
static float pixels_per_second, frames_per_second;



// starting the timer resets the timer (down counter) as well
void initialize_benchmark()
{
  frame_counter = 1;
  ticks1 = alt_nticks();  // number of 10ms ticks since reset
}


/* This function has four modes:
 * 1)  Hardware accelerator enabled and VGA enabled
 * 2)  Hardware accelerator enabled VGA disabled
 * 3)  Software only and VGA enabled
 * 4)  Software only and VGA disabled
 * 
 * The rate at which the performance values are output to the screen/console is dependent on the
 * number of frames rendered and not fixed time.  So if the framerate is high then the frequency
 * of benchmark values being displayed will be high.  The update frequency is set in "system.h"
 * file if you wish to increase or decrease the benchmark rate.
 */
void print_performance(alt_video_display * display)
{
  unsigned long tick_delta;
  alt_video_display dummy_video_display;  // going to stuff this with information from "display"


  // *** hardware mode ***
  if(return_hw_status())
  {
    #if (DISPLAY_PRESENT == 1)  // video controller is present so benchmark goes onscreen
      if(frame_counter >= HW_FRAME_DISPLAY_RATE)
      {
        ticks2 = alt_nticks();  // number of 10ms ticks since reset
        tick_delta = ticks2 - ticks1;
  
        frames_per_second = ((float)(HW_FRAME_DISPLAY_RATE * alt_ticks_per_second())) / ((float)tick_delta);
        pixels_per_second = ((float)(HW_FRAME_DISPLAY_RATE * PIX_MAP_LENGTH * alt_ticks_per_second())) / ((float)tick_delta);
  
        initialize_benchmark();
        snprintf(screen_output, 40, "%0.1f fps", frames_per_second);     
      }
      else
      {
        frame_counter++;
      }

      // this write overtop of the rendered frame in the bottom right corner of the screen using white text and a black background
      vid_print_string_alpha(PIX_MAP_WIDTH-100, PIX_MAP_HEIGHT-30, WHITE_24, BLACK_24, timesnewroman_24, display, screen_output);

    #else    // no video controller so print to the console
      if(frame_counter >= HW_FRAME_CONSOLE_RATE)  // update benchmark
      {
        ticks2 = alt_nticks();  // number of 10ms ticks since reset
        tick_delta = ticks2 - ticks1;
  
        frames_per_second = ((float)(HW_FRAME_CONSOLE_RATE * alt_ticks_per_second())) / ((float)tick_delta);
        pixels_per_second = ((float)(HW_FRAME_CONSOLE_RATE * PIX_MAP_LENGTH * alt_ticks_per_second())) / ((float)tick_delta);
  
        initialize_benchmark();  // resets the frame counter and sets ticks1
        printf("The hardware performance is %d[pixels/s] or %0.1f[frames/s]\n", (int)pixels_per_second, frames_per_second);
      }
      else
      {
        frame_counter++;
      }
    #endif
  }
  else  // *** software mode ***
  {
    #if (DISPLAY_PRESENT == 1)  // video controller is present so benchmark goes onscreen
    
      /* the information from "display" so that we can set "buffer_being_written" to be
       * equal to "buffer_being_displayed".  The font overlay expects to be writting to
       * the "written" buffer but in software mode we are displaying to the "displayed"
       * buffer all the time */
      dummy_video_display.buffer_ptrs[0] = display->buffer_ptrs[0];
      dummy_video_display.buffer_ptrs[1] = display->buffer_ptrs[1];
      dummy_video_display.buffer_ptrs[2] = display->buffer_ptrs[2];
      dummy_video_display.buffer_being_written = display->buffer_being_displayed;
      dummy_video_display.width = display->width;
      dummy_video_display.height = display->height;
      dummy_video_display.color_depth = display->color_depth;
      dummy_video_display.bytes_per_pixel = display->bytes_per_pixel;
      dummy_video_display.bytes_per_frame = display->bytes_per_frame;
    
      if(frame_counter >= SW_FRAME_DISPLAY_RATE)
      {
        ticks2 = alt_nticks();  // number of 10ms ticks since reset
        tick_delta = ticks2 - ticks1;
        
        frames_per_second = ((float)(SW_FRAME_DISPLAY_RATE * alt_ticks_per_second())) / ((float)tick_delta);
        pixels_per_second = ((float)(SW_FRAME_DISPLAY_RATE * PIX_MAP_LENGTH * alt_ticks_per_second())) / ((float)tick_delta);
  
        initialize_benchmark();
        snprintf(screen_output, 40, "%0.2f fps", frames_per_second);
      }
      else
      {
        frame_counter++;
      }

      vid_print_string_alpha(PIX_MAP_WIDTH-100, PIX_MAP_HEIGHT-30, WHITE_24, BLACK_24, timesnewroman_24, &dummy_video_display, screen_output);      

    #else    // no video controller so print to the console
      if(frame_counter >= SW_FRAME_CONSOLE_RATE) // update benchmark
      {
        ticks2 = alt_nticks();  // number of 10ms ticks since reset
        tick_delta = ticks2 - ticks1;
      
        frames_per_second = ((float)(SW_FRAME_CONSOLE_RATE * alt_ticks_per_second())) / ((float)tick_delta);
        pixels_per_second = ((float)(SW_FRAME_CONSOLE_RATE * PIX_MAP_LENGTH * alt_ticks_per_second())) / ((float)tick_delta);
  
        initialize_benchmark();  // resets the frame counter and sets ticks1
        printf("The software performance is %d[pixels/s] or %0.3f[frames/s]\n", (int)pixels_per_second, frames_per_second); 
      }
      else
      {
        frame_counter++;
      }
    #endif
  } 
}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
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
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
