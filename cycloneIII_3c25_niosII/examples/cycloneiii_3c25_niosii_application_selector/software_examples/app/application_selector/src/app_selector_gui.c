/*****************************************************************************
 *  File: app_selector_gui.c
 * 
 *  This file contains functions for performing the graphics interface tasks
 *  of the application selector.
 * 
 ****************************************************************************/
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <io.h>
#include <math.h>
#include "includes.h"
#include "app_selector_gui.h"
#include "alt_video_display/alt_video_display.h"
#include "alt_touchscreen/alt_touchscreen.h"
#include "app_selector.h"
#include "os_utils.h"
#include "webserver.h"

// Include the Interniche task priorities.
#include "ipport.h"

int InMainMenu;

struct IcmpMib {
   u_long   icmpInMsgs;          /* 1 - received icmp packets, including errors */
   u_long   icmpInErrors;        /* 2 - bad sums, bad len, etc. */
   u_long   icmpInDestUnreachs;  /* 3 - no comments for self explanitorys */
   u_long   icmpInTimeExcds;     /* 4 */
   u_long   icmpInParmProbs;     /* 5 */
   u_long   icmpInSrcQuenchs;    /* 6 */
   u_long   icmpInRedirects;     /* 7 */
   u_long   icmpInEchos;         /* 8 */
   u_long   icmpInEchoReps;      /* 9 */
   u_long   icmpInTimestamps;    /* 10 */
   u_long   icmpInTimestampReps; /* 11 */
   u_long   icmpInAddrMasks;     /* 12 */
   u_long   icmpInAddrMaskReps;  /* 13 */
   u_long   icmpOutMsgs;         /* 14 - total sent icmps, including errors */
   u_long   icmpOutErrors;       /* 15 - ICMP Layer errors ONLY (see rfc #1156) */
   u_long   icmpOutDestUnreachs; /* 16 */
   u_long   icmpOutTimeExcds;    /* 17 */
   u_long   icmpOutParmProbs;    /* 18 */
   u_long   icmpOutSrcQuenchs;   /* 19 */
   u_long   icmpOutRedirects;    /* 20 */
   u_long   icmpOutEchos;        /* 21 */
   u_long   icmpOutEchoReps;     /* 22 */
   u_long   icmpOutTimestamps;   /* 23 */
   u_long   icmpOutTimestampReps;/* 24 */
   u_long   icmpOutAddrMasks;    /* 25 */
   u_long   icmpOutAddrMaskReps; /* 26 */
};

extern struct IcmpMib icmp_mib;

extern OS_EVENT *TouchscreenSem;
extern OS_EVENT* As_WebserverStatusMbox;

void GuiTask( void* pdata )
{

  // This is our list of apps stored in flash
  app_list_struct* app_list;
  
  // This is our LCD display
  alt_video_display* display;
  
  // This is our LCD configuration port
  alt_tpo_lcd lcd_serial;

  // This is our touch panel
  alt_touchscreen touchscreen;            

  // Allocate our app list structure memory
  app_list = malloc( sizeof( app_list_struct ));

  // Initialize and start the LCD display
  display = alt_video_display_init( ALT_VIDEO_DISPLAY_SGDMA_NAME,         // char* sgdma_name
                                    ALT_VIDEO_DISPLAY_COLS,               // int width
                                    ALT_VIDEO_DISPLAY_ROWS,               // int height
                                    ALT_VIDEO_DISPLAY_COLOR_DEPTH,        // int color_depth
                                    ALT_VIDEO_DISPLAY_USE_HEAP,           // int buffer_location
                                    ALT_VIDEO_DISPLAY_USE_HEAP,           // int descriptor_location
                                    2 );                                  // int num_buffers

  // Set the Gamma Curve and Resolution of the LCD
  AsInitTpoLcd( &lcd_serial );

  // Initialize the touchscreen
  AsInitTouchscreen( &touchscreen );

  AsMainMenu( display, app_list, &touchscreen );

  while (1);

  free( app_list );
  free( display );
}



void LedTask( void* pdata )
{
  char led_value = 0;

  while (1)
  {
    // Flip the led
    led_value ^= 0x1;
  
    // Now display it.
    IOWR( LED_PIO_BASE, 0, led_value );
    
    // Wait 1/4 second
    OSTimeDlyHMSM( 0, 0, 0, 250 );
  }
}


/*****************************************************************************
 *  Function: AsInitTouchscreen
 *
 *  Purpose: Initialize the touchscreen and set the calibration values.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsInitTouchscreen( alt_touchscreen* touchscreen )
{

  // Initialize the touch panel
  alt_touchscreen_init ( touchscreen,
                         TOUCH_PANEL_SPI_BASE,
                         TOUCH_PANEL_SPI_IRQ,
                         TOUCH_PANEL_PEN_IRQ_N_BASE,
                         60,    // 60 samples/sec
                         ALT_TOUCHSCREEN_SWAP_XY);

  // Calibrate the touch panel
  alt_touchscreen_calibrate_upper_right (touchscreen,
           3946,   3849,    // ADC readings
            799,      0  ); // pixel coords
  alt_touchscreen_calibrate_lower_left  (touchscreen,
           132,    148,     // ADC readings
             0,    479  );  // pixel coords

  return( 0 );
}





/*****************************************************************************
 *  Function: AsMainMenu
 *
 *  Purpose: Operates the top-level main menu behavior.  This
 *           function draws the menu, senses activity on the
 *           touchscreen, and updates the menu accordingly.
 *           When activity on the touchscreen indicates that some
 *           action needs to be taken i.e. pressing the "load"
 *           button, this function makes the appropriate calls
 *           to perform those actions.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsMainMenu( alt_video_display* display, 
                app_list_struct* app_list,
                alt_touchscreen* touchscreen )
{
  
  unsigned int command_button_state = 0;
  unsigned int scroll_button_state = 0;
  int i;
  int pen_is_down = 0;
  int touchscreen_x, touchscreen_y;
  int ticks_at_last_pen_touch;
  char string[128];
  int ret_code;
  extern struct gimp_image_struct gimp_image_CIII_logo;
  progress_bar progress_bar;
  char* web_server_status;

  InMainMenu = 1;
  
  // The main elements of the menu
  menu_title_struct title;
  buttons_struct selection_buttons;
  buttons_struct command_buttons;
  buttons_struct scroll_buttons;
  
  // Put up a splash screen before we start rendering the menu graphics.
  AsDisplaySplashScreen( display, &gimp_image_CIII_logo );
  
  // Open the SD Card and collect the number and names of all the apps found there.
  ret_code = AsFindAppsOnSD( app_list );
  if( ret_code )
  {
    sprintf( string, "Error: Could not find any Applications on SD Card\nInsert a properly loaded SD Card then reset the board." );
    AsConfirmInfoWindow( display, touchscreen, string, OK_ONLY );
  }
  
  AsBuildProgressBar((( ALT_VIDEO_DISPLAY_COLS - SPLASH_SCREEN_PROGRESS_BAR_WIDTH ) / 2 ), 
                      ( SPLASH_SCREEN_PROGRESS_BAR_Y_START ),
                      ( SPLASH_SCREEN_PROGRESS_BAR_WIDTH ), 
                      ( SPLASH_SCREEN_PROGRESS_BAR_HEIGHT ),
                      ( 10 ),
                      ( SPLASH_SCREEN_PROGRESS_BAR_COLOR ),
                      ( &progress_bar ));
  
  AsUpdateProgressBar( &progress_bar, display, ( 100 / app_list->num_apps + 1 ));
  
  // Start the list of selections from the top (scrolled all the way up)
  selection_buttons.scroll_position = 0;

  // Build and render all the menu elements
  AsBuildMainMenuTitle( &title );
  AsBuildSelectionButtons( &selection_buttons, app_list, display, &progress_bar );
  AsBuildMainMenuCommandButtons( &command_buttons );
  AsBuildScrollButtons( &scroll_buttons );
  AsInitButtonStates( &selection_buttons, &command_buttons, &scroll_buttons );
    
  // Display the menu
  AsPrintMainMenu( display, &title, &selection_buttons, &command_buttons, &scroll_buttons );

  // This initializes the timout for the screensaver
  ticks_at_last_pen_touch = OSTimeGet();
  
  // Read the touch screen and perform whatever actions it dictates
  while(1) 
  {
    // Allow web server task some time to run.
    OSTimeDlyHMSM( 0, 0, 0, 10 );    

    // Gather the latest touchscreen coordinates
    alt_touchscreen_get_pen ( touchscreen, &pen_is_down, &touchscreen_x, &touchscreen_y );

    // If there is activity on the touchscreen, reset the screensaver timeout
    if( pen_is_down )
      ticks_at_last_pen_touch = OSTimeGet();

    // Turn on the screen saver if we've been inactive for long enough.
    if((( OSTimeGet() - ticks_at_last_pen_touch ) / alt_ticks_per_second() ) > AS_SCR_SVR_TIMEOUT )
    {
      ticks_at_last_pen_touch = AsScreenSaver( display, touchscreen, &gimp_image_CIII_logo );
      AsPrintMainMenu( display, &title, &selection_buttons, &command_buttons, &scroll_buttons );
    }
   
    // Determine how the touchscreen coordinates affect the command buttons, 
    // and redraw them if neccessary.  Note that the command buttons can be
    // affected even if the touchscreen coordinates are somewhere other than on 
    // the command button, or even if the pen is up.  This is because you have to
    // redraw the buttons when the pen slides off or lifts up from them.
    command_button_state = AsUpdateCommandButtons( display, touchscreen_x, touchscreen_y, 
                                                   pen_is_down, &command_buttons );
    
    // Determine how the touchscreen coordinates affect the scroll buttons.
    scroll_button_state = AsUpdateScrollButtons( display, touchscreen_x, touchscreen_y, 
                                                 pen_is_down, &scroll_buttons );
    
    // Update the app selection buttons to either a selected or not-selected state,
    // depending on the touchscreen coordinates.
    AsUpdateAppSelectionList( display, touchscreen_x, touchscreen_y, pen_is_down, &selection_buttons );  

    web_server_status = OSMboxAccept( As_WebserverStatusMbox );
    if( web_server_status )
    {
      AsUpdateCommandButtonText( display, &( command_buttons.button[MAIN_MENU_WEB_BUTTON_INDEX] ), web_server_status );
    }

    // If the scroll buttons were pressed in a way that affects the scroll position 
    // of the app selection list, redraw the selection list with the new scroll position.
    if( scroll_button_state == BUTTON_SELECTED )
    {
      // "Scroll up" means the scroll button pointing up was pressed.  The
      // selection items will actually appear to move down, but we're going
      // "up" the list, so we call it scrolling up.
      if(( scroll_buttons.button[SCROLL_UP_INDEX].is_selected ) && 
         ( selection_buttons.scroll_position > 0 ))
      {
        selection_buttons.scroll_position--;
      }
      // "Scroll down" means the scroll button pointing down was pressed.
      else if(( scroll_buttons.button[SCROLL_DOWN_INDEX].is_selected ) &&
              ( selection_buttons.scroll_position < selection_buttons.num_buttons - MENU_ITEMS_ON_SCREEN_AT_ONCE ))
      {
        selection_buttons.scroll_position++;
      }

      // Now that we've updated the scroll position, redraw the selection list at the new
      // scroll position, and update the little scroll indicator.
      AsRedrawSelectionList( &selection_buttons, app_list, display );   
      AsUpdateScrollIndicator( display, selection_buttons.scroll_position, selection_buttons.num_buttons );
    }
    
    // If there was a pen-up event on a command button, we need to take whatever action
    // that particular command button dictates.
    if( command_button_state == BUTTON_PEN_UP )
    {
      // First find out which application was selected at the time of the command button release
      for( i = 0; i < selection_buttons.num_buttons; i++ )
      {
        if( selection_buttons.button[i].is_selected )
        {
          app_list->target_app = i;
          break;
        }
      }
      
      // If there was a pen up on the Load button, we need to load the selected
      // application into flash and run it.
      if(( command_buttons.button[MAIN_MENU_LOAD_BUTTON_INDEX].pen_up_event_occured ) &&
         ( i != selection_buttons.num_buttons ))
      {
         AsLoadAppFromSDCard( app_list->apps[app_list->target_app].app_name,
                              display,
                              touchscreen );

      }
      // If there was a pen-up event on the Show Info button, we need to bring up the 
      // info screen for the selected application.
      else if( command_buttons.button[MAIN_MENU_INFO_BUTTON_INDEX].pen_up_event_occured )
      {
        AsShowAppInfo( app_list->apps[app_list->target_app].app_name, 
                       display,
                       touchscreen );
        // When we return from the info screen, we need to re-display the main menu.
        AsPrintMainMenu( display, &title, &selection_buttons, &command_buttons, &scroll_buttons );
        ticks_at_last_pen_touch = OSTimeGet();                       
      }
      // If there was a pen-up event on the Web status button, we need to bring up the 
      // webserver info screen.
      else if( command_buttons.button[MAIN_MENU_WEB_BUTTON_INDEX].pen_up_event_occured )
      {
        AsShowWebServerInfo( display, touchscreen );
        // When we return from the info screen, we need to re-display the main menu.
        AsPrintMainMenu( display, &title, &selection_buttons, &command_buttons, &scroll_buttons );
        ticks_at_last_pen_touch = OSTimeGet();                       
      }    }
  }
  return( 0 );
}
        
    
/*****************************************************************************
 *  Function: AsScreenSaver
 *
 *  Purpose: This function operates the screen saver for the application 
 *           selector.  The screen saver is a bitmap which is bounced
 *           around the screen slowly.  The screen saver function exits
 *           as soon as the touchscreen is touched anywhere.
 * 
 *  Returns: The value of the system clock upon exit of this function
 ****************************************************************************/
int AsScreenSaver( alt_video_display* display, 
                   alt_touchscreen* touchscreen, 
                   struct gimp_image_struct* image )
{
  int i;
  bitmap_struct* splash_image;
  char* splash_image_dest;
  int x = 0;
  int y = 0;
  int prev_x[ALT_VIDEO_DISPLAY_MAX_BUFFERS];
  int prev_y[ALT_VIDEO_DISPLAY_MAX_BUFFERS];
  int x_incr = AS_SCR_SVR_INCR_VALUE;
  int y_incr = AS_SCR_SVR_INCR_VALUE;
  int dummy_ptr, pen_is_down;
  OS_TCB task_data;
  INT8U err; 
  INT8U status;
  
  InMainMenu = 0;
  
