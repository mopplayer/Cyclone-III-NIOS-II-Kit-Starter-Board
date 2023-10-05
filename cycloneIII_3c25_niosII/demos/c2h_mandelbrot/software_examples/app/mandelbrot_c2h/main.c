/******************************************************************************
* Copyright(c) 2007 Altera Corporation, San Jose, California, USA.            *
* All rights reserved. All use of this software and documentation is          *
* subject to the License Agreement located at the end of this file below.     *
*******************************************************************************
 * C2H Mandelbrot Design
 * 
 * Authors:
 * 
 *   RF - Initial Mandelbrot design
 * JCJB - Porting of the fluid demo of the initial design and C2H optimizations
 * 
 * Date:  02/25/2007
 * 
 * Revision History:
 * 
 * 0 - Inital design release
 * 
 * 
 * Design Instructions:
 * 
 * 1)  Connect video card (Lancelot) to proto2 header
 * 2)  Open "hw_mandelbrot.c" and highlight the hw_mandelbrot_engine_0 function
 * 3)  Accelerate the function with the following settings
 *       - Build software, generate SOPC Builder system, and run Quartus II compilation
 *       - Use hardware accelerator in place of software implementation
 * 4)  Repeat step 2 and 3 for all remaining functions
 *       - hw_mandelbrot_engine_2
 *       - ....
 *       - hw_mandelbrot_engine_n (accelerate all of the engine functions)
 *       - hw_frame_stuffer
 * 5)  Wait for the system generaton and compilation to complete (may take over half an hour)
 * 6)  Configure the device and download the compiled software
 * 
 * 
 * Usage:
 * 
 * SW0 = Hardware acceleration enabled
 * SW1 = Software only
 * SW2 = Next zoomout colour palette changes
 * SW3 = Pause the demo (press again to continue
 */



#include "settings.h"
#include "system.h"
#include "alt_video_display.h"
#include "movement_functions.h"
#include "buttons.h"
#include "benchmark.h"
#include "stdio.h"
#include "alt_touchscreen.h"
#include "alt_tpo_lcd.h"
#include "menu.h"



int main()
{
	
  alt_tpo_lcd s_lcd;         // lcd configurator struct
  alt_tpo_lcd *lcd = &s_lcd; // struct pointer
  int result;
  alt_video_display * display;  // LCD display structure
  alt_touchscreen screen;
   
  // Specify base addresses of the each communication bus PIO,
  // as defined in system.h
  lcd->scen_pio = LCD_I2C_CS_BASE;
  lcd->scl_pio  = LCD_I2C_SCL_BASE;
  lcd->sda_pio  = LCD_I2C_DAT_BASE;
   
  // Write the default gamma curve, use 800x480 resolution (default),
  // and verify that the LCD is alive by reading back its Chip/ID 
  // register. Most users will only need to call this routine, and
  // verify that it completed successfully.
  result = alt_tpo_lcd_init(lcd, PIX_MAP_WIDTH, PIX_MAP_HEIGHT);
  if(!result) {
    printf("LCD control registers initilized\n");
  } else {
    printf("LCD control register initialization failed\n");
  }
    
    
  setupTouchPanel(&screen);


  display = alt_video_display_init( "/dev/lcd_sgdma",
                                    PIX_MAP_WIDTH,
                                    PIX_MAP_HEIGHT,
                                    32,
                                    FRAME_BUFFER_BASE,
                                    DESCRIPTOR_MEMORY_BASE,
                                    3);

  printf("C2H Mandelbrot Design\n");
  printf("Press SW0 for hardware accelerated mode (default)\n");
  printf("Press SW1 for software only mode\n");
     
  colour_swap();
  
  // register the ISR that will handle swapping between software and hardware mandlebrot implementations
  init_button_pio();
  
  // clear frame buffers
  alt_video_display_clear_screen(display, ALT_VIDEO_DISPLAY_BLACK_8);

  WelcomeScreen(&screen, display);
  
  // prime the benchmark timer (timestamp timer)
  initialize_benchmark();
  
  // start up the demo
  do_fluid_continuous_demo(&screen, display); 
      
  return 1;   
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
