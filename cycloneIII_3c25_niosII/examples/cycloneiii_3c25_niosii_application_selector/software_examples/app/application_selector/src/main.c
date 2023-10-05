/*****************************************************************************
 *  File: main.c
 * 
 *  This file is the top level of the application selector.
 *
 ****************************************************************************/
#include <stdio.h>
#include <unistd.h>
#include "io.h"
#include "elca_fat.h"
#include "app_selector_gui.h"
#include "app_selector.h"
#include "alt_touchscreen.h"
#include "alt_video_display.h"
#include "alt_tpo_lcd.h"
#include "sd_card.h"


// UCOS-II definitions
#include "includes.h"
#include "os_utils.h"

// Nichestack definitions 
#include "ipport.h"
#include "libport.h"
#include "osport.h"
#include "tcpport.h"
#include "net.h"
#include "webserver.h"

// Task Stacks
OS_STK led_task_stk[AS_LED_TASK_STACKSIZE];
OS_STK gui_task_stk[AS_GUI_TASK_STACKSIZE];
OS_STK sdcard_task_stk[AS_SDCARD_TASK_STACKSIZE];
OS_STK printf_task_stk[AS_PRINTF_TASK_STACKSIZE];

// Semaphores
OS_EVENT *TouchscreenSem;
OS_EVENT *FlashSem;

// Message Boxes
OS_EVENT* As_WebserverStatusMbox;
extern char ws_msg_string[256];

// Network init.
extern void NETInit();

/*****************************************************************************
 *  Function: ASInitialTask
 *
 *  Purpose: ASInitialTask will initialize the NichStack TCP/IP stack and 
 *           then initialize the rest of the application selector example 
 *           tasks.
 * 
 *  Returns: void
 ****************************************************************************/
void ASInitialTask( void* pdata )
{
  INT8U return_code = OS_NO_ERR;

  // The touchscreen needs to wait to initialize until the 
  // LCD has been fully intialized.
  TouchscreenSem = OSSemCreate( 0 );
  
  // Initialize the semaphore we use to control access to the flash.
  FlashSem = OSSemCreate( 1 );
  
  // Initialize the Web Server Status message box.
  As_WebserverStatusMbox = OSMboxCreate((void *)0);  
  
/*****************************************************************************
 *  Create the system tasks.
 ****************************************************************************/

  return_code = OSTaskCreateExt( PrintfTask,
                                 NULL,
                                 (void *)&printf_task_stk[AS_PRINTF_TASK_STACKSIZE],
                                 AS_PRINTF_PRIO,
                                 AS_PRINTF_PRIO,
                                 printf_task_stk,
                                 AS_PRINTF_TASK_STACKSIZE,
                                 NULL,
                                 OS_TASK_OPT_STK_CHK + OS_TASK_OPT_STK_CLR );
  alt_uCOSIIErrorHandler( return_code, 0 );

  return_code = OSTaskCreateExt( LedTask,
                                 NULL,
                                 (void *)&led_task_stk[AS_LED_TASK_STACKSIZE],
                                 AS_LED_PRIO,
                                 AS_LED_PRIO,
                                 led_task_stk,
                                 AS_LED_TASK_STACKSIZE,
                                 NULL,
                                 OS_TASK_OPT_STK_CHK + OS_TASK_OPT_STK_CLR );
  alt_uCOSIIErrorHandler( return_code, 0 );

  return_code = OSTaskCreateExt( GuiTask,
                                 NULL,
                                 (void *)&gui_task_stk[AS_GUI_TASK_STACKSIZE],
                                 AS_GUI_PRIO,
                                 AS_GUI_PRIO,
                                 gui_task_stk,
                                 AS_GUI_TASK_STACKSIZE,
                                 NULL,
                                 OS_TASK_OPT_STK_CHK + OS_TASK_OPT_STK_CLR );
  alt_uCOSIIErrorHandler( return_code, 0 );

  return_code = OSTaskCreateExt( SDCardTask,
                                 NULL,
                                 (void *)&sdcard_task_stk[AS_SDCARD_TASK_STACKSIZE],
                                 AS_SDCARD_PRIO,
                                 AS_SDCARD_PRIO,
                                 sdcard_task_stk,
                                 AS_SDCARD_TASK_STACKSIZE,
                                 NULL,
                                 OS_TASK_OPT_STK_CHK + OS_TASK_OPT_STK_CLR );
  alt_uCOSIIErrorHandler( return_code, 0 );

  // Initialize the Network.
  NETInit();
  // This task deletes itself, since there's no reason to keep it around, once
  // it's complete.
  return_code = OSTaskDel( OS_PRIO_SELF );
  alt_uCOSIIErrorHandler( return_code, 0 );

  while(1); // Correct Program Flow should not reach here.
}


int main()
{

  INT8U return_code;
  OS_STK ASInitialTaskStk[AS_INITIAL_TASK_STACKSIZE];
  
  
  /* Clear the RTOS timer */
  OSTimeSet(0);
  
  /* ASInitialTask will initialize the NicheStack TCP/IP Stack and then 
   * initialize the rest of the web server's tasks.
   */ 

  return_code = OSTaskCreateExt( ASInitialTask,
                                 NULL,
                                 (void *)&ASInitialTaskStk[AS_INITIAL_TASK_STACKSIZE],
                                 AS_INITIAL_TASK_PRIO,
                                 AS_INITIAL_TASK_PRIO,
                                 ASInitialTaskStk,
                                 AS_INITIAL_TASK_STACKSIZE,
                                 NULL,
                                 0 );
  alt_uCOSIIErrorHandler( return_code, 0 );
  
  /*
   * As with all MicroC/OS-II designs, once the initial thread(s) and 
   * associated RTOS resources are declared, we start the RTOS. That's it!
   */
  OSStart();
  
  while(1); /* Correct Program Flow never gets here. */

  return ( 0 );
}

