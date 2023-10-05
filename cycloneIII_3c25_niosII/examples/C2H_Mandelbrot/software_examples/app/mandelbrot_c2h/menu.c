#include "display_drivers.h"
#include "simple_graphics.h"
#include "alt_touchscreen.h"
#include <unistd.h>
#include "buttons.h"
#include "benchmark.h"
#include "movement_functions.h"
#include "alt_eeprom.h"


// Callback will modify these private values
static int touchpanel_pendown = 0;
static int touchpanel_x = 0;
static int touchpanel_y = 0;


void updateScreen(alt_touchscreen * screen)
{
	alt_touchscreen_event_loop_update(screen);
}


// make this update the button variables over in buttons.c
static void down_callback_func (int pen_down, int x, int y, void* context)
{
  touchpanel_pendown = 1;
  touchpanel_x = x;
  touchpanel_y = y;
}

// accessor function for other functions to determine if the screen was pushed (to load up the menu)
int screen_pressed ()
{
  int temp = touchpanel_pendown;
  touchpanel_pendown = 0;
  return temp;
}


static void drawMenuBackground(int horiz_start, int vert_start, int horiz_end, int vert_end, alt_video_display * display)
{
  unsigned int colour;
  unsigned int red, green, blue;
  float increment;
  unsigned int counter = 0;

  blue = 0xFF;
  red = 0;
  green = 0;
  increment = 255 / ((float)(vert_end - vert_start));
  while (vert_start <= vert_end)
  {
    colour = (red<<16) | (green<<8) | blue;
    vid_draw_line(horiz_start, vert_start, horiz_end, vert_start, 1, colour, display);

    counter++;
    red = (unsigned int)(increment * counter);
    green = (unsigned int)(increment * counter);

    vert_start++;
  }
}



int WelcomeScreen(alt_touchscreen * screen, alt_video_display * display)
{
  int error_code = 0;

  char welcomeText[] = "Welcome to the C2H Mandelbrot design example!\n\n\n\n\
This example will render the Mandelbrot set\n\
in 800x480x24 using a software algorithm and\n\
in hardware generated from this software algorithm\n\
using Altera's C to Hardware Acceleration Tool (C2H).\n\n\n\n\
Press anywhere on the screen to continue or load the\n\
menu to make operation mode changes.\
";


  drawMenuBackground(0, 0, 799, 479, display);  // fill the entire screen with a fading blue pattern

  vid_print_string_alpha(130, 50, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, welcomeText);

  rotate_frame_buffers(display);  // will start displaying this message

  // spin waiting for the screen to be pressed
  error_code = alt_touchscreen_register_callback_func (screen,
		                                                   ALT_TOUCHSCREEN_CALLBACK_ON_PEN_DOWN,
		                                                   down_callback_func,
		                                                   NULL);
  if (error_code != 0)
  {
    printf("Could not register the callback, design will start the video without waiting\n");
    usleep(50000000);  // we won't let this failure stop us, waiting 5 seconds so that the message can be read
  }
  else
  {
    updateScreen(screen);  // need to start measuring the touchpanel
    while(screen_pressed() != 1)  // screen_pressed will clear the pendown status
    {
      updateScreen(screen);  // need to keep measuring  
    }
  }

  return error_code;
}



#define BUTTON1_X0 125
#define BUTTON1_Y0 108
#define BUTTON1_X1 275
#define BUTTON1_Y1 178

#define BUTTON2_X0 125
#define BUTTON2_Y0 188
#define BUTTON2_X1 275
#define BUTTON2_Y1 258

#define BUTTON3_X0 125
#define BUTTON3_Y0 268
#define BUTTON3_X1 275
#define BUTTON3_Y1 338

#define BUTTON4_X0 125
#define BUTTON4_Y0 348
#define BUTTON4_X1 275
#define BUTTON4_Y1 418


// handy function for determining if a button has been pushed
static int isButtonPushed(int button_x0, int button_y0, int button_x1, int button_y1)
{
  int return_true = 0;
  if((touchpanel_x >= button_x0) && (touchpanel_x <= button_x1))
  {
    if((touchpanel_y >= button_y0) && (touchpanel_y <= button_y1))
    {
      return_true = 1;
    }
  }
  return return_true;
}


