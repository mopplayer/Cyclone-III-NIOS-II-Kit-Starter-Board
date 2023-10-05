#include "settings.h"
#include "system.h"


/* Will use the automatically generated macros to pull for the done condition. */
#pragma altera_accelerate enable_interrupt_for_function hw_draw_int_mandelbrot

/* The Nios II data master connects to the first port of this onchip memory.  This hardware accelerator connects
 * to the second port of the colour lookup table memory to minimize the amount of arbitration needed. */  
#pragma altera_accelerate connect_variable hw_draw_int_mandelbrot/colour_lookup_table to colour_lookup_table/s2

/* The hardware accelerator writes the results to the video frame buffer */
#pragma altera_accelerate connect_variable hw_draw_int_mandelbrot/frame_buffer to frame_buffer_pipeline_bridge/s1



/* macro version of int_mandelbrot which is used by sw_draw_int_mandelbrot */
#define MANDELBROT_PIXEL(iters, current_x, current_y, max_iter) \
{ \
  long x = 0; \
  long y = 0; \
  long long xsqr = 0; \
  long long ysqr = 0; \
  (iters) = 0; \
  while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters) < (max_iter)) ) \
  { \
    xsqr = ((long long)x) * ((long long)x); \
    ysqr = ((long long)y) * ((long long)y); \
    y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y) << 28)) >> 28); \
    x = (long)(((xsqr - ysqr) + ((current_x) << 28)) >> 28); \
    (iters) = (iters) + 1; \
  } \
}



