#include "math.h"
#include "settings.h"
#include "movement_functions.h"


// this routine zooms into a coordinate that is passed into it as the center point of the image
void do_fluid_zoom_in(double in_x, double in_y, double in_x_dim, int in_max_iter, alt_touchscreen * screen, alt_video_display * display)
{
  int i, j;
  long long current_x, current_y, x_dim, center_x, center_y, step_dim, last_step_dim;
  double f_cur_x_dim, f_temp_x_dim;
  double f_max_iter_step, f_cur_max_iters;
  int i_cur_max_iters;
  
  // set the initial center point, x dimension, and maximum iterations
  center_x = (long long)(in_x * 0x10000000);
  center_y = (long long)(in_y * 0x10000000);
    
  // set initial zoom and iterations
  f_cur_x_dim = 3.0;
  f_cur_max_iters = 25;
  f_temp_x_dim = in_x_dim;
  
  // determine how many 2x zooms it takes to reach the final zoom point
  j = 1;
  while (f_cur_x_dim > in_x_dim)
  {
    f_cur_x_dim /= 1.1;
    j++;
  }
  
  // reset the zoom
  f_cur_x_dim = 3.0;
  f_max_iter_step = (in_max_iter - f_cur_max_iters) / j;
  
  // zoom in
  last_step_dim = 0;
  for(i=0;i<j;i++)
  {  
    x_dim = (long long)(f_cur_x_dim * 0x10000000);

    // calculate the step dimension between each pixel
    step_dim = x_dim / PIX_MAP_WIDTH;
    
    // calculate the top left pixel value to start with
    current_x = center_x - (x_dim/2);
    current_y = center_y + ((PIX_MAP_HEIGHT / 2) * step_dim);

    // make sure that we are taking a visible step, if step_dim == last_step_dim, then we won't see this step
    if(step_dim == last_step_dim)
    {
      // increase the iterations for more resolution on the next step
      f_cur_max_iters += f_max_iter_step;
      
      // zoom in 2x
      f_cur_x_dim /= 1.1;

      continue;      
    }
    
    last_step_dim = step_dim;

    // convert f_cur_max_iters to an integer
    i_cur_max_iters = f_cur_max_iters;


    draw(current_x, current_y, step_dim, i_cur_max_iters, screen, display);


    // increase the iterations for more resolution on the next step
    f_cur_max_iters += f_max_iter_step;
    
    // zoom in 2x
    f_cur_x_dim /= 1.1;
  }

  
  // zoom out
  last_step_dim = 0;
  for(i=0;i<j;i++)
  {      
    x_dim = (long long)(f_cur_x_dim * 0x10000000);

    // calculate the step dimension between each pixel
    step_dim = x_dim / PIX_MAP_WIDTH;
    
    // calculate the top left pixel value to start with
    current_x = center_x - (x_dim / 2);
    current_y = center_y + ((PIX_MAP_HEIGHT / 2) * step_dim);

    // make sure that we are taking a visible step, if step_dim == last_step_dim, then we won't see this step
    if(step_dim == last_step_dim)
    {
      // increase the iterations for more resolution on the next step
      f_cur_max_iters -= f_max_iter_step;
      
      // zoom in 2x
      f_cur_x_dim *= 1.1;

      continue;      
    }
    
    last_step_dim = step_dim;

    // convert f_cur_max_iters to an integer
    i_cur_max_iters = f_cur_max_iters;


    draw(current_x, current_y, step_dim, i_cur_max_iters, screen, display);
        
    
    // increase the iterations for more resolution on the next step
    f_cur_max_iters -= f_max_iter_step;
    
    // zoom in 2x
    f_cur_x_dim *= 1.1;  
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