void OpenMenu(alt_touchscreen * screen, alt_video_display * display)
{
  char hwOptionText[] = "Display Mandelbrot set using\n\
C2H hardware acceleration";
  char swOptionText[] = "Display Mandelbrot set using\n\
general purpose CPU (Nios II)";
  char colourOptionText[] = "Select next color palette";
  char continueText[] = "Press to continue";
  int continueButtonPressed = 0;

  alt_video_display_clear_screen (display, BLACK_24);  // clear the screen before drawing menu

  /* Drawing into a single frame buffer so the order of boxes and text matters */

  drawMenuBackground(100, 50, 699, 429, display);

  vid_print_string_alpha(375, 55, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, "Menu");  // Menu text at the top of the white box

  // HW acceleration button
  vid_draw_box (BUTTON1_X0 + 3, BUTTON1_Y0 + 3, BUTTON1_X1 + 3, BUTTON1_Y1 + 3, BLACK_24, DO_FILL, display);
  vid_draw_box (BUTTON1_X0, BUTTON1_Y0, BUTTON1_X1, BUTTON1_Y1, WHITE_24, DO_FILL, display);
  vid_print_string_alpha(BUTTON1_X0 + 25, BUTTON1_Y0 + 20, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, "Hardware");

  // SW only button
  vid_draw_box (BUTTON2_X0 + 3, BUTTON2_Y0 + 3, BUTTON2_X1 + 3, BUTTON2_Y1 + 3, BLACK_24, DO_FILL, display);
  vid_draw_box (BUTTON2_X0, BUTTON2_Y0, BUTTON2_X1, BUTTON2_Y1, WHITE_24, DO_FILL, display);
  vid_print_string_alpha(BUTTON2_X0 + 30, BUTTON2_Y0 + 20, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, "Software");  // SW only button label

  // Colour change button
  vid_draw_box (BUTTON3_X0 + 3, BUTTON3_Y0 + 3, BUTTON3_X1 + 3, BUTTON3_Y1 + 3, BLACK_24, DO_FILL, display);
  vid_draw_box (BUTTON3_X0, BUTTON3_Y0, BUTTON3_X1, BUTTON3_Y1, WHITE_24, DO_FILL, display); 
  vid_print_string_alpha(BUTTON3_X0 + 45, BUTTON3_Y0 + 20, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, "Color");  // Colour change button label

  // Continue button
  vid_draw_box (BUTTON4_X0 + 3, BUTTON4_Y0 + 3, BUTTON4_X1 + 3, BUTTON4_Y1 + 3, BLACK_24, DO_FILL, display);
  vid_draw_box (BUTTON4_X0, BUTTON4_Y0, BUTTON4_X1, BUTTON4_Y1, WHITE_24, DO_FILL, display);  
  vid_print_string_alpha(BUTTON4_X0 + 30, BUTTON4_Y0 + 20, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, "Continue");  // HW acceleration button label


  vid_print_string_alpha(350, 113, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, hwOptionText);  // HW acceleration text
  vid_print_string_alpha(350, 193, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, swOptionText);  // SW only text
  vid_print_string_alpha(350, 288, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, colourOptionText);  // Colour change text
  vid_print_string_alpha(350, 368, BLACK_24, CLEAR_BACKGROUND, timesnewroman_24, display, continueText);  // HW acceleration text

  rotate_frame_buffers(display);  // will start displaying menus, buttons, and text

  updateScreen(screen);

  while (continueButtonPressed != 1)  // change to the detection of the continue button being pressed!
  {
    while (screen_pressed() != 1)
    {
      updateScreen(screen);
    }

    disable_buttons();
    if(isButtonPushed(BUTTON1_X0, BUTTON1_Y0, BUTTON1_X1, BUTTON1_Y1) == 1)
    {
      force_hw_status(1);  // HW on
      force_sw_status(0);  // SW off
      printf("Hardware button pushed\n");
    }
    if(isButtonPushed(BUTTON2_X0, BUTTON2_Y0, BUTTON2_X1, BUTTON2_Y1) == 1)
    {
      force_hw_status(0);  // HW off
      force_sw_status(1);  // SW on
      printf("Software button pushed\n");
    }
    if(isButtonPushed(BUTTON3_X0, BUTTON3_Y0, BUTTON3_X1, BUTTON3_Y1) == 1)
    {
      force_colour_status(1);  // this will make sure the colour_swap function changes the colours
      colour_swap();      // we are paused so swapping immediately
      printf("Color Swap button pushed\n");
    }
    if(isButtonPushed(BUTTON4_X0, BUTTON4_Y0, BUTTON4_X1, BUTTON4_Y1) == 1)
    {
      continueButtonPressed = 1;  // ready to progress
      printf("Continue button pushed\n");
    }
    reenable_buttons();
  }
  
  initialize_benchmark();  // in paused mode so need to reset time so that the fps is calculated properly

  // Need to clear the buffers three times to make the menu disappears and no old frames are left behind
  alt_video_display_clear_screen (display, BLACK_24);
  rotate_frame_buffers(display);
  alt_video_display_clear_screen (display, BLACK_24);
  rotate_frame_buffers(display);
  alt_video_display_clear_screen (display, BLACK_24);
}