  // First thing we do is clear the screen of all frame buffers.
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    alt_video_display_clear_screen( display, 0x0 );
    alt_video_display_register_written_buffer( display );
  }

  if(( splash_image = malloc( sizeof( bitmap_struct ))) != NULL )
  {
    // This loads the bitmap into a bmp struct from which we can display it.
    load_gimp_bmp( image, splash_image, 32);

    // We keep a queue of the previous positions to which the bitmap was written
    // So that we can erase it without having to clear the whole screen.
    // Here we zero the queue
    for( i = 0; i < ALT_VIDEO_DISPLAY_MAX_BUFFERS; i ++ )
    {
      prev_x[i] = 0;
      prev_y[i] = 0;
    }

    // Now move the image around the screen until the touchscreen is touched.
    do
    {
      // If any of the networking tasks has something to do, give them some time.
      err = OSTaskQuery( TK_NETMAIN_TPRIO, &task_data );
      if( err == OS_NO_ERR )
      {
        status = task_data.OSTCBStat;
        if( status == OS_STAT_RDY )
        {
          OSTimeDlyHMSM( 0, 0, 0, 10 );
        }
      }
      err = OSTaskQuery( TK_NETTICK_TPRIO, &task_data );
      if( err == OS_NO_ERR )
      {
        status = task_data.OSTCBStat;
        if( status == OS_STAT_RDY )
        {
          OSTimeDlyHMSM( 0, 0, 0, 10 );
        }
      }
      err = OSTaskQuery( AS_NETMAN_PRIO, &task_data );
      if( err == OS_NO_ERR )
      {
        status = task_data.OSTCBStat;
        if( status == OS_STAT_RDY )
        {
          OSTimeDlyHMSM( 0, 0, 0, 10 );
        }
      }
      
      // If the webserver task is ready to run, give it some time to do so.
      err = OSTaskQuery( AS_HTTP_PRIO, &task_data );
      if( err == OS_NO_ERR )
      {
        status = task_data.OSTCBStat;
        if( status == OS_STAT_RDY )
        {
          OSTimeDlyHMSM( 0, 0, 0, 10 );
        }
      }


      if( alt_video_display_buffer_is_available( display ) == 0 )
      {
        // Erase the last image that was drawn to this display buffer
        vid_paint_block( prev_x[ALT_VIDEO_DISPLAY_MAX_BUFFERS - 1],
                         prev_y[ALT_VIDEO_DISPLAY_MAX_BUFFERS - 1], 
                         prev_x[ALT_VIDEO_DISPLAY_MAX_BUFFERS - 1] + splash_image->biWidth,
                         prev_y[ALT_VIDEO_DISPLAY_MAX_BUFFERS - 1] + splash_image->biHeight,
                         BLACK_24, 
                         display );
    
        // Now copy the image into this display buffer at a new location.
        splash_image_dest = (char*)(( display->buffer_ptrs[display->buffer_being_written]->buffer ) + 
                                    (( y  * display->width ) * 4 ) +
                                    ( x  * 4 ));

        AsVidCopyImageToBuffer( splash_image_dest,
                          splash_image->data, 
                          display->width, 
                          splash_image->biWidth, 
                          splash_image->biHeight );
                      
        alt_video_display_register_written_buffer( display );

        // Save our x and y in the queue so we can erase the image later
        for( i = ALT_VIDEO_DISPLAY_MAX_BUFFERS - 1; i > 0; i -- )
        {
          prev_x[i] = prev_x[i-1];
          prev_y[i] = prev_y[i-1];
        }
        prev_x[0] = x;
        prev_y[0] = y;
      
        // Increment the x and y location of the image.
        // The image only moves at 45 degree angles, so when we reach
        // an edge, we just reverse the polarity of the increment value.
        if(( x_incr == 1 ) && ( x + splash_image->biWidth >= display->width ))
          x_incr = -AS_SCR_SVR_INCR_VALUE;
        else if(( x_incr == -1 ) && ( x <= 0 ))
          x_incr = AS_SCR_SVR_INCR_VALUE;

        if(( y_incr == 1 ) && ( y + splash_image->biHeight >= display->height ))
          y_incr = -AS_SCR_SVR_INCR_VALUE;
        else if(( y_incr == -1 ) && ( y <= 0 ))
          y_incr = AS_SCR_SVR_INCR_VALUE;

        x += x_incr;
        y += y_incr;
      }

      // See if there was a touch on the touchscreen.
      alt_touchscreen_get_pen ( touchscreen, &pen_is_down, &dummy_ptr, &dummy_ptr );
    } while( !pen_is_down );

    free_gimp_bmp_data( splash_image );
    free( splash_image );
  }

  InMainMenu = 1;
  
  return( OSTimeGet() );
  
}


/*****************************************************************************
 *  Function: AsDisplaySplashScreen
 *
 *  Purpose: Loads a C-code bitmap created by Gimp, and copies it to the 
 *           current display buffer.
 * 
 *  Returns: void
 ****************************************************************************/
void AsDisplaySplashScreen( alt_video_display* display,
                            struct gimp_image_struct* CIII_image )
{

  bitmap_struct* image;
  char* image_dest;
  int text_width;
  int i;

  image = malloc(sizeof(bitmap_struct));
  
  if( image != NULL )
  {
    // Load the CIII logo
    load_gimp_bmp( CIII_image, image, 32);
    
    for( i = 0; i < display->num_frame_buffers; i++ )
    {
      image_dest = (char*)(( display->buffer_ptrs[display->buffer_being_written]->buffer ) + 
                           (((( display->height - image->biHeight ) / 2 ) * display->width ) * 4 ) +
                           ((( display->width - image->biWidth ) / 2 ) * 4 ));      
      // Copy the image to the current display buffer
      AsVidCopyImageToBuffer( image_dest,
                              image->data, 
                              display->width, 
                              image->biWidth, 
                              image->biHeight );

      // Print splash screen text
      text_width = vid_string_pixel_length_alpha( tahomabold_20, SPLASH_SCREEN_TEXT );
      vid_print_string_alpha(( ALT_VIDEO_DISPLAY_COLS - text_width ) / 2 , 
                               350,
                               WHITE_24, 
                               BLACK_24, 
                               tahomabold_20, 
                               display, 
                               SPLASH_SCREEN_TEXT );
    
      alt_video_display_register_written_buffer( display );
    }

    free_gimp_bmp_data( image );
    free( image );
  }
} 


/*****************************************************************************
 *  Function: AsRedrawSelectionList
 *
 *  Purpose: Redraws the just selection buttons portion of the main menu.
 *           This function is called after the scroll position changes,
 *           and we need to redraw all the selection buttons, but no
 *           other parts of the main menu. 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsRedrawSelectionList( buttons_struct* selection_buttons,
                           app_list_struct* app_list,
                           alt_video_display* display )
{
  int i;
  
  // We draw to both frame buffers so that when other routines draw smaller bits
  // to a single frame, they dont have to redraw this too. 
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    // Print the selection buttons
    AsPrintSelectionButtons( display, selection_buttons );
    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }
  
  return( 0 );
}

/*****************************************************************************
 *  Function: AsBuildProgressBar
 *
 *  Purpose: Initializes and builds up the dimensions of a progress bar
 *           The only thing you need to provide to this function
 *           is a pointer to an uninitialized progress bar structure.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildProgressBar( int x_start, int y_start, int x_size, int y_size, int corner_radius, int color, progress_bar* bar )
{

  bar->size_x = x_size;
  bar->loc_x = x_start;

  bar->loc_y = y_start;
  bar->size_y = y_size;
  
  bar->corner_radius = corner_radius;
  bar->color = color;

  return( 0 );
}

/*****************************************************************************
 *  Function: AsUpdateProgressBar
 *
 *  Purpose: Updates the progress bar with the specified percentage.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsUpdateProgressBar( progress_bar* bar, alt_video_display* display, int percent_complete )
{
  
  int progress_bar_active_width;
  
  progress_bar_active_width = (( bar->size_x * percent_complete) / 100 );
    
  vid_draw_round_corner_box( bar->loc_x, 
                             bar->loc_y, 
                             bar->loc_x + progress_bar_active_width,
                             bar->loc_y + bar->size_y,
                             bar->corner_radius ,
                             bar->color, 
                             DO_FILL, 
                             display );

  alt_video_display_register_written_buffer( display );
  
  return( 0 );

}

/*****************************************************************************
 *  Function: AsBuildProgressWindow
 *
 *  Purpose: Initializes and builds up the dimensions of a progress bar
 *           window.  The only thing you need to provide to this function
 *           is a pointer to an uninitialized progress bar window structure,
 *           and a string to print inside the window.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildProgressWindow( char* text, progress_window* window )
{

  unsigned int string_length_pixels;
  
  string_length_pixels = vid_string_pixel_length_alpha( PROGRESS_WINDOW_TEXT_FONT, text );
  
  window->size_x  = string_length_pixels + 40;
  window->loc_x = (( ALT_VIDEO_DISPLAY_COLS - window->size_x ) / 2 );

  window->loc_y = (( ALT_VIDEO_DISPLAY_ROWS - PROGRESS_WINDOW_Y_HEIGHT ) / 2 );
  window->size_y = PROGRESS_WINDOW_Y_HEIGHT;
  
  window->corner_radius = WINDOW_CORNER_RADIUS;
  
  strcpy( window->text, text );
  
  window->text_start_x = window->loc_x + 20;
  window->text_start_y = window->loc_y + ( window->size_y / 3 );
  
  window->bar_start_x = window->loc_x + 30;
  window->bar_size_x = window->size_x - 60;
  window->bar_start_y = window->loc_y + (( window->size_y * 2 ) / 3 );
  window->bar_size_y = PROGRESS_WINDOW_PROG_BAR_HEIGHT;

  return( 0 );
}

/*****************************************************************************
 *  Function: AsPrintProgressWindow
 *
 *  Purpose: Draws a window containing a progress bar.  The progress bar 
 *           itself is not drawn though, it is drawn later with a call to 
 *           AsUpdateProgressWindow();
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintProgressWindow( progress_window* window, alt_video_display* display )
{
  

  int i;
  
  // We print everying to both buffers so we dont have to redraw it every time
  // we make a little change to the screen.
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    // Print the popup border
    vid_draw_round_corner_box( window->loc_x - PROGRESS_WINDOW_BORDER_WIDTH, 
                               window->loc_y - PROGRESS_WINDOW_BORDER_WIDTH, 
                               window->loc_x + window->size_x + PROGRESS_WINDOW_BORDER_WIDTH,
                               window->loc_y + window->size_y + PROGRESS_WINDOW_BORDER_WIDTH,
                               window->corner_radius + PROGRESS_WINDOW_BORDER_WIDTH,
                               PROGRESS_WINDOW_BORDER_COLOR, 
                               DO_FILL, 
                               display );

    // Print the popup interior
    vid_draw_round_corner_box( window->loc_x, 
                               window->loc_y, 
                               window->loc_x + window->size_x,
                               window->loc_y + window->size_y,
                               window->corner_radius,
                               PROGRESS_WINDOW_BODY_COLOR, 
                               DO_FILL, 
                               display );

    // Print window text
    vid_print_string_alpha( window->text_start_x, 
                            window->text_start_y,
                            PROGRESS_WINDOW_TEXT_COLOR, 
                            PROGRESS_WINDOW_BODY_COLOR, 
                            PROGRESS_WINDOW_TEXT_FONT, 
                            display, 
                            window->text );
                            
    // Draw progress bar frame
    vid_draw_round_corner_box( window->bar_start_x, 
                               window->bar_start_y, 
                               window->bar_start_x + window->bar_size_x,
                               window->bar_start_y + window->bar_size_y,
                               5,
                               PROGRESS_WINDOW_PROG_BAR_FRAME_COLOR, 
                               DO_FILL, 
                               display );

    vid_draw_round_corner_box( window->bar_start_x + PROGRESS_WINDOW_BORDER_WIDTH, 
                               window->bar_start_y + PROGRESS_WINDOW_BORDER_WIDTH, 
                               window->bar_start_x + window->bar_size_x - PROGRESS_WINDOW_BORDER_WIDTH,
                               window->bar_start_y + window->bar_size_y - PROGRESS_WINDOW_BORDER_WIDTH,
                               5 - PROGRESS_WINDOW_BORDER_WIDTH,
                               PROGRESS_WINDOW_BODY_COLOR, 
                               DO_FILL, 
                               display );


    alt_video_display_register_written_buffer( display );
  }

  return( 0 );
}                            


/*****************************************************************************
 *  Function: AsUpdateProgressWindow
 *
 *  Purpose: Updates the progress bar inside a progress bar window.  The 
 *           progress bar window must have already been drawn with a call to
 *           AsPrintProgressWindow().
 * 
 *  Returns: 0
 ****************************************************************************/
int AsUpdateProgressWindow( progress_window* window, alt_video_display* display, int percent_complete )
{
  
  int progress_bar_start_x, progress_bar_start_y;
  int progress_bar_width, progress_bar_height, progress_bar_active_width;
  
  progress_bar_start_x = window->bar_start_x + PROGRESS_WINDOW_BORDER_WIDTH + 5;
  progress_bar_start_y = window->bar_start_y + PROGRESS_WINDOW_BORDER_WIDTH + 5;
  progress_bar_width = window->bar_size_x - ( 2 * PROGRESS_WINDOW_BORDER_WIDTH ) - 10;
  progress_bar_height = window->bar_size_y - ( 2 * PROGRESS_WINDOW_BORDER_WIDTH ) - 10;
  
  progress_bar_active_width = (( progress_bar_width * percent_complete) / 100 );
    
  vid_draw_round_corner_box( progress_bar_start_x, 
                             progress_bar_start_y, 
                             progress_bar_start_x + progress_bar_active_width,
                             progress_bar_start_y + progress_bar_height,
                             0,
                             PROGRESS_WINDOW_PROG_BAR_COLOR, 
                             DO_FILL, 
                             display );

  alt_video_display_register_written_buffer( display );
  
  return( 0 );

}


/*****************************************************************************
 *  Function: AsConfirmInfoWindow
 *
 *  Purpose: Prints and operates a Confirm/Info window.  A confirm window
 *           displays both an OK and Cancel button, while an Info window
 *           offers just an OK button.  This function can create both types.
 *           Passing a value of 1 for "buttons" creates an info window.
 *           Passing a value of 2 creates a confirm window.
 * 
 *  Returns: The action dictated by whichever button the user pressed.
 ****************************************************************************/

