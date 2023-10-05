#ifndef SETTINGS_H_
#define SETTINGS_H_

// the dimensions of the rendered image
#define PIX_MAP_WIDTH 800
#define PIX_MAP_HEIGHT 480
#define PIX_MAP_LENGTH 384000 //(PIX_MAP_WIDTH * PIX_MAP_HEIGHT), not using a multiplication because C2H will create a multiply from this

/* used by software and hardware mandelbrot engines */
#define SET_COLOUR 0   // 0 = black, you can use this to change the mandelbrot set colour
#define NUM_OF_ENGINES 4
#define COLOUR_MASK 0xFF

/* how many frames must be rendered before performance numbers are output to the console
 * The frames per second (fps) will be displayed continuously to the screen after each
 * frame has been created */
#define SW_FRAME_DISPLAY_RATE 1  // leave as one since this is slow
#define SW_FRAME_CONSOLE_RATE 1  // leave as one since this is slow
#define HW_FRAME_DISPLAY_RATE 5  // works even at 1 but you should have a few frames worth to get an accurate fps number
#define HW_FRAME_CONSOLE_RATE 60  // don't set this too low, 1 = 60 printfs per second if 60fps is achieved

/* Set DISPLAY_PRESENT to 0 if you want to measure raw rendering speeds without displaying
 * graphically.  Set to 1 if you have a Lancelot VGA card connected to a monitor that supports
 * 16 million colours (24 bit) and a 640x480 screen size. */
#define DISPLAY_PRESENT 1

/* Set this to the number of rows of data present in "demo_coordinates.h". */
#define NUMBER_OF_COORDINATES 13

#endif /*SETTINGS_H_*/

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
