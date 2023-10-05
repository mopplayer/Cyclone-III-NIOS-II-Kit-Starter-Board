#include "math.h"
#include "settings.h"
#include "movement_functions.h"


// this routine traverses from one coordinate to another
void do_fluid_move(double a_in_x, double a_in_y, double b_in_x, double b_in_y, alt_touchscreen * screen, alt_video_display * display)
{
  long long current_x, current_y,x_dim, center_x, center_y, step_dim;
  int i, j, i_cur_max_iters;
  double f_cur_x_dim, f_max_iter_step, f_cur_max_iters;
  double distance, x_len, y_len,next_x,next_y;

  // compute the x distance
  if(a_in_x > b_in_x) {
    x_len = -1 * fabs(a_in_x - b_in_x);
  }
  else {
    x_len = fabs(b_in_x - a_in_x);
  }
  
  // compute the y distance
  if(a_in_y > b_in_y) {
    y_len = -1 * fabs(a_in_y - b_in_y);
  }
  else {
    y_len = fabs(b_in_y - a_in_y);
  }

  // compute the straight line distance
  distance = sqrt(pow(x_len,2) + pow(y_len, 2));
  
  j=1;
  if(distance > 0.05) {
    while(distance > 0.05) {
      distance -= 0.05;
      j++;
    }

    y_len /= j;
    x_len /= j;

    next_x = a_in_x;
    next_y = a_in_y;
  }
  else {
    y_len = 0;
    x_len = 0;

    next_x = b_in_x;
    next_y = b_in_y;
  }

  // set the initial center point, x dimension, and maximum iterations
  center_x = (long long)(next_x * 0x10000000);
  center_y = (long long)(next_y * 0x10000000);
    
  // set initial zoom and iterations
  f_cur_x_dim = 3.0;
  f_cur_max_iters = 25;

  
  // reset the zoom
  f_cur_x_dim = 3.0;
  f_max_iter_step = f_cur_max_iters;
  
  // move it
  for(i=0;i<j;i++)
  {   
    //x_dim = cur_x_dim;
    x_dim = (long long)(f_cur_x_dim * 0x10000000);

    // calculate the step dimension between each pixel
    step_dim = x_dim / PIX_MAP_WIDTH;
    
    // calculate the top left pixel value to start with
    current_x = center_x - (x_dim/2);
    current_y = center_y + ((PIX_MAP_HEIGHT / 2) * step_dim);

    // convert f_cur_max_iters to an integer
    i_cur_max_iters = f_cur_max_iters;


    draw(current_x, current_y, step_dim, i_cur_max_iters, screen, display);
           

    // adjust to the next center point
    next_x += x_len;
    next_y += y_len;
    
    // set the next center point
    center_x = (long long)(next_x * 0x10000000);
    center_y = (long long)(next_y * 0x10000000);

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