/* Accelerate this function!

   This function handles all the mandelbrot calculations and writes the results directly into the supplied frame_buffer.  This function operates
   on an entire video frame so call it once per frame.  The majority of the code is used to coordinate multiple pixel calculations concurrently.
   It is important that "NUM_OF_ENGINES" evenly divides the screen width otherwise this concurrent approach will not work (the accelerator will
   write too much data to the frame buffer because it won't stop in time).  NUM_OF_ENGINES must also be a power of 2 within the range of 1, 2, 4,
   8, 16.  To add or remove parallism simply modify the value of NUM_OF_ENGINES to one of the valid values and recompile the hardware accelerator.
   The pixel computational pattern is as follows:

   0   1   2   3   n   0   1   2   3   n   1  .... etc
   0   1   2   3   n   0   1   2   3   n   1  .... etc
   .... etc
   0   1   2   3   n   0   1   2   3   n   1  .... etc

   Where n = NUM_OF_ENGINES

   This ensures that memory accesses are completely sequential to avoid memory thrashing (important when the frame buffer lives in memory that
   has a bank switching penalty such as SDRAM devices).  This neighbooring pixel approach is used as apposed to having seperate accelerators operating
   on different frames purely from a memory footprint aspect.  Using multiple accelerators operating on alternative frames would require a frame buffer
   per mandelbrot engine.  Each frame requires the following number of bytes:

   Bytes per Frame = Width of Screen (pixels) * Height of Screen (pixels) * 4 (bytes)

   Each pixel consumes four bytes of memory since a 24 bit unpacked colour format is being used (alpha channel is not used).  Since this hardware
   accelerator writes to an offscreen video buffer having an alternate frame implementation would require either a fancy scheduler communicating
   with the video driver or twice as many frame buffers to make sure plenty of frames are buffered waiting for the video controller to come by and
   display them.
*/
void hw_draw_int_mandelbrot(long long current_x, long long current_y, long long step_dim, int max_iter, unsigned long * __restrict__ frame_buffer)
{
   /* Only one array accesses this colour table port so it's safe to use the restrict keyword. */
  long * __restrict__ colour_lookup_table = (long *)COLOUR_LOOKUP_TABLE_BASE;
  long pixel, column;
  /* Need different copies of current_x since each pixel calculation is staggered apart on the same line */
#if(NUM_OF_ENGINES >= 1)
  long long current_x0_copy;
  long iters0;
#endif
#if(NUM_OF_ENGINES >= 2)
  long long current_x1_copy;
  long iters1;
#endif
#if(NUM_OF_ENGINES >= 4)
  long long current_x2_copy, current_x3_copy;
  long iters2, iters3;
#endif
#if(NUM_OF_ENGINES >= 8)
  long long current_x4_copy, current_x5_copy, current_x6_copy, current_x7_copy;
  long iters4, iters5, iters6, iters7;
#endif
#if(NUM_OF_ENGINES >= 16)
  long long current_x8_copy, current_x9_copy, current_x10_copy, current_x11_copy, current_x12_copy, current_x13_copy, current_x14_copy, current_x15_copy;
  long iters8, iters9, iters10, iters11, iters12, iters13, iters14, iters15;
#endif
  long long current_y_copy;


  column = 0;

  // Instead of using multiplications shifts and adds are used, this will make sure multiplier blocks are not dedicated to these simple multiplications
  #if(NUM_OF_ENGINES >= 1)
    current_x0_copy = current_x;
  #endif
  #if(NUM_OF_ENGINES >= 2)
    current_x1_copy = current_x + step_dim;
  #endif
  #if(NUM_OF_ENGINES >= 4)
    current_x2_copy = current_x + (step_dim << 1);  // 2 * step_dim
    current_x3_copy = current_x + (step_dim << 1) + step_dim;  // 3 * step_dim
  #endif
  #if(NUM_OF_ENGINES >= 8)
    current_x4_copy = current_x + (step_dim << 2);  // 4 * step_dim
    current_x5_copy = current_x + (step_dim << 2) + step_dim;  // 5 * step_dim
    current_x6_copy = current_x + (step_dim << 2) + (step_dim << 1);  // 6 * step_dim
    current_x7_copy = current_x + (step_dim << 2) + (step_dim << 1) + step_dim;  // 7 * step_dim
  #endif
  #if(NUM_OF_ENGINES >= 16)
    current_x8_copy = current_x + (step_dim << 3);  // 8 * step_dim
    current_x9_copy = current_x + (step_dim << 3) + step_dim;  // 9 * step_dim
    current_x10_copy = current_x + (step_dim << 3) + (step_dim << 1);  // 10 * step_dim
    current_x11_copy = current_x + (step_dim << 3) + (step_dim << 1) + step_dim;  // 11 * step_dim
    current_x12_copy = current_x + (step_dim << 3) + (step_dim << 2);  // 12 * step_dim
    current_x13_copy = current_x + (step_dim << 3) + (step_dim << 2) + step_dim;  // 13 * step_dim
    current_x14_copy = current_x + (step_dim << 4) - (step_dim << 1);  // 14 * step_dim
    current_x15_copy = current_x + (step_dim << 4) - step_dim;  // 15 * step_dim
  #endif  // if you go to 32 or more engines ...... you are getting a bit carried away but if you want just and (NUM_OF_ENGINES >= 32) and 16 more lines of statement code
  current_y_copy = current_y;


  /* keeping track of the column since this loop will handle the x and y axis */
  for(pixel = 0; pixel < PIX_MAP_LENGTH; pixel = (pixel + NUM_OF_ENGINES))
  {
    #if(NUM_OF_ENGINES >= 1)
      MANDELBROT_PIXEL(iters0, current_x0_copy, current_y_copy, max_iter);
    #endif
    #if(NUM_OF_ENGINES >= 2)
      MANDELBROT_PIXEL(iters1, current_x1_copy, current_y_copy, max_iter);
    #endif
    #if(NUM_OF_ENGINES >= 4)
      MANDELBROT_PIXEL(iters2, current_x2_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters3, current_x3_copy, current_y_copy, max_iter);
    #endif
    #if(NUM_OF_ENGINES >= 8)
      MANDELBROT_PIXEL(iters4, current_x4_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters5, current_x5_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters6, current_x6_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters7, current_x7_copy, current_y_copy, max_iter);
    #endif
    #if(NUM_OF_ENGINES >= 16)
      MANDELBROT_PIXEL(iters8, current_x8_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters9, current_x9_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters10, current_x10_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters11, current_x11_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters12, current_x12_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters13, current_x13_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters14, current_x14_copy, current_y_copy, max_iter);
      MANDELBROT_PIXEL(iters15, current_x15_copy, current_y_copy, max_iter);
    #endif

    /* this if-else statement removes the need of using for loops for rows and columns.  It detects when the right side of the screen is reached. */
    if(column == (PIX_MAP_WIDTH - NUM_OF_ENGINES)) // hit the right side of the screen (need to start at the beginning of the next line)
    {
      #if(NUM_OF_ENGINES >= 1)
        current_x0_copy = current_x;
      #endif
      #if(NUM_OF_ENGINES >= 2)
        current_x1_copy = current_x + step_dim;
      #endif
      #if(NUM_OF_ENGINES >= 4)
        current_x2_copy = current_x + (step_dim << 1);  // 2 * step_dim
        current_x3_copy = current_x + (step_dim << 1) + step_dim;  // 3 * step_dim
      #endif
      #if(NUM_OF_ENGINES >= 8)
        current_x4_copy = current_x + (step_dim << 2);  // 4 * step_dim
        current_x5_copy = current_x + (step_dim << 2) + step_dim;  // 5 * step_dim
        current_x6_copy = current_x + (step_dim << 2) + (step_dim << 1);  // 6 * step_dim
        current_x7_copy = current_x + (step_dim << 2) + (step_dim << 1) + step_dim;  // 7 * step_dim
      #endif
      #if(NUM_OF_ENGINES >= 16)
        current_x8_copy = current_x + (step_dim << 3);  // 8 * step_dim
        current_x9_copy = current_x + (step_dim << 3) + step_dim;  // 9 * step_dim
        current_x10_copy = current_x + (step_dim << 3) + (step_dim << 1);  // 10 * step_dim
        current_x11_copy = current_x + (step_dim << 3) + (step_dim << 1) + step_dim;  // 11 * step_dim
        current_x12_copy = current_x + (step_dim << 3) + (step_dim << 2);  // 12 * step_dim
        current_x13_copy = current_x + (step_dim << 3) + (step_dim << 2) + step_dim;  // 13 * step_dim
        current_x14_copy = current_x + (step_dim << 4) - (step_dim << 1);  // 14 * step_dim
        current_x15_copy = current_x + (step_dim << 4) - step_dim;  // 15 * step_dim
      #endif  // if you go to 32 or more engines ...... you are getting a bit carried away but if you want just and (NUM_OF_ENGINES >= 32) and 16 more lines of statement code
      current_y_copy = current_y_copy - step_dim; // one pixel down the screen
      column = 0;  // back to the left side of the screen
    }
    else  // still on the same line so leaving the y axis alone
    {
      #if(NUM_OF_ENGINES >= 1)
        current_x0_copy = (current_x0_copy + (step_dim * NUM_OF_ENGINES));  // NUM_OF_ENGINES is even so this is just a left shift operation
      #endif
      #if(NUM_OF_ENGINES >= 2)
        current_x1_copy = (current_x1_copy + (step_dim * NUM_OF_ENGINES));
      #endif
      #if(NUM_OF_ENGINES >= 4)
        current_x2_copy = (current_x2_copy + (step_dim * NUM_OF_ENGINES));
        current_x3_copy = (current_x3_copy + (step_dim * NUM_OF_ENGINES));
      #endif
      #if(NUM_OF_ENGINES >= 8)
        current_x4_copy = (current_x4_copy + (step_dim * NUM_OF_ENGINES));
        current_x5_copy = (current_x5_copy + (step_dim * NUM_OF_ENGINES));
        current_x6_copy = (current_x6_copy + (step_dim * NUM_OF_ENGINES));
        current_x7_copy = (current_x7_copy + (step_dim * NUM_OF_ENGINES));
      #endif
      #if(NUM_OF_ENGINES >= 16)
        current_x8_copy = (current_x8_copy + (step_dim * NUM_OF_ENGINES));
        current_x9_copy = (current_x9_copy + (step_dim * NUM_OF_ENGINES));
        current_x10_copy = (current_x10_copy + (step_dim * NUM_OF_ENGINES));
        current_x11_copy = (current_x11_copy + (step_dim * NUM_OF_ENGINES));
        current_x12_copy = (current_x12_copy + (step_dim * NUM_OF_ENGINES));
        current_x13_copy = (current_x13_copy + (step_dim * NUM_OF_ENGINES));
        current_x14_copy = (current_x14_copy + (step_dim * NUM_OF_ENGINES));
        current_x15_copy = (current_x15_copy + (step_dim * NUM_OF_ENGINES));
      #endif
      column = column + NUM_OF_ENGINES;  // column tracks the left most pixel being operated on (i.e. the first mandelbrot engine)
    }


    /* sequentially write the mapped colour to the frame buffer for the video controller to read and display. */
    #if(NUM_OF_ENGINES >= 1)
      *frame_buffer++ = (iters0 == max_iter)? SET_COLOUR : colour_lookup_table[iters0 & COLOUR_MASK];
    #endif
    #if(NUM_OF_ENGINES >= 2)
      *frame_buffer++ = (iters1 == max_iter)? SET_COLOUR : colour_lookup_table[iters1 & COLOUR_MASK];
    #endif
    #if(NUM_OF_ENGINES >= 4)
      *frame_buffer++ = (iters2 == max_iter)? SET_COLOUR : colour_lookup_table[iters2 & COLOUR_MASK];
      *frame_buffer++ = (iters3 == max_iter)? SET_COLOUR : colour_lookup_table[iters3 & COLOUR_MASK];
    #endif
    #if(NUM_OF_ENGINES >= 8)
      *frame_buffer++ = (iters4 == max_iter)? SET_COLOUR : colour_lookup_table[iters4 & COLOUR_MASK];
      *frame_buffer++ = (iters5 == max_iter)? SET_COLOUR : colour_lookup_table[iters5 & COLOUR_MASK];
      *frame_buffer++ = (iters6 == max_iter)? SET_COLOUR : colour_lookup_table[iters6 & COLOUR_MASK];
      *frame_buffer++ = (iters7 == max_iter)? SET_COLOUR : colour_lookup_table[iters7 & COLOUR_MASK];
    #endif
    #if(NUM_OF_ENGINES >= 16)
      *frame_buffer++ = (iters8 == max_iter)? SET_COLOUR : colour_lookup_table[iters8 & COLOUR_MASK];
      *frame_buffer++ = (iters9 == max_iter)? SET_COLOUR : colour_lookup_table[iters9 & COLOUR_MASK];
      *frame_buffer++ = (iters10 == max_iter)? SET_COLOUR : colour_lookup_table[iters10 & COLOUR_MASK];
      *frame_buffer++ = (iters11 == max_iter)? SET_COLOUR : colour_lookup_table[iters11 & COLOUR_MASK];
      *frame_buffer++ = (iters12 == max_iter)? SET_COLOUR : colour_lookup_table[iters12 & COLOUR_MASK];
      *frame_buffer++ = (iters13 == max_iter)? SET_COLOUR : colour_lookup_table[iters13 & COLOUR_MASK];
      *frame_buffer++ = (iters14 == max_iter)? SET_COLOUR : colour_lookup_table[iters14 & COLOUR_MASK];
      *frame_buffer++ = (iters15 == max_iter)? SET_COLOUR : colour_lookup_table[iters15 & COLOUR_MASK];
    #endif
  }    
}