int AsConfirmInfoWindow( alt_video_display* display,
                         alt_touchscreen* touchscreen,
                         char string[],
                         int buttons )
{
  int i;
  int action = AS_ACTION_CANCEL;
  unsigned int command_button_state = 0;
  unsigned int pen_is_down = 0;
  unsigned int window_x_start, window_width;
  unsigned int window_y_start, window_height;

  int touchscreen_x, touchscreen_y;
  int text_width_pixels, text_height_pixels;
  
  // These are our button(s)
  buttons_struct command_buttons;
  
  // The width of the window is determined by the length of the text in it.
  text_width_pixels = vid_string_pixel_length_alpha( QUESTION_WINDOW_TEXT_FONT, string );
  text_height_pixels = ( vid_count_occurrences_in_string( string, '\n' ) * ( QUESTION_WINDOW_TEXT_FONT['A' - 33].bounds_height ));

  window_width = text_width_pixels + 40;
  window_x_start = (( ALT_VIDEO_DISPLAY_COLS - window_width ) / 2 );

  // Calculate where to print the window.
  window_height = QUESTION_WINDOW_Y_HEIGHT + text_height_pixels;
  window_y_start = (( ALT_VIDEO_DISPLAY_ROWS - window_height ) / 2 );
  
  
  // If buttons was passed in as 2, it means we need to print both an OK and a Cancel button.
  if( buttons == 2)
  {
    AsBuildOKCancelButtons( window_x_start + (( window_width - 70 ) / 2 ),
                            window_y_start + window_height - ( COMMAND_BUTTON_HEIGHT + 20 ), 
                            &command_buttons );
  }
  // if buttons was passed in as 1, we only need an OK button.
  else if( buttons == 1 )
  {
    AsBuildOKButton( window_x_start + (( window_width - 70 ) / 2 ),
                     window_y_start + window_height - ( COMMAND_BUTTON_HEIGHT + 20 ), 
                     &command_buttons );
  }
  else // buttons == NO_BUTTONS
  {
    command_buttons.num_buttons = 0;
  }
  
  // Initialize the buttons so they are all "up"
  for( i = 0; i < command_buttons.num_buttons; i++ )
  {
    AsInitButtonState( &command_buttons.button[i] );    
  }
  
  // Print the window
  AsPrintConfirmWindow( window_x_start, 
                         window_width, 
                         window_y_start, 
                         window_height, 
                         display, 
                         &command_buttons, 
                         string );
                         
  // Now read from the touch panel
  if( buttons > 0 )
  {
    while(1) 
    {   
      // Read the touchpanel
      alt_touchscreen_get_pen ( touchscreen, &pen_is_down, &touchscreen_x, &touchscreen_y );

      // Redraw the command buttons as pressed if the pen is touching on them.
      command_button_state = AsUpdateCommandButtons( display, touchscreen_x, touchscreen_y, pen_is_down, &command_buttons );
    
      // Action is only needed if there was a pen-up on one of the command buttons.
      if( command_button_state == BUTTON_PEN_UP )
      {
        // If there is an OK button, check if the pen-up occured on it.
        if( buttons != NO_BUTTONS )
        {
          if( command_buttons.button[QUESTION_WINDOW_OK_BUTTON_INDEX].pen_up_event_occured )
          {
            action = AS_ACTION_OK;
            break;
          }
        }
        // If there is a Cancel button, check if the pen-up occured on it.
        if( buttons == OK_CANCEL )
        {
          if( command_buttons.button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].pen_up_event_occured )
          {
            action = AS_ACTION_CANCEL;
            break;
          }
        }
      }
    }
  }
  return( action );
}


/*****************************************************************************
 *  Function: AsPrintConfirmWindow
 *
 *  Purpose: Prints a Confirm/Info window to the display.  Called by
 *           AsConfirmInfoWindow()   
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintConfirmWindow( unsigned int window_x_start, 
                           unsigned int window_width, 
                           unsigned int window_y_start, 
                           unsigned int window_height, 
                           alt_video_display* display, 
                           buttons_struct* command_buttons, 
                           char string[] )
{
  int i, j;
  int text_y_start;
  char temp_string[128];
  char* str_ptr;
  int line_length, line_length_pixels, text_x_start;
  
  // We print everying to both buffers 
  for( i = 0; i < display->num_frame_buffers; i++ )
  {

    // Print the window border
    vid_draw_round_corner_box( window_x_start - QUESTION_WINDOW_BORDER_WIDTH, 
                               window_y_start - QUESTION_WINDOW_BORDER_WIDTH, 
                               window_x_start + window_width + QUESTION_WINDOW_BORDER_WIDTH,
                               window_y_start + window_height + QUESTION_WINDOW_BORDER_WIDTH,
                               WINDOW_CORNER_RADIUS + QUESTION_WINDOW_BORDER_WIDTH,
                               QUESTION_WINDOW_BORDER_COLOR, 
                               DO_FILL, 
                               display );

    // Print the window interior
    vid_draw_round_corner_box( window_x_start, 
                               window_y_start, 
                               window_x_start + window_width,
                               window_y_start + window_height,
                               WINDOW_CORNER_RADIUS,
                               QUESTION_WINDOW_BODY_COLOR, 
                               DO_FILL, 
                               display );

    // Print the text in the center of the window if there are buttons
    // If there are no buttons, print the text slightly higher to make the 
    // window look more balanced.
    if( command_buttons->num_buttons > 0 )
    {
//      text_y_start = window_y_start + (( window_height - ( COMMAND_BUTTON_HEIGHT + 50 ) ) / 2 );
      text_y_start = window_y_start + 40;
    }
    else
    {
      text_y_start = window_y_start + (( window_height -  20 ) / 2 );
    }
    
    str_ptr = string;
    // We support multiple text lines
    do
    {
      line_length = strcspn( str_ptr, "\n\0" );
      strncpy( temp_string, str_ptr, line_length );
      temp_string[line_length] = '\0';
      line_length_pixels = vid_string_pixel_length_alpha( QUESTION_WINDOW_TEXT_FONT, temp_string );
      text_x_start = window_x_start + (( window_width - line_length_pixels ) / 2 );
    
      // Print the text in the window.
      vid_print_string_alpha( text_x_start, 
                              text_y_start,
                              QUESTION_WINDOW_TEXT_COLOR, 
                              QUESTION_WINDOW_BODY_COLOR, 
                              QUESTION_WINDOW_TEXT_FONT, 
                              display, 
                              temp_string );
                              
      text_y_start += QUESTION_WINDOW_TEXT_FONT['A'-33].bounds_height;
      str_ptr += line_length;
      if( str_ptr[0] == '\0' )
        break;
      else // Must be '\n'
        str_ptr += 1;
        
    } while( 1 );
    
    // Print the OK and Cancel buttons if they exist
    for( j = 0; j < command_buttons->num_buttons; j++ )
    {
      AsPrintCommandButton( display, &command_buttons->button[j] );
    }

    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }
  return ( 0 );
}


/*****************************************************************************
 *  Function: AsBuildMainMenuTitle
 *
 *  Purpose: Builds up the dimensions, locations, colors, and fonts of the
 *           main menu title. 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildMainMenuTitle( menu_title_struct* title )
{

  int string_len_pixels;

  title->num_title_lines = 2;

  // Title Text
  string_len_pixels = vid_string_pixel_length_alpha( MENU_TITLE_FONT, MAIN_MENU_TITLE_TEXT1 );
  title->line[0].loc_x = TOP_BORDER_X_START + (( TOP_BORDER_WIDTH - string_len_pixels ) / 2 );
  title->line[0].loc_y = MAIN_MENU_TITLE_Y_START_1;
  title->line[0].fg_color = COLOR_MAIN_MENU_TITLE_TEXT_32;
  title->line[0].bg_color = COLOR_MENU_TITLE_BAR_32;
  title->line[0].font = MENU_TITLE_FONT;
  strcpy( title->line[0].text, MAIN_MENU_TITLE_TEXT1 );
  
  string_len_pixels = vid_string_pixel_length_alpha( MENU_TITLE_FONT, MAIN_MENU_TITLE_TEXT2 );
  title->line[1].loc_x = TOP_BORDER_X_START + (( TOP_BORDER_WIDTH - string_len_pixels ) / 2 );
  title->line[1].loc_y = MAIN_MENU_TITLE_Y_START_2;
  title->line[1].fg_color = COLOR_MAIN_MENU_TITLE_TEXT_32;
  title->line[1].bg_color = COLOR_MENU_TITLE_BAR_32;
  title->line[1].font = MENU_TITLE_FONT;
  strcpy( title->line[1].text, MAIN_MENU_TITLE_TEXT2 );
  
  return( 0 );

}

/*****************************************************************************
 *  Function: AsBuildAppInfoTitle
 *
 *  Purpose: Builds up the dimensions, locations, colors, and fonts of the
 *           Application Info window title. 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildAppInfoTitle( menu_title_struct* title, char app_name[] )
{

  int string_len_pixels;

  title->num_title_lines = 1;

  // Title Text
  string_len_pixels = vid_string_pixel_length_alpha( MENU_TITLE_FONT, app_name );
  title->line[0].loc_x = TOP_BORDER_X_START + (( TOP_BORDER_WIDTH - string_len_pixels ) / 2 );
  title->line[0].loc_y = MAIN_MENU_TITLE_Y_START_1;
  title->line[0].fg_color = COLOR_MAIN_MENU_TITLE_TEXT_32;
  title->line[0].bg_color = COLOR_MENU_TITLE_BAR_32;
  title->line[0].font = MENU_TITLE_FONT;
  strcpy( title->line[0].text, app_name );

  return( 0 );

}

/*****************************************************************************
 *  Function: AsBuildWebInfoTitle
 *
 *  Purpose: Builds up the dimensions, locations, colors, and fonts of the
 *           Application Info window title. 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildWebInfoTitle( menu_title_struct* title )
{

  int string_len_pixels;

  title->num_title_lines = 1;

  // Title Text
  string_len_pixels = vid_string_pixel_length_alpha( MENU_TITLE_FONT, WEB_SCREEN_TITLE_TEXT1 );
  title->line[0].loc_x = TOP_BORDER_X_START + (( TOP_BORDER_WIDTH - string_len_pixels ) / 2 );
  title->line[0].loc_y = WEB_SCREEN_TITLE_Y_START_1;
  title->line[0].fg_color = COLOR_MAIN_MENU_TITLE_TEXT_32;
  title->line[0].bg_color = COLOR_MENU_TITLE_BAR_32;
  title->line[0].font = MENU_TITLE_FONT;
  strcpy( title->line[0].text, WEB_SCREEN_TITLE_TEXT1 );

  return( 0 );

}


/*****************************************************************************
 *  Function: AsBuildSelectionButtons
 *
 *  Purpose: This function pre-draws all of the selection buttons so they
 *           can be displayed quickly.  The names of the applications for 
 *           which we want to create buttons are passed in as a structure
 *           named app_list.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildSelectionButtons( buttons_struct* selection_buttons, 
                             app_list_struct* app_list,
                             alt_video_display* display,
                             progress_bar* progress_bar )
{
  int i;
  int percent_complete;

  
  // We're going to use the video library functions to render this button, and
  // since those functions expect an alt_video_display type to which to write,
  // we create a small temporary one here and fill it out just enough to draw a
  // button to it.
  alt_video_display* temp_buffer;

  temp_buffer = (alt_video_display*) malloc(sizeof (alt_video_display));
  temp_buffer->width = MENU_ITEM_X_WIDTH + ( 2 * MENU_ITEM_BORDER_WIDTH );
  temp_buffer->height = ( MENU_ITEM_Y_HEIGHT - 10 ) + ( 2 * MENU_ITEM_BORDER_WIDTH );
  temp_buffer->color_depth = 32;
  temp_buffer->num_frame_buffers = 1;
  temp_buffer->bytes_per_frame = (( temp_buffer->width * temp_buffer->height ) * 4 );
  temp_buffer->bytes_per_pixel = ( 4 );
  temp_buffer->buffer_being_written = 0;
  temp_buffer->buffer_ptrs[0] = (alt_video_frame*) malloc( sizeof( alt_video_frame ));
  temp_buffer->buffer_ptrs[0]->buffer = (void*) malloc( temp_buffer->bytes_per_frame );
 
  for( i = 0; i < app_list->num_apps; i++ )
  {
    AsBuildSelectionButton( &app_list->apps[i], &selection_buttons->button[i] , i, temp_buffer );

    percent_complete = (( i + 2 ) * 100 ) / ( app_list->num_apps + 1 );
    AsUpdateProgressBar( progress_bar, display, percent_complete );
  }
  
  selection_buttons->num_buttons = app_list->num_apps;

  // Give back the memory we have taken
  free( temp_buffer->buffer_ptrs[0]->buffer );
  free( temp_buffer->buffer_ptrs[0] );
  free( temp_buffer );
  
  return 0;
}


/*****************************************************************************
 *  Function: AsBuildSelectionButton
 *
 *  Purpose: Pre-draws a selection button to a buffer, so the button can 
 *           quickly be copied to the display without having to redraw it.
 *           The text drawing routines are rather slow, so we save a lot
 *           of time by pre-drawing all the selection buttons, which all
 *           contain text.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildSelectionButton( app_info* app, app_selector_button* button, int app_index, alt_video_display* temp_buffer )
{
  // Set the location of the button on the display.
  button->loc_x = MENU_ITEM_X_START;
  button->loc_y = 0;  // This will get set when we display, and updated when we scroll.
  button->size_x = MENU_ITEM_X_WIDTH;
  button->size_y = MENU_ITEM_Y_HEIGHT - 10;
  

  // Render the button in it's "not pressed" state
  AsRenderSelectionButton( temp_buffer, button, app, app_index, 0 );
  button->button_graphic_not_pressed = malloc( temp_buffer->bytes_per_frame );
  memcpy( button->button_graphic_not_pressed, temp_buffer->buffer_ptrs[0]->buffer, temp_buffer->bytes_per_frame );
    
  // Render the button in it's "pressed" state
  AsRenderSelectionButton( temp_buffer, button, app, app_index, 1 );
  button->button_graphic_pressed = malloc( temp_buffer->bytes_per_frame );
  memcpy( button->button_graphic_pressed, temp_buffer->buffer_ptrs[0]->buffer, temp_buffer->bytes_per_frame );

  return( 0 );
}


/*****************************************************************************
 *  Function: AsBuildMainMenuCommandButtons
 *
 *  Purpose: Builds up the locations, dimensions, and colors of the main
 *           menu command buttons.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildMainMenuCommandButtons( buttons_struct* command_buttons )
{
  
  command_buttons->num_buttons = MAIN_MENU_NUM_COMMAND_BUTTONS;
  
  // Button 0
  strcpy( command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].title, MAIN_MENU_LOAD_BUTTON_TEXT );
  command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].loc_x = MAIN_MENU_LOAD_BUTTON_X_START;
  command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].loc_y = MAIN_MENU_LOAD_BUTTON_Y_START;
  command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].title ) + 40;
  command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].corner_radius = MENU_ITEM_CORNER_RADIUS;
    
  // Button 1
  strcpy( command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].title, MAIN_MENU_INFO_BUTTON_TEXT );
  command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].loc_x = command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].loc_x + 
                                       command_buttons->button[MAIN_MENU_LOAD_BUTTON_INDEX].size_x + 
                                       COMMAND_BUTTON_SPACING;
  command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].loc_y = MAIN_MENU_INFO_BUTTON_Y_START;
  command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].title ) + 40;
  command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[MAIN_MENU_INFO_BUTTON_INDEX].corner_radius = MENU_ITEM_CORNER_RADIUS;
  
  // Button 2
  strcpy( command_buttons->button[MAIN_MENU_WEB_BUTTON_INDEX].title, MAIN_MENU_WEB_BUTTON_TEXT );
  command_buttons->button[MAIN_MENU_WEB_BUTTON_INDEX].loc_x = MAIN_MENU_WEB_BUTTON_X_START;
  command_buttons->button[MAIN_MENU_WEB_BUTTON_INDEX].loc_y = MAIN_MENU_WEB_BUTTON_Y_START;
  command_buttons->button[MAIN_MENU_WEB_BUTTON_INDEX].size_x = MAIN_MENU_WEB_BUTTON_X_SIZE;
  command_buttons->button[MAIN_MENU_WEB_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[MAIN_MENU_WEB_BUTTON_INDEX].corner_radius = MENU_ITEM_CORNER_RADIUS;
    
  return( 0 );  
}


/*****************************************************************************
 *  Function: AsBuildInfoScreenCommandButtons
 *
 *  Purpose: Builds up the locations, dimensions, and colors of the info
 *           screen command buttons.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildInfoScreenCommandButtons( buttons_struct* command_buttons )
{
  
  command_buttons->num_buttons = INFO_SCREEN_NUM_COMMAND_BUTTONS;
  
  // Button 0
  strcpy( command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].title, INFO_SCREEN_OK_BUTTON_TEXT );
  command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].loc_x = INFO_SCREEN_OK_BUTTON_X_START;
  command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].loc_y = INFO_SCREEN_OK_BUTTON_Y_START;
  command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].title ) + 40;
  command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[INFO_SCREEN_OK_BUTTON_INDEX].corner_radius = MENU_ITEM_CORNER_RADIUS;
  
  return( 0 );  
}

/*****************************************************************************
 *  Function: AsBuildWebInfoScreenCommandButtons
 *
 *  Purpose: Builds up the locations, dimensions, and colors of the webserver 
 *           info screen command buttons.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildWebInfoScreenCommandButtons( buttons_struct* command_buttons )
{
  
  command_buttons->num_buttons = WEB_SCREEN_NUM_COMMAND_BUTTONS;
  
  // Button 0
  strcpy( command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].title, WEB_SCREEN_OK_BUTTON_TEXT );
  command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].loc_x = WEB_SCREEN_OK_BUTTON_X_START;
  command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].loc_y = WEB_SCREEN_OK_BUTTON_Y_START;
  command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].title ) + 40;
  command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[WEB_SCREEN_OK_BUTTON_INDEX].corner_radius = MENU_ITEM_CORNER_RADIUS;
  
  return( 0 );  
}


/*****************************************************************************
 *  Function: AsBuildOKButton
 *
 *  Purpose: Builds up the location, dimension, colors, and font of an "OK"
 *           button.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildOKButton( unsigned int x_start, 
                     unsigned int y_start,
                     buttons_struct* command_buttons )
{
  
  command_buttons->num_buttons = 1;
  
  // OK Button
  strcpy( command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].title, "OK" );
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].loc_x =  x_start;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].loc_y =  y_start;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].title ) + 40;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].corner_radius = COMMAND_BUTTON_CORNER_RADIUS;
   
  return( 0 );  
}


/*****************************************************************************
 *  Function: AsBuildOKButton
 *
 *  Purpose: Builds up the location, dimension, colors, and font of an "OK"
 *           button.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildOKCancelButtons( unsigned int x_start, 
                            unsigned int y_start,
                            buttons_struct* command_buttons )
{
  command_buttons->num_buttons = 2;
  
  // OK Button
  strcpy( command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].title, "OK" );
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].loc_x =  x_start;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].loc_y =  y_start;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].title ) + 40;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].corner_radius = COMMAND_BUTTON_CORNER_RADIUS;
    
  // Cancel Button
  strcpy( command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].title, "Cancel" );
  command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].loc_x = command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].loc_x + 
                                       command_buttons->button[QUESTION_WINDOW_OK_BUTTON_INDEX].size_x + 
                                       COMMAND_BUTTON_SPACING;
  command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].loc_y =  y_start;
  command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].size_x = 
    vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].title ) + 40;
  command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].size_y = COMMAND_BUTTON_HEIGHT;
  command_buttons->button[QUESTION_WINDOW_CANCEL_BUTTON_INDEX].corner_radius = COMMAND_BUTTON_CORNER_RADIUS;
  
  return( 0 );  
}


/*****************************************************************************
 *  Function: AsBuildScrollButtons
 *
 *  Purpose: Builds up the location, dimension, colors, and font of two 
 *           up/down scroll buttons.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsBuildScrollButtons( buttons_struct* scroll_buttons )
{
  extern struct gimp_image_struct gimp_image_scroll_up_unpressed;
  extern struct gimp_image_struct gimp_image_scroll_up_pressed;
  extern struct gimp_image_struct gimp_image_scroll_down_unpressed;
  extern struct gimp_image_struct gimp_image_scroll_down_pressed;
  
  bitmap_struct* image;
  int bytes;
  
  image = malloc(sizeof(bitmap_struct));
  
  scroll_buttons->num_buttons = 2;
  
  // Scroll down button
  // unpressed graphic
  load_gimp_bmp( &gimp_image_scroll_down_unpressed, image, 32);
  bytes = ( image->biHeight * image->biWidth * 4 );
  scroll_buttons->button[SCROLL_DOWN_INDEX].button_graphic_not_pressed = malloc( bytes );
  memcpy( scroll_buttons->button[SCROLL_DOWN_INDEX].button_graphic_not_pressed, image->data, bytes );
  free_gimp_bmp_data( image );
  
  // pressed graphic
  load_gimp_bmp( &gimp_image_scroll_down_pressed, image, 32);
  bytes = ( image->biHeight * image->biWidth * 4 );
  scroll_buttons->button[SCROLL_DOWN_INDEX].button_graphic_pressed = malloc( bytes );
  memcpy( scroll_buttons->button[SCROLL_DOWN_INDEX].button_graphic_pressed, image->data, bytes );
  free_gimp_bmp_data( image );

  scroll_buttons->button[SCROLL_DOWN_INDEX].loc_x =  SCROLL_DOWN_BUTTON_X_START;
  scroll_buttons->button[SCROLL_DOWN_INDEX].loc_y =  SCROLL_DOWN_BUTTON_Y_START + MENU_ITEM_BORDER_WIDTH;
  scroll_buttons->button[SCROLL_DOWN_INDEX].size_x = image->biWidth;
  scroll_buttons->button[SCROLL_DOWN_INDEX].size_y = image->biWidth;
  

  // Scroll up button   
  // unpressed graphic
  load_gimp_bmp( &gimp_image_scroll_up_unpressed, image, 32);
  bytes = ( image->biHeight * image->biWidth * 4 );
  scroll_buttons->button[SCROLL_UP_INDEX].button_graphic_not_pressed = malloc( bytes );
  memcpy( scroll_buttons->button[SCROLL_UP_INDEX].button_graphic_not_pressed, image->data, bytes );
  free_gimp_bmp_data( image );

  // pressed graphic
  load_gimp_bmp( &gimp_image_scroll_up_pressed, image, 32);
  bytes = ( image->biHeight * image->biWidth * 4 );
  scroll_buttons->button[SCROLL_UP_INDEX].button_graphic_pressed = malloc( bytes );
  memcpy( scroll_buttons->button[SCROLL_UP_INDEX].button_graphic_pressed, image->data, bytes );
  free_gimp_bmp_data( image );

  scroll_buttons->button[SCROLL_UP_INDEX].loc_x =  SCROLL_UP_BUTTON_X_START;
  scroll_buttons->button[SCROLL_UP_INDEX].loc_y =  SCROLL_UP_BUTTON_Y_START + MENU_ITEM_BORDER_WIDTH;
  scroll_buttons->button[SCROLL_UP_INDEX].size_x = image->biWidth;
  scroll_buttons->button[SCROLL_UP_INDEX].size_y = image->biHeight;
  
  free( image );
  return( 0 );
}


/*****************************************************************************
 *  Function: AsPrintTitle
 *
 *  Purpose: Prints the title to a screen.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintTitle( alt_video_display* display, menu_title_struct* title )
{

  int i;
  
  for( i = 0; i < title->num_title_lines; i ++ )
  {
    vid_print_string_alpha( title->line[i].loc_x, 
                            title->line[i].loc_y,
                            title->line[i].fg_color, 
                            CLEAR_BACKGROUND,
                            title->line[i].font, 
                            display, 
                            title->line[i].text );          
  }               
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsClearSelectionArea
 *
 *  Purpose: Clears the selection/info (inside) area of a screen.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsClearSelectionArea( alt_video_display* display )
{
  
  vid_draw_box( TOP_BORDER_X_START, 
                LEFT_BORDER_Y_START,
                SCROLL_BUTTON_X_START - 1, 
                BOTTOM_BORDER_Y_START - 1,
                COLOR_MENU_BACKGROUND, DO_FILL, display );

                
  return( 0 );
}                
  

/*****************************************************************************
 *  Function: AsPrintMainMenu
 *
 *  Purpose: This function prints all the elements of the main menu.
 *           All elements must have already been built.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintMainMenu( alt_video_display* display,
                 menu_title_struct* title, 
                 buttons_struct* selection_buttons,
                 buttons_struct* command_buttons,
                 buttons_struct* scroll_buttons )
{
  int i;
                       
  // We print evertying to both buffers so we dont have to redraw it every time
  // we need to make a little change to the screen.
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    // Print the menu borders
    AsPrintMenuBorders( display );
    
    // Print the menu title text
    AsPrintTitle( display, title );
    
    // Print the command buttons
    AsPrintCommandButtons( display, command_buttons );
    
    // Print the selection buttons
    AsClearSelectionArea( display );
    AsPrintSelectionButtons( display, selection_buttons );
    
    // Print the scroll buttons
    AsPrintScrollButtons( display, scroll_buttons );
    
    // Print the scroll indicator
    AsPrintScrollIndicator( display, 
                            selection_buttons->scroll_position, 
                            selection_buttons->num_buttons - MENU_ITEMS_ON_SCREEN_AT_ONCE );
    
    // Register the finished frame.
    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }
  
  return( 0 );
}

/*****************************************************************************
 *  Function: AsInitTextWindow
 *
 *  Purpose: Initializes various information regarding the properties of a
 *           text window to make scrolling the text easier.
 * 
 *  Returns: 0 for success, -1 for failure
 ****************************************************************************/
