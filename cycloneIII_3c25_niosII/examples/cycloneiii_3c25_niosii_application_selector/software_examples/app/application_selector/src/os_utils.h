#ifndef __OS_UTILS_H__
#define __OS_UTILS_H__


#include <stdio.h>
#include "alt_types.h"
#include "includes.h"


#define   SHOW_TASK_STACK_USAGE 0

/* Definition of Task Stack size. */
#define   AS_INITIAL_TASK_STACKSIZE       4096
#define   AS_NETMAN_TASK_STACKSIZE        1024
#define   AS_GWPING_TASK_STACKSIZE        512
#define   AS_HTTP_TASK_STACKSIZE          4096
#define   AS_LED_TASK_STACKSIZE           512
#define   AS_GUI_TASK_STACKSIZE           8192 
#define   AS_SDCARD_TASK_STACKSIZE        2048 
#define   AS_PRINTF_TASK_STACKSIZE        2048


/*
 * Task priorities
 *
 * MicroC/OS-II only allows one task (thread) per priority number. Our web
 * SERVER task is given a high priority (lower only than timers which must run 
 * when they need to) so that we can focus on pushing data *out* of the system.
 * An ethernet CLIENT application would have lower prioritization than the 
 * stack & ethernet tasks.
 */
#define AS_INITIAL_TASK_PRIO 0
//#define AS_SDCARD_PRIO       5
#define AS_SDCARD_PRIO       6
#define AS_LED_PRIO         16 
//#define AS_PRINTF_PRIO       4
#define AS_PRINTF_PRIO       5
//#define AS_GUI_PRIO          6
#define AS_GUI_PRIO          7 
#define AS_NETMAN_PRIO      10
#define AS_HTTP_PRIO        11 
#define AS_GWPING_PRIO      17


/* EXPANDED_DIAGNOSIS_CODE value of 255 is equivalent to -1 
 * (after casting to INT8S) for functions that return -1 as an error_code 
 * to indicate errno has been set. 
 */
 
#define EXPANDED_DIAGNOSIS_CODE 255

typedef enum FAULT_LEVEL_ENUM FAULT_LEVEL;
enum FAULT_LEVEL_ENUM {NONE, TASK, SYSTEM};

// Message sent to PrintfTask
typedef struct {
  char string[256];            // string to print
} as_printf_com_message;
 
void PrintfTask( void* pdata ); 
int OSPrintf( const char * format, ... );
int printf( const char * format, ... );
int fprintf( FILE* stream, const char * format, ... );
void alt_uCOSIIErrorHandler( INT8U error_code, 
                             void *expanded_diagnosis_ptr);

#endif /* __OS_UTILS_H__ */

