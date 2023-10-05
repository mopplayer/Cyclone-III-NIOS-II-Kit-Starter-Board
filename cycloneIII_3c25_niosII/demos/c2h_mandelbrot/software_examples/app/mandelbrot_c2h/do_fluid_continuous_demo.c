#include "io.h"
#include "settings.h"
#include "movement_functions.h"
#include "buttons.h"
#include "stdlib.h"



/* data structure to make it easier to get at the data contained in "demo_coordinates.h" */
struct coordinates {
  double x;
  double y;
  double dim_x;
  int max_iterations;
};



// This routine is the loop overhead for the continuous demo.
// The coordinates below are some of the interesting points in the Mandelbrot set.
void do_fluid_continuous_demo(alt_touchscreen * screen, alt_video_display * display)
{
  const struct coordinates demo_locations[NUMBER_OF_COORDINATES] = {
    #include "demo_coordinates.h"
  };
  double previous_x = 0.25;
  double previous_y = 0.0;
  double next_x, next_y, next_dim_x;
  int i, next_maxiterations;


  while(1)
  {
    for(i = 0; i < NUMBER_OF_COORDINATES; i++)
    {
      /* read in the contents for the next zoom */
      next_x = demo_locations[i].x;
      next_y = demo_locations[i].y;
      next_dim_x = demo_locations[i].dim_x;
      next_maxiterations = demo_locations[i].max_iterations;
      
      do_fluid_move(previous_x, previous_y, next_x, next_y, screen, display);
      do_fluid_zoom_in(next_x, next_y, next_dim_x, next_maxiterations, screen, display);
      
      /* save off x and y to do the next move when the loop rolls around */
      previous_x = next_x;
      previous_y = next_y;
      colour_swap(); 
    }
  }
}



#define NUM_POINTS 8 // must give an integer value when divided from 256
#define MIN_COLOR 32 // makes sure that the color component generated is equal or above this value (avoid black or dull colors)
#define MAX_COLOR 255 // makes sure that the color component genereated is equal or below (avoid white or bright colors)



inline float bmp_step_delta(int start, int end)
{
  float delta;
  
  if(start > end) 
  {
    delta = start - end;
  }
  else 
  {
    delta = end - start;
  }
  
  delta = delta / (256 / NUM_POINTS);
  
  return delta;
}


inline void slide_and_write_colors(int base, int offset, int start_red, int start_green, int start_blue, int end_red, int end_green, int end_blue)
{
  float delta_red, delta_green, delta_blue;
  char temp_red, temp_green, temp_blue;
  unsigned int temp_color;
  int i;

  delta_red = bmp_step_delta (start_red, end_red);
  delta_green = bmp_step_delta (start_green, end_green);
  delta_blue = bmp_step_delta (start_blue, end_blue);

  for(i=0; i < (256/NUM_POINTS); i++) 
  {
    temp_red = 0xFF & (start_red < end_red)? (start_red + (i * delta_red)) :
                                      (start_red - (i * delta_red));

    temp_green = 0xFF & (start_green < end_green)? (start_green + (i * delta_green)) :
                                      (start_green - (i * delta_green));
                                      
    temp_blue = 0xFF & (start_blue < end_blue)? (start_blue + (i * delta_blue)) :
                                      (start_blue - (i * delta_blue));                                       
    
    temp_color = (0xFF & temp_red) | (0xFF00 & (temp_green << 8)) | (0xFF0000 & (temp_blue << 16));
    IOWR(base, i + offset, temp_color);
  }
}



/* This function is responsible for chaning the colour patterns after each
 * time the algorithm zooms out completely
 */
inline void colour_swap()
{
  static int start_red = 0x55, start_green=0x55, start_blue = 0x55;
  int end_red, end_green, end_blue;
  int i;

  for(i = 0; i < (NUM_POINTS-1); i++)
  {

    // instead of random colors, we could use a fixed set pulled in via an include file
    end_red = (rand() % (MAX_COLOR + 1 - MIN_COLOR)) + MIN_COLOR;  // color is between MIN_COLOR and MAX_COLOR
    end_green = (rand() % (MAX_COLOR + 1 - MIN_COLOR)) + MIN_COLOR;  // color is between MIN_COLOR and MAX_COLOR
    end_blue = (rand() % (MAX_COLOR + 1 - MIN_COLOR)) + MIN_COLOR;  // color is between MIN_COLOR and MAX_COLOR

    slide_and_write_colors(COLOUR_LOOKUP_TABLE_BASE, i * (256 / NUM_POINTS), start_red, start_green, start_blue, end_red, end_green, end_blue);

    start_red = end_red;
    start_green = end_green;
    start_blue = end_blue;
  }

}