int AsInitTextWindow( text_window_struct* text_window, struct abc_font_struct* font, unsigned char** rendered_letters )
{
  int ret_code;

  text_window->font = font;
  text_window->rendered_letters = rendered_letters;
  text_window->text_length = strlen( text_window->text );
  text_window->scroll_position = 0;
  text_window->start_x = TOP_BORDER_X_START + 30;
  text_window->start_y = LEFT_BORDER_Y_START + 30;
  text_window->end_x = SCROLL_BUTTON_X_START - 5;
  text_window->end_y = BOTTOM_BORDER_Y_START - 26;
  text_window->lines_displayable_at_once = ( text_window->end_y - text_window->start_y ) / 
                                           ( text_window->font['A'].bounds_height );
  text_window->line_index = malloc( AS_MAX_INFO_LINES );
    
  // Count the lines which will be needed to display the text.
  AsCountInfoLines( text_window );
    
  ret_code = AS_SUCCESS;
  
  return( ret_code );
}

/*****************************************************************************
 *  Function: AsPrerenderFont
 *
 *  Purpose: Prerenders a font so that it can be displayed more quickly.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrerenderFont( unsigned char* rendered_letters[],
                     struct abc_font_struct font[],
                     int fg_color,
                     int bg_color )
{
  
  int i;

  // We're going to use the video library functions to render this, and
  // since those functions expect an alt_video_display type to which to write,
  // we create a small temporary one here and fill it out just enough to draw 
  // to it.
  alt_video_display* temp_buffer;

  temp_buffer = (alt_video_display*) malloc(sizeof (alt_video_display));
  temp_buffer->color_depth = 32;
  temp_buffer->num_frame_buffers = 1;  
  temp_buffer->bytes_per_pixel = ( 4 );
  temp_buffer->buffer_being_written = 0;
  temp_buffer->buffer_ptrs[0] = (alt_video_frame*) malloc( sizeof( alt_video_frame ));

  for( i = 0; i < 94; i++ )
  {
    temp_buffer->width = font[i].bounds_width ;
    temp_buffer->height = font[i].bounds_height;
    temp_buffer->bytes_per_frame = (( temp_buffer->width * temp_buffer->height ) * 4 );
    temp_buffer->buffer_ptrs[0]->buffer = (void*) malloc( temp_buffer->bytes_per_frame );
    vid_print_char_alpha ( 0, 0, fg_color, i + 33, bg_color, font, temp_buffer );
    rendered_letters[i] = temp_buffer->buffer_ptrs[0]->buffer;
  }
  
  free( temp_buffer->buffer_ptrs[0] );
  free( temp_buffer );

  return( 0 );
}


/*****************************************************************************
 *  Function: AsFreeRenderedFont
 *
 *  Purpose: Frees the memory allocated for a pre-rendered font.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsFreeRenderedFont( unsigned char* rendered_letters[] )
{
  
  int i;

  for( i = 0; i < 94; i++ )
  {
    free( rendered_letters[i] );
  }
  return( 0 );
}

#include <alt_iniche_dev.h>
/*****************************************************************************
 *  Function: AsConstructWebInfoText
 *
 *  Purpose: Put together the string that will be shown in the text window
 *           for the web info screen.
 * 
 *  Returns: 0
 ****************************************************************************/
char* AsConstructWebInfoText( void )
{
  char* text = NULL;
  
  text = malloc( 2048 );
  if( text != NULL )
  {
    sprintf( text, 
             "Welcome to the Web Server Application\n\nThe Nios II Processor system will now serve content from the SD Card.\n\n1).\tConnect an Ethernet cable from your Kit to a network.\n2).\tOn your host system, open a web browser and type\n\tin the IP Address below.\n\n\tIP Address:\t%d.%d.%d.%d\n\tNetmask:   \t%d.%d.%d.%d\n\tGateway:   \t%d.%d.%d.%d\n\nTCP Stats:\n\t\tSent Bytes:\t\t%d\n\t\tReceived Bytes:\t%d\n\nPing Stats:\n\t\tEchos:\t\t\t%d\n\t\tReplies:\t\t%d\n\nClick on the instructions link in the left hand column of the web page.  Follow the instructions to remotely configure your kit.\n\nFor more information, please refer to the User's Guide.\n",
             ip4_addr1( nets[0]->n_ipaddr ), ip4_addr2( nets[0]->n_ipaddr ), ip4_addr3( nets[0]->n_ipaddr ), ip4_addr4( nets[0]->n_ipaddr ),
             ip4_addr1( nets[0]->snmask ), ip4_addr2( nets[0]->snmask ), ip4_addr3( nets[0]->snmask ), ip4_addr4( nets[0]->snmask ),
             ip4_addr1( nets[0]->n_defgw ), ip4_addr2( nets[0]->n_defgw ), ip4_addr3( nets[0]->n_defgw ), ip4_addr4( nets[0]->n_defgw ),
             tcpstat.tcps_sndbyte, tcpstat.tcps_rcvbyte,
             icmp_mib.icmpInEchos, icmp_mib.icmpOutEchoReps); 
  }
  
  return( text );
}
  
  

