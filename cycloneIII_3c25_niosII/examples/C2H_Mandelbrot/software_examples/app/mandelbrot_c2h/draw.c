#include "movement_functions.h"
#include "display_drivers.h"
#include "mandelbrot_functions.h"
#include "menu.h"
#include "buttons.h"
#include "alt_c2h_hw_draw_int_mandelbrot_irq.h"
#include "benchmark.h"




/*  This function is responsible for keeping the video processing in sync, calling the benchmark routines,
    and communication with the touchscreen */
inline void draw(long long current_x, long long current_y, long long step_dim, int i_cur_max_iters, alt_touchscreen * screen, alt_video_display * display)
{
  updateScreen(screen);

  if(return_hw_status() == 1)
  {
    rotate_frame_buffers(display);

    while(ACCELERATOR_MANDELBROT_HW_DRAW_INT_MANDELBROT_MANAGED_INSTANCE_BUSY() == 1) 
    {
      updateScreen(screen);
    } // must wait for the accelerator to finish first (previous run)

    if(screen_pressed() == 1)
    {
      OpenMenu(screen, display);  // open the menu here so that no partial frames are being rendered by C2H
    }

    hw_draw_int_mandelbrot(current_x, current_y, step_dim, i_cur_max_iters, return_calculation_buffer_cached(display));

    while(return_pause_status() == 1)  // you pushed the pause button
    {
      initialize_benchmark();  // in paused mode so need to keep reseting time until we get out
      updateScreen(screen);
    }

    print_performance(display);  // increments the frame counter and printfs only at a fixed interval 
  }
  else
  {
    while(alt_video_display_buffer_is_available(display) == -1)
    {
      updateScreen(screen);
    } // make sure all remaining frames go out the door

    sw_draw_int_mandelbrot(current_x, current_y, step_dim, i_cur_max_iters, screen, display, return_current_buffer_uncached(display)); 
    print_performance(display);  // increments the frame counter and printfs only at a fixed interval 
  }
}