int setupTouchPanel(alt_touchscreen * screen)
{
  int error_code = 0;

  alt_two_wire s_eeprom;
  alt_two_wire* eeprom = &s_eeprom;
    
  eeprom->scl_pio = PIO_ID_EEPROM_SCL_BASE;
  eeprom->sda_pio = PIO_ID_EEPROM_DAT_BASE;


  unsigned int top_right_x, top_right_y, bottom_left_x, bottom_left_y;

  struct device devices[] = {
    { 0,    0x10,   0xA0,   0xA1    },
    { 8,    0x400,  0xA0,   0xA1    },
    { 16,   0x800,  0xA0,   0xA1    },
  };
    
  struct device *device = &(devices[0]);  // we only use the first one

  char raw_calibration_data[8];



  alt_2_wireInit(eeprom);
  printf("Device 24LC%d size is 0x%x\n", device->id, device->size);
  alt_2_wireSetDelay(10);


  error_code = alt_touchscreen_init (screen,
				                             TOUCHPANEL_SPI_BASE,
				                             TOUCHPANEL_SPI_IRQ,
				                             TOUCHPANEL_IRQ_N_BASE,
				                             60,    // 60 samples/sec
				                             ALT_TOUCHSCREEN_SWAP_XY);

  /* touchscreen calibration format (offset from address 8)
     bytes 1:0 --> Top right X
     bytes 3:2 --> Top right Y
     bytes 5:4 --> Bottom left X
     bytes 7:6 --> Bottom left Y
  */
  error_code |= readRandom(device, 8, raw_calibration_data, 8);  // touchscreen calibration data in bytes 8-15 

  if (error_code != 0) {
    printf ("Couldn't initialize touchscreen.\n");
  }



  /* big endian format data */
  top_right_x = (0xFF & raw_calibration_data[1]) | (0xFF00 & (raw_calibration_data[0] << 8));
  top_right_y = (0xFF & raw_calibration_data[3]) | (0xFF00 & (raw_calibration_data[2] << 8));
  bottom_left_x = (0xFF & raw_calibration_data[5]) | (0xFF00 & (raw_calibration_data[4] << 8));
  bottom_left_y = (0xFF & raw_calibration_data[7]) | (0xFF00 & (raw_calibration_data[6] << 8));


  /* if all zeros or all ones are read from the EEPROM chances are it's blank and defaults should be used instead */
  if ((top_right_x == 0) | (top_right_x == 0xFFFF)) {
    error_code |= 1;
  }
  if ((top_right_y == 0) | (top_right_y == 0xFFFF)) {
    error_code |= 1;
  }
  if ((bottom_left_x == 0) | (bottom_left_x == 0xFFFF)) {
    error_code |= 1;
  }
  if ((bottom_left_y == 0) | (bottom_left_y == 0xFFFF)) {
    error_code |= 1;
  }


  if(error_code != 0)  // either failed to open, or failed to read back calibration data so defaulting to these values for calibration
  {
    printf("Opening EEPROM failed\n");
    alt_touchscreen_calibrate_upper_right (screen, 
					                                 3946, 3849,    // ADC readings
					                                 799, 0); // pixel coords
    alt_touchscreen_calibrate_lower_left (screen,  
					                                132, 148,     // ADC readings
  					                              0, 479);  // pixel coords

    printf("Using %d, %d, %d, %d default calibration values\n", 3946, 3849, 132, 148);
  }
  else
  {
    alt_touchscreen_calibrate_upper_right (screen, 
					                                 top_right_x, top_right_y,    // ADC readings
                                           799, 0); // pixel coords
    alt_touchscreen_calibrate_lower_left (screen,  
					                                bottom_left_x, bottom_left_y,     // ADC readings
  					                              0, 479);  // pixel coords
    printf("Using %d, %d, %d, %d calibration values\n", top_right_x, top_right_y, bottom_left_x, bottom_left_y);
  }

  return error_code;
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