/*****************************************************************************
 *  Function: AsShowWebServerInfo
 *
 *  Purpose: Displays a text screen with information about the web server.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsShowWebServerInfo( alt_video_display* display, alt_touchscreen* touchscreen )
{
  char* text = NULL;

  text = AsConstructWebInfoText();
  if( text != NULL )  
  {
    AsTextWindow( display, touchscreen, WEB_SCREEN_TITLE_TEXT1, text, tahomabold_20 );
    free( text );
  }

  return( 0 );
}


/*****************************************************************************
 *  Function: AsShowAppInfo
 *
 *  Purpose: Displays the text contained in an application's "info.txt" file,
 *           on the SD Card and allows the user to scroll through the text 
 *           (if it goes past the end of the screen) using the touchscreen.  
 *           The function exits when the user presses the OK button.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsShowAppInfo( char app_name[], 
                   alt_video_display* display,
                   alt_touchscreen* touchscreen )
{
  char* text = NULL;

  // First check that the info.txt file exists
  if( AsInfoTxtFileExists( app_name ) == AS_SUCCESS )
  {
    // Malloc memory for text_window, and return the text contained in info.txt
    text = AsGetInfoText( app_name );
    if( text != NULL )
    {
      AsTextWindow( display, touchscreen, app_name, text, tahomabold_20 );
      free( text );
    }
  }  
  
  return( 0 );
}
      	
/*****************************************************************************
 *  Function: AsTextWindow
 *
 *  Purpose: Displays a text window with the text specified in text[] and 
 *           allows the user to scroll through the text (if it goes past the 
 *           end of the screen) using the touchscreen.  The function exits 
 *           when the user presses the OK button.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsTextWindow( alt_video_display* display,
                  alt_touchscreen* touchscreen,
                  char* title_text,
                  char* text,
                  struct abc_font_struct font[] )
{      
  int i;
  unsigned int command_button_state = 0;
  unsigned int scroll_button_state = 0;
  int pen_is_down, touchscreen_x, touchscreen_y;
  int ticks_at_last_pen_touch;
  extern struct gimp_image_struct gimp_image_CIII_logo;

  InMainMenu = 0;

  // The primary elements of the screen
  menu_title_struct title;
  buttons_struct command_buttons;
  buttons_struct scroll_buttons;
  text_window_struct text_window;      
  
  unsigned char* rendered_letters[94];

  // Build and render all the menu elements  
  AsBuildAppInfoTitle( &title, title_text );
  AsBuildInfoScreenCommandButtons( &command_buttons );
  AsBuildScrollButtons( &scroll_buttons );

  // Initialize the button states
  for( i = 0; i < scroll_buttons.num_buttons; i++ )
    AsInitButtonState( &scroll_buttons.button[i] );    
  for( i = 0; i < command_buttons.num_buttons; i++ )
    AsInitButtonState( &command_buttons.button[i] );    

  // This initializes the timout for the screensaver
  ticks_at_last_pen_touch = OSTimeGet();
  
  AsPrerenderFont( rendered_letters, font, WHITE_24, BLACK_24 );
  
  // Initialize the text window
  text_window.text = text;
  AsInitTextWindow( &text_window, font, rendered_letters );
  
  // Print the Application info screen
  AsPrintTextWindow( display, &title, &text_window, &command_buttons, &scroll_buttons );
      
  // Take commands from the touch screen
  while(1) 
  {   
    // Allow other tasks some time to run.
    OSTimeDlyHMSM( 0, 0, 0, 10 );
        
    // Gather the latest touchscreen coordinates
    alt_touchscreen_get_pen ( touchscreen, &pen_is_down, &touchscreen_x, &touchscreen_y );
    
    if( pen_is_down )
      ticks_at_last_pen_touch = OSTimeGet();

    // Turn on screen saver if we've been inactive long enough.
    if((( OSTimeGet() - ticks_at_last_pen_touch ) / alt_ticks_per_second() ) > AS_SCR_SVR_TIMEOUT )
    {
      ticks_at_last_pen_touch = AsScreenSaver( display, touchscreen, &gimp_image_CIII_logo );
      AsPrintTextWindow( display, &title, &text_window, &command_buttons, &scroll_buttons );
    }
  
    // Determine how the touchscreen coordinates affect the command buttons, 
    // and redraw them if neccessary.  Note that the command buttons can be
    // affected even if the touchscreen coordinates are somewhere other than on 
    // the command button, or if the pen is up.  This is because you have to
    // redraw the buttons whenever the pen slides off or lifts up from them.
    command_button_state = AsUpdateCommandButtons( display, touchscreen_x, touchscreen_y, 
                                                   pen_is_down, &command_buttons );

    // Determine how the touchscreen coordinates affect the scroll buttons.
    scroll_button_state = AsUpdateScrollButtons( display, touchscreen_x, touchscreen_y, 
                                                 pen_is_down, &scroll_buttons );
     
    // If the scroll buttons were pressed in a way that affects the scroll position 
    // of the text, redraw the text with the new scroll position.
    if( scroll_button_state == BUTTON_SELECTED )
    {
      // "Scroll up" means the scroll button pointing up was pressed.  The
      // selection items will actually appear to move down, but we're going
      // "up" the list, so we call it scrolling up.
      if(( scroll_buttons.button[SCROLL_UP_INDEX].is_selected ) && 
         ( text_window.scroll_position > 0 ))
      {
        text_window.scroll_position--;

        // Update the text with the new scroll position
        AsUpdateTextWindowScroll( display, &text_window );
      }
      // "Scroll down" means the scroll button pointing down was pressed.
      else if(( scroll_buttons.button[SCROLL_DOWN_INDEX].is_selected ) &&
              ( text_window.scroll_position < ( text_window.num_lines - text_window.lines_displayable_at_once )))
      {
        text_window.scroll_position++;
        // Update the text with the new scroll position
        AsUpdateTextWindowScroll( display, &text_window );
      }
      
      alt_video_display_register_written_buffer( display );
      while ( alt_video_display_buffer_is_available( display ) != 0 );
                           
    }
     
    // If there was a pen-up event on the OK button, it means we exit now.
    if( command_button_state == BUTTON_PEN_UP )
    {
      if( command_buttons.button[INFO_SCREEN_OK_BUTTON_INDEX].pen_up_event_occured )
      {
        break;
      }
    }
  }
  
  free( text_window.line_index );
  AsFreeRenderedFont( rendered_letters );

  InMainMenu = 1;

  return( 0 );
}

/*****************************************************************************
 *  Function: AsPrintTextWindow
 *
 *  Purpose: Displays a text window.  This is called only once
 *           for the initial display of the window.  Scrolling of the 
 *           text within the window is done by the function AsUpdateTextWindowScroll()
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintTextWindow( alt_video_display* display,
                    menu_title_struct* title, 
                    text_window_struct* text_window,
                    buttons_struct* command_buttons,
                    buttons_struct* scroll_buttons )                    
{
  int i;
  int lines_to_print;
                       
  // We print evertying to both buffers so we dont have to redraw it every time
  // we need to make a little change to the screen.
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    // Print the menu borders
    AsPrintMenuBorders( display );
    
    // Print the menu title text
    AsPrintTitle( display, title );
    
    // Print the command buttons
    AsPrintCommandButtons( display, command_buttons );
    
    // Print the info text 
    AsClearSelectionArea( display );

    // Print the scroll buttons
    AsPrintScrollButtons( display, scroll_buttons );
    
    // Print the scroll indicator
    AsPrintScrollIndicator( display, 
                            text_window->scroll_position, 
                            text_window->num_lines - text_window->lines_displayable_at_once );

    // Determine how many lines we're printing.
    if( text_window->num_lines < text_window->lines_displayable_at_once )
      lines_to_print = text_window->num_lines;
    else
      lines_to_print = text_window->lines_displayable_at_once;
      
    // Print the info text to the screen
    AsPrintTextWindowText( display, text_window, 0, 0, lines_to_print );

    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsUpdateTextWindowScroll
 *
 *  Purpose: Updates only the info text and scroll indicator of the
 *           application info screen.  The rest of the application info
 *           screen is unchanged.  This is called when scrolling the info
 *           text up and down. 
 * 
 *  Returns: 0
 ****************************************************************************/
int AsUpdateTextWindowScroll( alt_video_display* display,
                      text_window_struct* text_window )                    
{
  int i;
  static int last_scroll_position = 0;
  
  // We print evertying to both buffers so we dont have to redraw it every time
  // we need to make a little change to the screen.
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    // Update the scroll indicator
    AsPrintScrollIndicator( display, 
                            text_window->scroll_position, 
                            text_window->num_lines - text_window->lines_displayable_at_once );

    // Update the scroll orientation of the info text 
    // We keep track of the last scroll position to make scrolling faster.
    AsScrollTextWindowText( display, text_window, last_scroll_position );
    
    //Register the finished frame.
    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }

  // Store off the current scroll position in a static, so next time this function
  // is called we know the last scroll positon.
  last_scroll_position = text_window->scroll_position;
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsCopyVidBlock
 *
 *  Purpose: Copies a block of video data from one location in the frame
 *           buffer to another location in the frame buffer.  
 * 
 *           The source and destination blocks must not overlap however, as 
 *           it could corrupt the video data.  No measures are taken to 
 *           guarantee that the blocks do not overlap.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsCopyVidBlock( int dest_x, int dest_y,
                    int src_x, int src_y,
                    int size_x, int size_y,
                    alt_video_display* display )
{
  int i;
  char* dest;
  char* src;
  
  // Calculate the destination and source addresses.
  dest = (( display->buffer_ptrs[display->buffer_being_written]->buffer ) + 
          ( dest_x * display->bytes_per_pixel ) +
          ( dest_y * ( display->width * display->bytes_per_pixel )));
          
  src = (( display->buffer_ptrs[display->buffer_being_written]->buffer ) + 
          ( src_x * display->bytes_per_pixel ) +
          ( src_y * ( display->width * display->bytes_per_pixel )));
 
  // Use memcpy() to copy each video line of the block.
  for( i = 0; i < size_y; i++ )
  {
    memcpy( dest, src, size_x * display->bytes_per_pixel );
    dest += ( display->width * display->bytes_per_pixel );
    src +=  ( display->width * display->bytes_per_pixel );
  }
    
  return( 0 );
}                         


/*****************************************************************************
 *  Function: AsVidCopyImageToBuffer
 *
 *  Purpose: Copies an image to a video buffer of a different width.  This
 *           function differs from AsCopyVidBlock() in that the source and
 *           destination do not have to be contained in the same buffer,
 *           and can be differend widths.  This function is useful for copying
 *           images stored in RAM to the active frame buffer to be displayed.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsVidCopyImageToBuffer( char* dest, char* src, 
                            int dest_width, 
                            int src_width, int src_height )
{
  int y;
  
  //Copy one line at a time from top to bottom
  for ( y = 0; y < src_height; y++ )
  {
    memcpy( dest, src, ( src_width * 4 ));
    src += ( src_width * 4 );
    dest += ( dest_width * 4 );
  }
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsPrintSelectionButtons
 *
 *  Purpose: Prints a list of scrollable selection buttons to the display.
 *           The buttons are pre-rendered in memory, but have no Y location
 *           associated with them until this function is called.  This
 *           function calculates the Y position of each button to be displayed
 *           based on the scroll position, then prints it.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintSelectionButtons( alt_video_display* display, buttons_struct* selection_buttons )
{

  int i, y_index;
  int last_button_to_draw;
  
  // Calculate which is the last button to display, based on the scroll position and
  // the number of buttons we have.    
  if(( selection_buttons->num_buttons ) > ( selection_buttons->scroll_position + MENU_ITEMS_ON_SCREEN_AT_ONCE ))
    last_button_to_draw = selection_buttons->scroll_position + ( MENU_ITEMS_ON_SCREEN_AT_ONCE - 1 );
  else
    last_button_to_draw = selection_buttons->num_buttons - 1;

  for( i = selection_buttons->scroll_position, y_index = 0; i <= last_button_to_draw; i++, y_index++ )
  {
    // Update the y position of the button, then print it to the screen.
    selection_buttons->button[i].loc_y = ( MENU_ITEM_Y_START + ( y_index * MENU_ITEM_Y_HEIGHT ));
    AsPrintSelectionButton( display, &selection_buttons->button[i] );
  }
  
  return( 0 );  
}


/*****************************************************************************
 *  Function: AsPrintSelectionButton
 *
 *  Purpose: Copies an individual, pre-rendered selection button to the 
 *           display
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintSelectionButton( alt_video_display* display, app_selector_button* button )
{
  char* src;
  char* dest;

  // If the button was pressed, draw it as "down".
  if( button->is_selected )
  	src = button->button_graphic_pressed;
  else
  	src = button->button_graphic_not_pressed;
  	  
  dest = (char*)(( display->buffer_ptrs[display->buffer_being_written]->buffer ) +
                 (( button->loc_y ) * ( display->width * 4 )) +
                 ( button->loc_x * 4 ));
  	
  AsVidCopyImageToBuffer( dest, 
                          src, 
                          display->width, 
                          button->size_x + ( 2 * MENU_ITEM_BORDER_WIDTH ), 
                          button->size_y + ( 2 * MENU_ITEM_BORDER_WIDTH ) );
		
  return( 0 );
}


/*****************************************************************************
 *  Function: AsPrintCommandButtons
 *
 *  Purpose: Prints the command buttons described by the structure 
 *           "command_buttons" to the display.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintCommandButtons( alt_video_display* display, buttons_struct* command_buttons )
{
  int i;
  
  for( i = 0; i < command_buttons->num_buttons; i++ )
  {
    AsPrintCommandButton( display, &command_buttons->button[i] );
  }
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsUpdateCommandButtonText
 *
 *  Purpose: Updates the text within the specified button, and redraws the
 *           entire button.
 * 
 *  Returns: void
 ****************************************************************************/
void AsUpdateCommandButtonText( alt_video_display* display, app_selector_button* button, char newtext[] )
{
  int i;

  strcpy( button->title, newtext );

  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    AsPrintCommandButton( display, button );
    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }
}

/*****************************************************************************
 *  Function: AsPrintCommandButton
 *
 *  Purpose: Prints a single command button described by the structure 
 *           "button" to the display.  The command buttons are not 
 *           pre-rendered like the selection buttons.  The command buttons
 *           are rendered on-the-fly since they are usually fairly small.
 *           In the future, it may be useful to pre-render the command 
 *           buttons as well.
 * 
 *  Returns: void
 ****************************************************************************/
