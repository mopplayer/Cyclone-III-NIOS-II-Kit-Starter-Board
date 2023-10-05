#include "sys/alt_irq.h"
#include "system.h"
#include "benchmark.h"
#include "altera_avalon_pio_regs.h"

#define HW_BUTTON_PUSHED 1  // SW0
#define SW_BUTTON_PUSHED 2  // SW1
#define COLOUR_CHANGE_BUTTON_PUSHED 4  // SW2
#define PAUSE_BUTTON_PUSHED 8  // SW3

// setting colour change will make sure the initial palette is copied to memory from main
static int hw_mode = 1;  // default mode is hardware accelerator enabled
static int sw_mode = 0;  // hardware acceleration is the default so this must be disabled
static int sw_mode_entered = 0;  // this will be used to detect when software mode is entered
static int colour_mode = 1;  // main will be responsible for populating the colour palette so this needs to be enabled out of reset
static int pause_mode = 0;  // out of reset the design is running

static int edge_capture;  // unused context value


/* This interrupt handler is called when any of the four input push buttons are pressed.
 * Each mode is a seperate statemachine encoded as follows from a high level:
 * 
 * hw_mode <-- is enabled if the HW button (SW0) is pushed or if the algorithm was previously in hw mode without the SW button (SW1) being pushed
 * sw_mode <-- opposite of hardware mode
 * colour_mode <-- when the colour button (SW2) is pushed then enter colour swapping mode (this mode is cleared when the colour swapping routine is run)
 * pause_mode <-- toggles between on and off using an xor of it's previous state
 */
void handle_button_interrupts(void * context, alt_u32 id)
{
  volatile int buttons;
  
  // read in the buttons
  buttons = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PUSH_BUTTONS_BASE);

  // implement the nasty statemachine for hw_mode then invert it for sw_mode
  hw_mode = ((buttons & HW_BUTTON_PUSHED) == HW_BUTTON_PUSHED)? 1 :  // HW button is on
            ((buttons & SW_BUTTON_PUSHED) == SW_BUTTON_PUSHED)? 0 :  // SW button is on
            (hw_mode == 1)? 1 : 0;  // neither SW or HW buttons pressed but previously in hw mode so stay put in hardware mode otherwise must be software mode
            
  sw_mode = (hw_mode == 1)? 0:1;  // if not hardware mode then must be software
  sw_mode_entered = (hw_mode == 1)? 0:1;  // if not hardware mode then must be software
  colour_mode = ((buttons & COLOUR_CHANGE_BUTTON_PUSHED)>>2) | colour_mode;  // switch to colour mode if button is pushed or colour swap hasn't happened yet
  pause_mode = ((buttons & PAUSE_BUTTON_PUSHED)>>3) ^ pause_mode;  // toggle this mode

  IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PUSH_BUTTONS_BASE, 0);  // clear the interrupt (edge capture register)
  IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PUSH_BUTTONS_BASE, 0xF);  // only 4 buttons 
} 


/* initializes the input PIO for the push buttons and registers the interrupt handler
 * associated to the button functionality.
 */
void init_button_pio()
{
  void * edge_capture_ptr = (void *) &edge_capture;
 
  IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PUSH_BUTTONS_BASE, 0x0);
  IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PUSH_BUTTONS_BASE, 0xF); // only 4 buttons
 //   alt_irq_register(PUSH_BUTTONS_IRQ, edge_capture_ptr, handle_button_interrupts);
  alt_ic_isr_register(PUSH_BUTTONS_IRQ_INTERRUPT_CONTROLLER_ID, PUSH_BUTTONS_IRQ, handle_button_interrupts, edge_capture_ptr, NULL);
}


/* accessor functions to determine the current "mode" state of the design.  Multiple
 * states can be enabled concurrently and each state is either 0 or 1 (1 is enabled).
 */
int return_hw_status()
{
  return hw_mode;
}

int return_sw_status()
{
  return sw_mode; 
}

int return_sw_entered_status()
{
  int temp = sw_mode_entered;
  sw_mode_entered = 0;  // we have detected that software mode has been entered, time to clear it
  return temp;
}

// calling this will clear the status
int return_colour_status()
{
  int temp = colour_mode;
  colour_mode = 0; // turn this status back off
  return temp;
}

int return_pause_status()
{
  return pause_mode;
}



/* These functions will be used by OpenMenu to change the mode
   of operation (from the screen instead of the push buttons).
   Pause isn't needed since the OpenMenu will pause the design.
 */
void force_hw_status(int on_off)
{
  hw_mode = on_off;
}


void force_sw_status(int on_off)
{
  sw_mode = on_off;
  sw_mode_entered = on_off;
}


void force_colour_status(int on_off)
{
  colour_mode = 1;
}


/* Even thought it would be hard for someone to push the buttons
   on the board and the screen at the same time we better play it
   safe and use the screen settings first then re-enable the push
   button interrupt.  Failing to do this could cause the statemachine
   in handle_button_interrupts to get out of sync */
void disable_buttons()
{
  alt_ic_irq_disable(PUSH_BUTTONS_IRQ_INTERRUPT_CONTROLLER_ID,PUSH_BUTTONS_IRQ);
//	alt_irq_disable(PUSH_BUTTONS_IRQ);
}

void reenable_buttons()
{
  alt_ic_irq_enable(PUSH_BUTTONS_IRQ_INTERRUPT_CONTROLLER_ID,PUSH_BUTTONS_IRQ);
//	alt_irq_enable(PUSH_BUTTONS_IRQ);
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
