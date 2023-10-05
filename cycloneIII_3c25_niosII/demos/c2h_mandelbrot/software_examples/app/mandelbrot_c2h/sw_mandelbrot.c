#include "settings.h"
#include "display_drivers.h"
#include "io.h"
#include "buttons.h"
#include "system.h"
#include "benchmark.h"
#include "menu.h"
#include "alt_video_display.h"
#include "alt_touchscreen.h"



// this routine calculates the mandelbrot algorithm with integer math
inline int int_mandelbrot(long long cr, long long ci, int max_iter)
{
  long long xsqr=0, ysqr=0, x=0, y=0;
  int iter=0;
  
  // go ahead and shift these up to the new decimal offset
  ci = ci<<28;
  cr = cr<<28;
  
  while( ((xsqr + ysqr) < 0x0400000000000000LL) && (iter < max_iter) )
  {
    xsqr = x * x;
    ysqr = y * y;
    
    y = ((2 * x * y) + ci) >> 28;
    x = (xsqr - ysqr + cr) >> 28;

    iter++;
  }
  
  return(iter);
}


// this routine is the loop overhead for the integer mandelbrot algorithm
void sw_draw_int_mandelbrot(long long current_x, long long current_y, long long step_dim, int max_iter, alt_touchscreen * screen, alt_video_display * display, unsigned long *frame_buffer)
{
  int iters, i, j;
  long long leftmost_x;
  unsigned long *colour_lookup_table = (unsigned long *)COLOUR_LOOKUP_TABLE_BASE;
  unsigned long index = 0;
                
  leftmost_x = current_x;

  //process the image
  for(i=0; i<PIX_MAP_HEIGHT ; i++)  // i counts the rows in the image
  {
    for(j=0; j<PIX_MAP_WIDTH; j++)  // j counts the columns in the row
    {
      iters = int_mandelbrot(current_x, current_y, max_iter);    // evaluate this coordinate
      if(iters == max_iter) // it's in the set
      {
        IOWR_32DIRECT(frame_buffer, index, SET_COLOUR);
      }
      else  // it's out of the set
      {
        IOWR_32DIRECT(frame_buffer, index, colour_lookup_table[iters & COLOUR_MASK]);
      }
      current_x += step_dim;    // increment coordinate to next column
      index += 4;
    }
    current_x = leftmost_x;     // reset coordinate to first column of image
    current_y -= step_dim;      // increment coordinate to next row in image


    /* The remainder of this row loop is to make sure we don't have to wait
       for software to fill an entire frame buffer if we switch to hardware
       mode, pause, or change the colour palette.
     */
    updateScreen(screen);  // updates the state of the touchpanel

    if(screen_pressed() == 1)
    {
      OpenMenu(screen, display);
      return; // any time the menu is opened we will start a new frame when we return
    }

    // after every row is done we check to make sure we don't need to stall/switch to hardware
    while(return_pause_status() == 1)  // you pushed the pause button
    {
      initialize_benchmark();  // in paused mode so need to keep reseting time until we get out
    }
    
    if(return_hw_status() == 1)
    {
      return; // time to go back to the hardware mode   
    }
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