void AsPrintCommandButton( alt_video_display* display, app_selector_button* button )
{
  
  unsigned int corner_radius, button_color, border_color, text_color;
  int text_length, text_start_x;
  
  // The color of the button is dependent on whether it is selected.
  if( button->is_selected == 0 )
  {
    corner_radius = COMMAND_BUTTON_CORNER_RADIUS;
    button_color = COMMAND_BUTTON_COLOR_NOT_SELECTED;
    border_color = COMMAND_BUTTON_BORDER_COLOR_NOT_SELECTED;
    text_color = COMMAND_BUTTON_TEXT_COLOR_NOT_SELECTED;
  }
  else
  {
    corner_radius = COMMAND_BUTTON_CORNER_RADIUS;
    button_color = COMMAND_BUTTON_COLOR_SELECTED;
    border_color = COMMAND_BUTTON_BORDER_COLOR_SELECTED;
    text_color = COMMAND_BUTTON_TEXT_COLOR_SELECTED;
  }
      
  // Print the button border
  vid_draw_round_corner_box( button->loc_x, 
                             button->loc_y, 
                             button->loc_x + button->size_x,
                             button->loc_y + button->size_y,
                             button->corner_radius,
                             border_color, 
                             DO_FILL, 
                             display );

  // Print the button interior
  vid_draw_round_corner_box( button->loc_x + 3, 
                             button->loc_y + 3, 
                             button->loc_x + button->size_x - 3,
                             button->loc_y + button->size_y - 3,
                             button->corner_radius - 3,
                             button_color, 
                             DO_FILL, 
                             display );
                             
  // Print the button text in the center of the button.
  text_length = vid_string_pixel_length_alpha( COMMAND_BUTTON_FONT, button->title );
  text_start_x = ( button->loc_x + (( button->size_x - text_length ) / 2 ));
  vid_print_string_alpha( text_start_x, button->loc_y + 12,
                          text_color, 
                          button_color, 
                          COMMAND_BUTTON_FONT, display, button->title );
  
}


/*****************************************************************************
 *  Function: AsPrintScrollButtons
 *
 *  Purpose: Prints the scroll buttons in the window which allow the user to 
 *           scroll through content.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintScrollButtons( alt_video_display* display, buttons_struct* scroll_buttons )
{
  // Scroll up button
  AsPrintScrollButton( display, &scroll_buttons->button[SCROLL_UP_INDEX], SCROLL_UP );
  // Scroll down button
  AsPrintScrollButton( display, &scroll_buttons->button[SCROLL_DOWN_INDEX], SCROLL_DOWN );

  return( 0 );
}


/*****************************************************************************
 *  Function: AsPrintScrollButton
 *
 *  Purpose: Prints an individual scroll button to the display.  The scroll
 *           buttons are not pre-rendered like the selection buttons.  The 
 *           command buttons are rendered on-the-fly since they are usually 
 *           fairly small. In the future, it may be useful to pre-render the 
 *           command buttons as well.
 * 
 *  Returns: 0
 ****************************************************************************/
void AsPrintScrollButton( alt_video_display* display, 
                         app_selector_button* button, 
                         int direction )
{
  char* image_dest;
  char* image_src;
  int x, y;
  
  if( button->is_selected == 0 )
  {
  	image_src = button->button_graphic_not_pressed;
  }
  else
  {
    image_src = button->button_graphic_pressed;    
  }
  
  x = button->loc_x - 1;
  y = button->loc_y - 1;
  
  image_dest = (char*)(( display->buffer_ptrs[display->buffer_being_written]->buffer ) + 
                      (( y * display->width ) * 4 ) +
                      (  x * 4 ));

  // Copy the image to the current display buffer
  AsVidCopyImageToBuffer( image_dest,
                          image_src, 
                          display->width,
                          button->size_x,
                          button->size_y );        
}


/*****************************************************************************
 *  Function: AsUpdateAppSelectionList
 *
 *  Purpose: Update the list of selection buttons based on the touchscreen
 *           coordinates.  If the touchscreen coordinates are in the area of
 *           the selection buttons, update all the selection buttons.
 * 
 *  Returns: void
 ****************************************************************************/
void AsUpdateAppSelectionList( alt_video_display* display, 
                               int touchscreen_x,
                               int touchscreen_y,
                               int pen_is_down,
                               buttons_struct* selection_buttons )
{
  int i;
  int last_button_to_draw;
      
  // If the touchscreen coordinates are in the selection button area, update 
  // all the selection buttons.
  if( AsCoordsAreInArea( touchscreen_x, touchscreen_y, pen_is_down,
                         MENU_AREA_X_START, MENU_AREA_Y_START,
                         MENU_AREA_X_END, MENU_AREA_Y_END ))
  {
  	// Calculate the last button to draw, based on the scroll position and the number
    // of buttons.
    if(( selection_buttons->num_buttons - 1 ) > ( selection_buttons->scroll_position + 5 ))
  	  last_button_to_draw = selection_buttons->scroll_position + 4;
  	else
  	  last_button_to_draw = selection_buttons->num_buttons - 1;

    // Go through each of the selection buttons
    for( i = 0; i < selection_buttons->num_buttons; i++ )
    {
      // If it is currently "on-screen", update and optionally repaint it if
      // its state has changed.
      if(( i >= selection_buttons->scroll_position ) &&
         ( i <= last_button_to_draw ))
      {
        AsUpdateAppSelectionButton( display, 
                                  touchscreen_x,
                                  touchscreen_y,
                                  pen_is_down,
                                  &selection_buttons->button[i],
                                  i - selection_buttons->scroll_position );    
      }
      // Otherwise, if the button is "off-screen", set its state to
      // not selected.
      else
      {  
        selection_buttons->button[i].is_selected = 0;
        selection_buttons->button[i].pen_down_event_occured = 0;
        selection_buttons->button[i].pen_up_event_occured = 0;
      }
      
    }
  }
}  


/*****************************************************************************
 *  Function: AsUpdateAppSelectionButton
 *
 *  Purpose: Updates the state of an individual selection item button, based 
 *           on the touchscreen coordinates being passed in.  This function 
 *           also detects and flags pen-up and pen-down events on the button.
 * 
 *     Note: All "AsUpdateXXXXButton()" functions could be combined to one
 *           function which passes in a function pointer to the function
 *           which actually prints the button.  For future versions.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsUpdateAppSelectionButton( alt_video_display* display, 
                             int touchscreen_x,
                             int touchscreen_y,
                             int pen_is_down,
                             app_selector_button* button,
                             int button_display_index )
{
  int i;

  // Only need to update the loc_y, because it's the only location parameter which
  // changes when we scroll.
  button->loc_y = MENU_ITEM_Y_START + ( button_display_index * MENU_ITEM_Y_HEIGHT );
  
  // If the pen is on the button, update the button's state.
  if( AsCoordsAreOnButton( touchscreen_x, touchscreen_y, pen_is_down, button ))
  {
    // Pen is now on button, but wasn't last time = pen-down event
    if( button->is_selected == 0 )
    {
      button->is_selected = 1;
      button->pen_down_event_occured = 1;
      button->pen_up_event_occured = 0;
      for( i = 0; i < display->num_frame_buffers; i++ )
      {
        AsPrintSelectionButton( display, button );
        alt_video_display_register_written_buffer( display );
        while ( alt_video_display_buffer_is_available( display ) != 0 );
      }
    }
    else
    {
      button->pen_down_event_occured = 0;
      button->pen_up_event_occured = 0;
    }
  }
  else
  {
    if( button->is_selected == 1 )
    {
      // Pen is not on button now, but was last time = pen-up event
      button->is_selected = 0;
      button->pen_down_event_occured = 0;
      // A pen up only occured if... well... the pen is up.
      // If we dont do this test, we could trigger a false pen up 
      // on the button if the user just slid the pen off.
      if( pen_is_down == 0 )
        button->pen_up_event_occured = 1;
      else
        button->pen_up_event_occured = 0;
      
      for( i = 0; i < display->num_frame_buffers; i++ )
      {
        AsPrintSelectionButton( display, button );
        alt_video_display_register_written_buffer( display );
        while ( alt_video_display_buffer_is_available( display ) != 0 );
      }
    }
    else
    {
      button->pen_down_event_occured = 0;
      button->pen_up_event_occured = 0;
    }
  }

  return( 0 );
} 


/*****************************************************************************
 *  Function: AsUpdateCommandButtons
 *
 *  Purpose: Updates the state of the command buttons, and detects pen-up
 *           events on them.
 * 
 *  Returns: 0 - No pen-up event occured on the command buttons
 *           1 - A pen-up event occured on a command button.
 ****************************************************************************/
int AsUpdateCommandButtons( alt_video_display* display, 
                            int touchscreen_x,
                            int touchscreen_y,
                            int pen_is_down,
                            buttons_struct* command_buttons )
{
  int ret_code = BUTTON_NOT_SELECTED;
  int i;

  // Update the command buttons
  for( i = 0; i < command_buttons->num_buttons; i++ )
  {
    AsUpdateCommandButton( display, touchscreen_x, touchscreen_y, pen_is_down, &command_buttons->button[i] );
  }

  for( i = 0; i < command_buttons->num_buttons; i++ )
  {
    // Check for pen-up events
    if( command_buttons->button[i].pen_up_event_occured )
    {
      ret_code = BUTTON_PEN_UP;
      break;
    }
    // Check for selected buttons
    if( command_buttons->button[i].is_selected )
    {
      ret_code = BUTTON_SELECTED;
      break;
    }
  }
  
  return( ret_code );
}    


/*****************************************************************************
 *  Function: AsUpdateCommandButton
 *
 *  Purpose: Updates the state of an individual command button, based 
 *           on the touchscreen coordinates being passed in.  This function 
 *           also detects and flags pen-up and pen-down events on the button.
  * 
 *     Note: All "AsUpdateXXXXButton()" functions could be combined to one
 *           function which passes in a function pointer to the function
 *           which actually prints the button.  For future versions.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsUpdateCommandButton( alt_video_display* display,
                           int touchscreen_x,
                           int touchscreen_y,
                           int pen_is_down,
                           app_selector_button* button )
{
  int i;

  if( AsCoordsAreOnButton( touchscreen_x, touchscreen_y, pen_is_down, button ))
  {
    // Pen is now on button now, but wasn't last time = pen-down event
    if( button->is_selected == 0 )
    {
      button->is_selected = 1;
      button->pen_down_event_occured = 1;
      button->pen_up_event_occured = 0;
      for( i = 0; i < display->num_frame_buffers; i++ )
      {
        AsPrintCommandButton( display, button );
        alt_video_display_register_written_buffer( display );
        while ( alt_video_display_buffer_is_available( display ) != 0 );
      }
    }
    else
    {
      button->pen_down_event_occured = 0;
      button->pen_up_event_occured = 0;
    }
  }
  else
  {
    // Pen is not on button now, but was last time = pen-up event
    if( button->is_selected == 1 )
    {
      button->is_selected = 0;
      button->pen_down_event_occured = 0;
      // A pen up only occured if... well... the pen is up.
      // If we dont do this test, we could trigger a false pen up 
      // on the button if the user just slid the pen off.
      if( pen_is_down == 0 )
        button->pen_up_event_occured = 1;
      else
        button->pen_up_event_occured = 0;
      
      for( i = 0; i < display->num_frame_buffers; i++ )
      {
        AsPrintCommandButton( display, button );
        alt_video_display_register_written_buffer( display );
        while ( alt_video_display_buffer_is_available( display ) != 0 );
      }
    }
    else
    {
      button->pen_down_event_occured = 0;
      button->pen_up_event_occured = 0;
    }
  }
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsUpdateScrollButtons
 *
 *  Purpose: Updates the graphic state (up/down) of the scroll buttons.
 * 
 *  Returns: 0 (BUTTON_NOT_SELECTED) - No scroll buttons are selected
 *           2 (BUTTON_SELECTED)     - A scroll button is selected
 ****************************************************************************/
int AsUpdateScrollButtons( alt_video_display* display, 
                           int touchscreen_x,
                           int touchscreen_y,
                           int pen_is_down,
                           buttons_struct* scroll_buttons )
{
  int ret_code = 0;
  
  // Update the scroll buttons
  AsUpdateScrollButton( display, touchscreen_x, touchscreen_y, pen_is_down, 
                        &scroll_buttons->button[SCROLL_UP_INDEX], SCROLL_UP );
  AsUpdateScrollButton( display, touchscreen_x, touchscreen_y, pen_is_down, 
                        &scroll_buttons->button[SCROLL_DOWN_INDEX], SCROLL_DOWN );
  
  // Check if either scroll button is being pressed.
  if( scroll_buttons->button[SCROLL_UP_INDEX].is_selected ||
      scroll_buttons->button[SCROLL_DOWN_INDEX].is_selected )
  {
    ret_code = BUTTON_SELECTED;
  }
  else
  {
    ret_code = BUTTON_NOT_SELECTED;
  }
  
  return( ret_code );
} 


/*****************************************************************************
 *  Function: AsUpdateScrollButton
 *
 *  Purpose: Updates an individual scroll button.  Also detects pen-up and
 *           pen-down events and flags them.
 * 
 *     Note: All "AsUpdateXXXXButton()" functions could be combined to one
 *           function which passes in a function pointer to the function
 *           which actually prints the button.  For future versions.
 * 
 *  Returns: 0 
 ****************************************************************************/
int AsUpdateScrollButton( alt_video_display* display, 
                          int touchscreen_x,
                          int touchscreen_y,
                          int pen_is_down,
                          app_selector_button* button,
                          int direction )
{
  int i;

  // If the pen is on the button, update it.
  if( AsCoordsAreOnButton( touchscreen_x,  touchscreen_y, pen_is_down, button ))
  {
    // Pen is now on button now, but wasn't last time = pen-up event
    if( button->is_selected == 0 )
    {
      button->is_selected = 1;
      button->pen_down_event_occured = 1;
      button->pen_up_event_occured = 0;
      for( i = 0; i < display->num_frame_buffers; i++ )
      {
        AsPrintScrollButton( display, button, direction );
        alt_video_display_register_written_buffer( display );
        while ( alt_video_display_buffer_is_available( display ) != 0 );
      }
    }
    else
    {
      button->pen_down_event_occured = 0;
      button->pen_up_event_occured = 0;
    }
  }
  else
  {
    // Pen is not on button now, but was last time = pen-up event
    if( button->is_selected == 1 )
    {
      button->is_selected = 0;
      button->pen_down_event_occured = 0;
      // A pen up only occured if... well... the pen is up.
      // If we dont do this test, we could trigger a false pen up 
      // on the button if the user just slid the pen off.
      if( pen_is_down == 0 )
        button->pen_up_event_occured = 1;
      else
        button->pen_up_event_occured = 0;
      for( i = 0; i < display->num_frame_buffers; i++ )
      {
        AsPrintScrollButton( display, button, direction );
        alt_video_display_register_written_buffer( display );
        while ( alt_video_display_buffer_is_available( display ) != 0 );
      }
    }
    else
    {
      button->pen_down_event_occured = 0;
      button->pen_up_event_occured = 0;
    }
  }
  
  return( 0 );
}
   

