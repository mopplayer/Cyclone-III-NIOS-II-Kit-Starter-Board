#include "alt_video_display.h"
#include <sys/alt_cache.h>

/* There are three buffers "CURRENT", "NEXT", and "CALCULATE".  CURRENT represents
 * the buffer being displayed, NEXT represents the next buffer that has been rendered,
 * and CALCULATE represents the buffer currently be constructed (rendered)
 */

void rotate_frame_buffers(alt_video_display * display)
{
   while(alt_video_display_buffer_is_available(display) != 0)
   { } // spin until a free is available

   alt_video_display_register_written_buffer(display);  // rotate the buffers
}


unsigned long * return_calculation_buffer_uncached(alt_video_display * display)
{
  int calculation_buffer;
  unsigned long * calculation_frame_buffer;
  
  // calculation buffer is the one that comes before the "next" buffer
  calculation_buffer = (display->buffer_being_written + 1) % display->num_frame_buffers;  
  calculation_frame_buffer = (unsigned long *) display->buffer_ptrs[calculation_buffer]->buffer;
  
  return calculation_frame_buffer;   
}

// we want to hand this value off to C2H (with cache bypassing disabled since that is Nios II specific)
unsigned long * return_calculation_buffer_cached(alt_video_display * display)
{
  int calculation_buffer, frame_length;
  unsigned long * calculation_frame_buffer;
  
  // calculation buffer is the one that comes before the "next" buffer
  calculation_buffer = (display->buffer_being_written + 1) % display->num_frame_buffers;  
  calculation_frame_buffer = (unsigned long *) display->buffer_ptrs[calculation_buffer]->buffer;
  frame_length = display->bytes_per_frame;
  
  calculation_frame_buffer = (unsigned long *)alt_remap_cached((void *)calculation_frame_buffer, frame_length);
  
  return calculation_frame_buffer;   
}


// we want to hand this value off to Nios II when displaying the fps over the screen
unsigned long * return_next_buffer_uncached(alt_video_display * display)
{
  int next_buffer;
  unsigned long * next_frame_buffer;
  
  // calculation buffer is the one that comes before the "next" buffer
  next_buffer = display->buffer_being_written;  
  next_frame_buffer = (unsigned long *) display->buffer_ptrs[next_buffer]->buffer;
  
  return next_frame_buffer;  
}


// we want to hand this value off to Nios II when displaying the fps over the screen
unsigned long * return_next_buffer_cached(alt_video_display * display)
{
  int next_buffer, frame_length;
  unsigned long * next_frame_buffer;
  
  // calculation buffer is the one that comes before the "next" buffer
  next_buffer = display->buffer_being_written;  
  next_frame_buffer = (unsigned long *) display->buffer_ptrs[next_buffer]->buffer;
  frame_length = display->bytes_per_frame;
  
  next_frame_buffer = (unsigned long *) alt_remap_cached((void *)next_frame_buffer, frame_length);
  
  return next_frame_buffer;  
}


// we want to hand this value off to Nios II when it's running in software only mode
unsigned long * return_current_buffer_uncached(alt_video_display * display)
{
  int current_buffer;
  unsigned long * current_frame_buffer;
  
  // calculation buffer is the one that comes before the "next" buffer
  current_buffer = display->buffer_being_displayed;  
  current_frame_buffer = (unsigned long *) display->buffer_ptrs[current_buffer]->buffer;
  
  return current_frame_buffer; 
}


unsigned long * return_current_buffer_cached(alt_video_display * display)
{
  int current_buffer, frame_length;
  unsigned long * current_frame_buffer;
  
  // calculation buffer is the one that comes before the "next" buffer
  current_buffer = display->buffer_being_displayed;  
  current_frame_buffer = (unsigned long *) display->buffer_ptrs[current_buffer]->buffer;
  frame_length = display->bytes_per_frame;
  
  current_frame_buffer = (unsigned long *) alt_remap_cached((void *)current_frame_buffer, frame_length);
  
  return current_frame_buffer; 
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