/*****************************************************************************
 *  Function: AsPrintScrollIndicator
 *
 *  Purpose: Prints the scroll indicator which appears between the two
 *           scroll buttons and shows where you are in the list of scrollable
 *           content.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintScrollIndicator( alt_video_display* display, int scroll_position, int num_positions )
{
  
  int indicator_top, indicator_bottom, indicator_pix_per_scroll_position, indicator_y_start;
 
  // This is the top of the indicator area
  indicator_top = SCROLL_INDICATOR_AREA_Y_START + MENU_ITEM_BORDER_WIDTH  + ( SCROLL_INDICATOR_HEIGHT / 2 ) + 3;
  
  // This is the bottom of the indicator area
  indicator_bottom = ( SCROLL_INDICATOR_AREA_Y_END ) - ( SCROLL_INDICATOR_HEIGHT / 2 );
  
  // The number of pixels to move the scroll indicator for each incremental change in the
  // scroll position value passed into this function.
  indicator_pix_per_scroll_position = (( indicator_bottom - indicator_top ) /  num_positions );
  
  // Where to draw the indicator itself.
  indicator_y_start = (( indicator_top + ( indicator_pix_per_scroll_position * scroll_position )) - ( SCROLL_INDICATOR_HEIGHT / 2 ));

  // Clear the scroll indicator area
  vid_paint_block( SCROLL_INDICATOR_AREA_X_START,
                   indicator_top - ( SCROLL_INDICATOR_HEIGHT / 2 ), 
                   SCROLL_INDICATOR_AREA_X_END,
                   indicator_bottom + ( SCROLL_INDICATOR_HEIGHT / 2 ) + 1,
                   BLACK_24, 
                   display );

  // Draw the indicator bar
  vid_draw_round_corner_box( SCROLL_INDICATOR_AREA_X_START, 
                             indicator_y_start, 
                             SCROLL_INDICATOR_AREA_X_END,
                             indicator_y_start + SCROLL_INDICATOR_HEIGHT,
                             SCROLL_INDICATOR_CORNER_RADIUS,
                             SCROLL_INDICATOR_COLOR, 
                             DO_FILL, 
                             display );
                   
  return( 0 );
}


/*****************************************************************************
 *  Function: AsUpdateScrollIndicator
 *
 *  Purpose: Updates the scroll indicator by calling AsPrintScrollIndicator()
 *           for each frame buffer.
 * 
 *  Returns: 0 
 ****************************************************************************/
int AsUpdateScrollIndicator( alt_video_display* display, 
                             int scroll_position, 
                             int num_selections )
{
  int i;
  
  for( i = 0; i < display->num_frame_buffers; i++ )
  {
    AsPrintScrollIndicator( display, scroll_position, num_selections - MENU_ITEMS_ON_SCREEN_AT_ONCE );
    alt_video_display_register_written_buffer( display );
    while ( alt_video_display_buffer_is_available( display ) != 0 );
  }
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsCoordsAreInArea
 *
 *  Purpose: Determines if a set of coordinates are contained within a given
 *           area.  Useful for quickly seeing if touchscreen coordinates are
 *           within an active touchscreen area.
 * 
 *  Returns: (1) - Coordinates are contained in the area
 *           (0) - Coordinates are not contained in the area
 ****************************************************************************/
int AsCoordsAreInArea( int coord_x, int coord_y, int coords_are_active,
                       int start_x, int start_y, int end_x, int end_y)
{
  int ret_code;
  
  // If coordinates are contained within area and the pen is down
  if(( coord_x >= start_x ) && ( coord_x <= end_x ) &&
     ( coord_y >= start_y ) && ( coord_y <= end_y ) &&
     ( coords_are_active ))
  {
    ret_code = 1;
  }
  else
  {
    ret_code = 0;
  }
  
  return( ret_code );
}


/*****************************************************************************
 *  Function: AsCoordsAreOnButton
 *
 *  Purpose: Determines if a set of coordinates are contained within a given
 *           button.  
 * 
 *  Returns: (1) - Coordinates are contained in the area
 *           (0) - Coordinates are not contained in the area
 ****************************************************************************/
int AsCoordsAreOnButton( int touchscreen_x, int touchscreen_y, int pen_is_down, app_selector_button* button )
{
  int x_start, x_end, y_start, y_end;
  int ret_code;
  
  x_start = button->loc_x;
  y_start = button->loc_y;
  x_end = button->loc_x + button->size_x;
  y_end = button->loc_y + button->size_y;
  
  if( AsCoordsAreInArea( touchscreen_x, touchscreen_y, pen_is_down,
                         x_start, y_start, x_end, y_end ))
  {
    ret_code = 1;
  }
  else
  {
    ret_code = 0;
  }
  return( ret_code );
}


/*****************************************************************************
 *  Function: AsGradBox
 *
 *  Purpose: Draws a filled box with a color gradient.  start_color blends to   
 *           end_color.  amplitude specifies (in percent) how far the gradient
 *           should transition to the end_color.  direction specifies which
 *           direction the gradient should follow.
 * 
 *  Returns: 0
 * 
 ****************************************************************************/
int AsGradBox( int horiz_start, 
               int vert_start, 
               int horiz_end, 
               int vert_end, 
               unsigned int start_color,
               unsigned int end_color, 
               int direction,
               int amplitude,
               alt_video_display* display)
{
  unsigned int temp_color;
  int x, y;
  unsigned int start_red, start_green, start_blue;
  unsigned int end_red, end_green, end_blue;
  int delta_red, delta_green, delta_blue;
  int incr_red, incr_green, incr_blue;
  int xincr_red, xincr_green, xincr_blue;
  int yincr_red, yincr_green, yincr_blue;
  unsigned int current_red, current_green, current_blue;
  int distance, effective_distance;
  int y_index, x_index;  
  
  start_red =   ( start_color >> 16 ) & 0xFF;
  start_green = ( start_color >> 8  ) & 0xFF;
  start_blue =  ( start_color >> 0  ) & 0xFF;

  end_red =     ( end_color   >> 16 ) & 0xFF;
  end_green =   ( end_color   >> 8  ) & 0xFF;
  end_blue =    ( end_color   >> 0  ) & 0xFF;
  
  delta_red =   ( end_red -   start_red );
  delta_green = ( end_green - start_green );
  delta_blue =  ( end_blue -  start_blue );
  
  if(( direction == AS_GRAD_DOWN ) || 
     ( direction == AS_GRAD_UP ) || 
     ( direction == AS_GRAD_LEFT ) || 
     ( direction == AS_GRAD_RIGHT ))
  {
    if(( direction == AS_GRAD_DOWN ) || ( direction == AS_GRAD_UP ))
      distance = ( vert_end - vert_start );
    else
      distance = ( horiz_end - horiz_start );
    
    effective_distance = ( distance * 100 ) / amplitude;

    incr_red = (( delta_red << 16 ) / ( effective_distance ));
    incr_green = (( delta_green << 16 ) / ( effective_distance ));
    incr_blue = (( delta_blue << 16 ) / ( effective_distance ));

    current_red = start_red << 16;
    current_green = start_green << 16;
    current_blue = start_blue << 16;

    if( direction == AS_GRAD_DOWN )
    {
      for( y = vert_start; y < vert_end; y++ )
      {
        temp_color = ((( current_red   >> 16 ) << 16 & 0xFF0000 ) |
                      (( current_green >> 16 ) << 8  & 0x00FF00 ) |
                      (( current_blue  >> 16 ) << 0  & 0x0000FF ));

        vid_draw_line( horiz_start, y, horiz_end, y, 1, temp_color, display );

        current_red +=   incr_red;
        current_green += incr_green;
        current_blue  += incr_blue;
      }
    }
  
    if( direction == AS_GRAD_UP )
    {
      for( y = vert_end - 1; y >= vert_start; y-- )
      {
        temp_color = ((( current_red   >> 16 ) << 16 & 0xFF0000 ) |
                      (( current_green >> 16 ) << 8  & 0x00FF00 ) |
                      (( current_blue  >> 16 ) << 0  & 0x0000FF ));

        vid_draw_line( horiz_start, y, horiz_end, y, 1, temp_color, display );

        current_red +=   incr_red;
        current_green += incr_green;
        current_blue  += incr_blue;
      }
    }

    if( direction == AS_GRAD_RIGHT )
    {
      for( x = horiz_start; x < horiz_end; x++ )
      {
        temp_color = ((( current_red   >> 16 ) << 16 & 0xFF0000 ) |
                      (( current_green >> 16 ) << 8  & 0x00FF00 ) |
                      (( current_blue  >> 16 ) << 0  & 0x0000FF ));

        vid_draw_line( x, vert_start, x, vert_end, 1, temp_color, display );

        current_red +=   incr_red;
        current_green += incr_green;
        current_blue  += incr_blue;
      }
    }

    if( direction == AS_GRAD_LEFT )
    {
      for( x = horiz_end - 1; x >= horiz_start; x-- )
      {
        temp_color = ((( current_red   >> 16 ) << 16 & 0xFF0000 ) |
                      (( current_green >> 16 ) << 8  & 0x00FF00 ) |
                      (( current_blue  >> 16 ) << 0  & 0x0000FF ));

        vid_draw_line( x, vert_start, x, vert_end, 1, temp_color, display );

        current_red +=   incr_red;
        current_green += incr_green;
        current_blue  += incr_blue;
      }
    }
  }

  if(( direction == AS_GRAD_DOWN_RIGHT ) ||
     ( direction == AS_GRAD_DOWN_LEFT ) ||
     ( direction == AS_GRAD_UP_RIGHT ) ||
     ( direction == AS_GRAD_UP_LEFT ))
  {
    distance = sqrt((( horiz_end - horiz_start ) * ( horiz_end - horiz_start )) +
                    (( vert_end - vert_start )   * ( vert_end - vert_start )));

    effective_distance = ( distance * 100 ) / amplitude;
    incr_red = (( delta_red << 16 ) / ( effective_distance ));
    incr_green = (( delta_green << 16 ) / ( effective_distance ));
    incr_blue = (( delta_blue << 16 ) / ( effective_distance ));
    
    xincr_red = ( incr_red * ( horiz_end - horiz_start )) / distance;
    xincr_green = ( incr_green * ( horiz_end - horiz_start )) / distance;
    xincr_blue = ( incr_blue * ( horiz_end - horiz_start )) / distance;

    yincr_red = ( incr_red * ( vert_end - vert_start )) / distance;
    yincr_green = ( incr_green * ( vert_end - vert_start )) / distance;
    yincr_blue = ( incr_blue * ( vert_end - vert_start )) / distance;
    
    start_red = start_red << 16;
    start_green = start_green << 16;
    start_blue = start_blue << 16;
    
    if( direction == AS_GRAD_DOWN_RIGHT )
    {
      for( y = vert_start; y < vert_end; y++ )
      {
        y_index = y - vert_start;
        for( x = horiz_start; x < horiz_end; x++ )
        {
          x_index = x - horiz_start;
          temp_color = (((( start_red +   ( x_index * xincr_red ) +   ( y_index * yincr_red ))   >> 16 ) << 16 & 0xFF0000 ) |
                        ((( start_green + ( x_index * xincr_green ) + ( y_index * yincr_green )) >> 16 ) << 8  & 0x00FF00 ) |
                        ((( start_blue +  ( x_index * xincr_blue ) +  ( y_index * yincr_blue ))  >> 16 ) << 0  & 0x0000FF ));

          vid_set_pixel( x, y, temp_color, display);
        }
      }
    }
    
    if( direction == AS_GRAD_DOWN_LEFT )
    {
      for( y = vert_start; y < vert_end; y++ )
      {
        y_index = y - vert_start;
        for( x = horiz_start; x < horiz_end; x++ )
        {
          x_index = ( horiz_end - x ) - 1;
          temp_color = (((( start_red +   ( x_index * xincr_red ) +   ( y_index * yincr_red ))   >> 16 ) << 16 & 0xFF0000 ) |
                        ((( start_green + ( x_index * xincr_green ) + ( y_index * yincr_green )) >> 16 ) << 8  & 0x00FF00 ) |
                        ((( start_blue +  ( x_index * xincr_blue ) +  ( y_index * yincr_blue ))  >> 16 ) << 0  & 0x0000FF ));

          vid_set_pixel( x, y, temp_color, display);
        }
      }
    }

    if( direction == AS_GRAD_UP_RIGHT )
    {
      for( y = vert_start; y < vert_end; y++ )
      {
        y_index = ( vert_end - y ) - 1;
        for( x = horiz_start; x < horiz_end; x++ )
        {
          x_index = x - horiz_start;
          temp_color = (((( start_red +   ( x_index * xincr_red ) +   ( y_index * yincr_red ))   >> 16 ) << 16 & 0xFF0000 ) |
                        ((( start_green + ( x_index * xincr_green ) + ( y_index * yincr_green )) >> 16 ) << 8  & 0x00FF00 ) |
                        ((( start_blue +  ( x_index * xincr_blue ) +  ( y_index * yincr_blue ))  >> 16 ) << 0  & 0x0000FF ));

          vid_set_pixel( x, y, temp_color, display);
        }
      }
    }

    if( direction == AS_GRAD_UP_LEFT )
    {
      for( y = vert_start; y < vert_end; y++ )
      {
        y_index = ( vert_end - y ) - 1;
        for( x = horiz_start; x < horiz_end; x++ )
        {
          x_index = ( horiz_end - x ) - 1;
          temp_color = (((( start_red +   ( x_index * xincr_red ) +   ( y_index * yincr_red ))   >> 16 ) << 16 & 0xFF0000 ) |
                        ((( start_green + ( x_index * xincr_green ) + ( y_index * yincr_green )) >> 16 ) << 8  & 0x00FF00 ) |
                        ((( start_blue +  ( x_index * xincr_blue ) +  ( y_index * yincr_blue ))  >> 16 ) << 0  & 0x0000FF ));

          vid_set_pixel( x, y, temp_color, display);
        }
      }
    }
  }
  return( 0 );
}


/*****************************************************************************
 *  Function: AsPrintMenuBorders
 *
 *  Purpose: Prints the borders around the screen  
 * 
 *  Returns: void
 ****************************************************************************/
void AsPrintMenuBorders( alt_video_display* display )
{

  // Top, left, and bottom bars
  AsGradBox( TOP_BORDER_X_START, TOP_BORDER_Y_START, 
             TOP_BORDER_X_START + TOP_BORDER_WIDTH, 
             TOP_BORDER_Y_START + TOP_BORDER_HEIGHT, 
             COLOR_MENU_TITLE_BAR_32, BLACK_24, 
             AS_GRAD_DOWN, 20, display );

  AsGradBox( LEFT_BORDER_X_START, LEFT_BORDER_Y_START, 
             LEFT_BORDER_X_START + LEFT_BORDER_WIDTH, 
             LEFT_BORDER_Y_START+ LEFT_BORDER_HEIGHT, 
             COLOR_MENU_TITLE_BAR_32, BLACK_24, 
             AS_GRAD_RIGHT, 20, display );

  AsGradBox( BOTTOM_BORDER_X_START, BOTTOM_BORDER_Y_START, 
             BOTTOM_BORDER_X_START + BOTTOM_BORDER_WIDTH, 
             BOTTOM_BORDER_Y_START+ BOTTOM_BORDER_HEIGHT, 
             COLOR_MENU_TITLE_BAR_32, BLACK_24, 
             AS_GRAD_UP, 20, display );



  // Corner blocks
  AsGradBox( TL_CORNER_X_START, TL_CORNER_Y_START, 
             TL_CORNER_X_START + TL_CORNER_WIDTH, 
             TL_CORNER_Y_START + TL_CORNER_HEIGHT, 
             COLOR_MENU_TITLE_BAR_32, BLACK_24, 
             AS_GRAD_UP_LEFT, 20, display );

  AsGradBox( BL_CORNER_X_START, BL_CORNER_Y_START, 
             BL_CORNER_X_START + BL_CORNER_WIDTH, 
             BL_CORNER_Y_START+ BL_CORNER_HEIGHT, 
             COLOR_MENU_TITLE_BAR_32, BLACK_24, 
             AS_GRAD_DOWN_LEFT, 20, display );

  // Clear Center
  vid_draw_box( TOP_BORDER_X_START, 
                LEFT_BORDER_Y_START, 
                TOP_BORDER_X_START + TOP_BORDER_WIDTH, 
                BOTTOM_BORDER_Y_START,
                BLACK_24, DO_FILL, display );
                  

}


/*****************************************************************************
 *  Function: AsRenderSelectionButton
 *
 *  Purpose: Renders a menu section button to a frame buffer. 
 * 
 *  Returns: void
 ****************************************************************************/

void AsRenderSelectionButton( alt_video_display* display, 
                              app_selector_button* button, 
                              app_info* app, 
                              int app_index,
                              int is_selected )
{

  int menu_text_color, menu_bullet_color;
  char string[5];
  
  extern struct gimp_image_struct gimp_image_selected;
  extern struct gimp_image_struct gimp_image_unselected_even;
  extern struct gimp_image_struct gimp_image_unselected_odd;

  bitmap_struct* image;

  image = malloc(sizeof(bitmap_struct));
  
  if( is_selected )
  {
    menu_text_color = COLOR_MENU_ITEM_TEXT_SELECTED_32;
    menu_bullet_color = COLOR_MENU_ITEM_BULLET_SELECTED_32;
    load_gimp_bmp( &gimp_image_selected, image, 32);
    AsVidCopyImageToBuffer( display->buffer_ptrs[display->buffer_being_written]->buffer,
                            image->data, 
                            display->width, 
                            image->biWidth, 
                            image->biHeight );
    free_gimp_bmp_data( image );
  }
  else
  {
    menu_text_color = COLOR_MENU_ITEM_TEXT_NOT_SELECTED_32;
    menu_bullet_color = COLOR_MENU_ITEM_BULLET_NOT_SELECTED_32;
    if( app_index % 2 )
      load_gimp_bmp( &gimp_image_unselected_odd, image, 32);
    else
      load_gimp_bmp( &gimp_image_unselected_even, image, 32);

    AsVidCopyImageToBuffer( display->buffer_ptrs[display->buffer_being_written]->buffer,
                            image->data, 
                            display->width, 
                            image->biWidth, 
                            image->biHeight );    
    free_gimp_bmp_data( image );
  }
  
  free( image );

  // Numeral
  sprintf( string, "%d.", app_index + 1 );
  vid_print_string_alpha( MENU_ITEM_BORDER_WIDTH + 15,
                          MENU_ITEM_BORDER_WIDTH + ((( button->size_y ) / 2 ) - 22 ),
                          menu_text_color, CLEAR_BACKGROUND, MENU_ITEM_FONT, 
                          display, string );

  // Text
  // Trim the string if it is too long.
  while(( vid_string_pixel_length_alpha( MENU_ITEM_FONT, app->app_name )) > ( button->size_x - 80 ))
  {
    app->app_name[strlen( app->app_name ) - 1] = 0x0;
  }
  vid_print_string_alpha( MENU_ITEM_BORDER_WIDTH + 70,
                          MENU_ITEM_BORDER_WIDTH + ((( button->size_y ) / 2 ) - 22 ),
                          menu_text_color, CLEAR_BACKGROUND, MENU_ITEM_FONT, 
                          display, app->app_name );

}   


/*****************************************************************************
 *  Function: AsCountInfoLines
 *
 *  Purpose: This function parses through the application info string and 
 *           determines the number of lines which will be needed to display
 *           it using the font and window width specified in the "text_window"
 *           structure.
 * 
 *           The function also makes a log of the offset within the info
 *           string where each line begins.  This makes it much easier to 
 *           print and scroll the info text in the window.
 * 
 *  Returns: number of lines needed to display text
 ****************************************************************************/
int AsCountInfoLines( text_window_struct* text_window )
{
  int i = 0;
  int x;
  int line = 0;
  int current_y = text_window->start_y;
  int current_x = text_window->start_x;
  char* word;
  int word_length;
  int word_length_pixels;
  int space_left;
  int num_chars;
  char* tempstring;
  
  word = malloc( 100 );
  
  text_window->line_index[line] = i;
  
  for( i = 0; i < text_window->text_length; /*no increment*/  )
  {

    // Handle the most common non-word cases
    if(( text_window->text[i] == '\r' ) &&
       ( text_window->text[i+1] == '\n' ))
    {
      // Since we are keeping track of the beginning of each line,
      // we no longer need the carriage returns.  So we change them
      // to null characters.  This helps the string printing routines
      // , which we call later, find the end of the lines.
      text_window->text[i] = '\0';
      text_window->text[i+1] = '\0';
      current_y += text_window->font['A'].bounds_height;
      current_x = text_window->start_x;
      i+=2;
      line++;
      text_window->line_index[line] = i;
      
    }
    else if( text_window->text[i] == '\n' )
    { 
      // Change this type of carriage return to a null character too
      // (see comment above for why)
      text_window->text[i] = '\0';
      current_y += text_window->font['A'].bounds_height;
      current_x = text_window->start_x;
      i++;
      line++;
      text_window->line_index[line] = i;
    }
    // Tabs are special cases
    else if( text_window->text[i] == '\t' )
    {
      for( x = text_window->start_x; x <= current_x; x += ( AS_TAB_SPACES * text_window->font['-' - 33].bounds_width ));
      current_x = x; 
      i++;
    }
    // Spaces are special cases too.
    else if( text_window->text[i] == ' ' )
    {
      // Here we just add the length of the '-' character
      current_x += text_window->font['-' - 33].bounds_width; 
      i++;
    }
    else
    {
      // This is probably the beginning of a real word, so lets start by 
      // finding the end of the word, marked by \r,\n,\b,\t,\0 or a space,
      // then extract the word to a temporary string.
      word_length = (int)( strpbrk( &(text_window->text[i]), "\r\n\b\t " ) - &text_window->text[i] );
        
      strncpy( word, &(text_window->text[i]), word_length );
      word[word_length] = '\0';
      i += word_length;
    
      // If, by printing this word, we go past the end of our text window,
      // perform a carriage return before proceeding.
      word_length_pixels = vid_string_pixel_length_alpha( text_window->font, word );
      if(( current_x + word_length_pixels ) > text_window->end_x )
      {
        // If the word itself is longer than the available space, we cant just insert
        // a carriage return to fix it.  We have to cut the word.
        if( word_length_pixels > ( text_window->end_x - text_window->start_x ))
        {
          //Find out how long the word can be before it extends past the edge
          space_left = text_window->end_x - current_x;
          tempstring = malloc( word_length );
          for( num_chars = 1; num_chars < word_length; num_chars++ )
          {
            strncpy( tempstring, word, num_chars );
            tempstring[num_chars] = 0;  // null terminate it since strncpy doesnt necessarily do it.
            if( vid_string_pixel_length_alpha( text_window->font, tempstring ) >= space_left )
            {
              i -= ( word_length - ( num_chars ));
              break;
            }
          }
          strcpy( tempstring, word );
          strcpy( word, tempstring + num_chars );
          
          free( tempstring );
          
          // We need to insert a '\0', which means extending the source string (yuck).
          int temp = strlen( &(text_window->text[i]) );
          tempstring = malloc( temp );
          strcpy( tempstring, &(text_window->text[i]));
          text_window->text[i++] = '\0';
          strcpy( &(text_window->text[i]), tempstring );
          free( tempstring );
          
          current_y += text_window->font['A'].bounds_height;
          current_x = text_window->start_x;          
          line++;
          text_window->line_index[line] = i;
        }
        else
        {
          current_y += text_window->font['A'].bounds_height;
          current_x = text_window->start_x;
          line++;
          text_window->line_index[line] = ( i - word_length ) - 1;
        }
      }

      // Add up the pixels from the word.
      current_x += vid_string_pixel_length_alpha( text_window->font, word );
    }
  }
    
  // Increment "line" once more so it accurately represents the number of lines, 
  // not just the index of the current line.
  text_window->num_lines = line + 1;

  // Remove leading spaces from, and add termination to, all lines
  for( i = 0; i < text_window->num_lines; i ++ )
  {
    while( text_window->text[text_window->line_index[i]] == ' ' )
    {
      // Change each leading space to a null-termination
      text_window->text[text_window->line_index[i]] = '\0';
      
      // Remove the leading space (now a null character) by
      // ratcheting up the index value for the line.
      (text_window->line_index[i])++;
    }
  }
  
  // Ensure the end of the last line is terminated.
  text_window->text[text_window->text_length] = '\0';
  
  free( word );
  
  return( line );
}
                   
/*****************************************************************************
 *  Function: AsVidPrintString
 *
 *  Purpose: Prints a string to the video device "display" using a
 *           pre-rendered font "font".
 * 
 *  Returns: number of lines needed to display text
 ****************************************************************************/
int AsVidPrintString(int current_x, int current_y, struct abc_font_struct font[], unsigned char** rendered_letters, alt_video_display * display, char string[])
{
  char* temp_str_ptr;
  char* temp_pixel_ptr;
  char* start_ptr;
  char* dest_ptr;

  temp_str_ptr = string;
  start_ptr = display->buffer_ptrs[display->buffer_being_written]->buffer + (current_x * 4) + (current_y * display->width * 4 );
  dest_ptr = start_ptr;
  while( *temp_str_ptr != 0x0 )
  {
    // Make sure it's a legal character
    if( *temp_str_ptr >= 33 && *temp_str_ptr <= 126 )
    {
      AsVidCopyImageToBuffer( dest_ptr,
                              rendered_letters[*temp_str_ptr-33],
                              display->width,
                              font[*temp_str_ptr-33].bounds_width,
                              font[*temp_str_ptr-33].bounds_height );
      dest_ptr += (font[*temp_str_ptr-33].bounds_width * 4);
    }
    // or a Space
    else if( *temp_str_ptr == ' ' )
    {
      // advance the width of the '-' character.
      dest_ptr += (font['-' - 33].bounds_width * 4);
    }
    else if( *temp_str_ptr == '\t' )
    {
      for( temp_pixel_ptr = start_ptr; temp_pixel_ptr <= dest_ptr; temp_pixel_ptr += ( AS_TAB_SPACES * 4 * font['-' - 33].bounds_width ));
      dest_ptr = temp_pixel_ptr; 
    }
    // Otherwise, print a '.'
    else
    {
      AsVidCopyImageToBuffer( dest_ptr,
                              rendered_letters['.' - 33],
                              display->width,
                              font['.' - 33].bounds_width,
                              font['.' - 33].bounds_height );
      dest_ptr += (font['.' - 33].bounds_width * 4);
    }
    temp_str_ptr++;                              
  }
  return( 0 );
}
   

/*****************************************************************************
 *  Function: AsPrintTextWindowText
 *
 *  Purpose: Print one or more lines of the info text to the application
 *           info screen.  Uses the line index array to print each line.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsPrintTextWindowText( alt_video_display * display, 
                           text_window_struct* text_window,
                           int text_line,       // Which line of the info text to start with
                           int begin_position,  // Where on the screen to start printing
                           int num_lines )      // How many lines to print.
{

  int current_y = text_window->start_y + ( begin_position * text_window->font['A'].bounds_height );
  int current_x = text_window->start_x;
  char* string;
  int line;

  // Set the string pointer to the beginning of the info text.
  string = text_window->text;

  // For each line we're displaying
  for( line = text_line; 
       line < ( text_line + num_lines );
       line++ )
  {
    current_x = text_window->start_x;
    AsVidPrintString ( current_x, current_y, text_window->font, text_window->rendered_letters, display, &(string[text_window->line_index[line]]) ); 
    current_y += text_window->font['A'].bounds_height;
  }
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsScrollTextWindowText
 *
 *  Purpose: Scrolls the info text within the application info screen.
 * 
 *           To make this fast enough, we avoid rendering the text whenever
 *           possible.  When a scroll occurs, we copy any text not being 
 *           scrolled off the screen either up or down the proper scroll 
 *           distance, then only render the new lines appearing on 
 *           the screen due to the scroll action.
 * 
 *  Returns: 0
 ****************************************************************************/
int AsScrollTextWindowText( alt_video_display * display, 
                            text_window_struct* text_window,
                            int last_scroll_position )
{

  // Now print the new lines after clearing the old
  vid_paint_block( text_window->start_x,
                   text_window->start_y,
                   text_window->end_x,
                   text_window->end_y,
                   COLOR_MENU_BACKGROUND,
                   display );

  AsPrintTextWindowText( display, 
                         text_window,
                         text_window->scroll_position,            // Which line of the info text to start with
                         0,                                       // Where on the screen to start printing
                         text_window->lines_displayable_at_once); // How many lines to print.          
  
  return( 0 );
}


/*****************************************************************************
 *  Function: AsInitButtonStates
 *
 *  Purpose: Initializes all buttons to their startup state.
 * 
 *  Returns: void
 ****************************************************************************/
void AsInitButtonStates( buttons_struct* selection_buttons, 
                     buttons_struct* command_buttons,
                     buttons_struct* scroll_buttons )
{
  int i;
  
  for( i = 0; i < selection_buttons->num_buttons; i++ )
  {
    AsInitButtonState( &selection_buttons->button[i] );
  }
  
  for( i = 0; i < command_buttons->num_buttons; i++ )
  {
    AsInitButtonState( &command_buttons->button[i] );    
  }
  
  for( i = 0; i < scroll_buttons->num_buttons; i++ )
  {
    AsInitButtonState( &scroll_buttons->button[i] );    
  }
}


/*****************************************************************************
 *  Function: AsInitButtonState
 *
 *  Purpose: Initializes a single button to its startup state:
 *           Not selected, no pen-up or pen-down events.
 * 
 *  Returns: void
 ****************************************************************************/
void AsInitButtonState( app_selector_button* button )
{
  button->is_selected = 0;
  button->pen_down_event_occured = 0;
  button->pen_up_event_occured = 0;
}


