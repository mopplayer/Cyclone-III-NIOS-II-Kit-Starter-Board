 /*****************************************************************************
 *  File: app_selector_gui.h
 * 
 *  This file contains the constants, structure definitions, and funtion
 *  prototypes for the graphics interface portion of the application selector.
 *
 ****************************************************************************/
#ifndef APP_SELECTOR_GUI_H_
#define APP_SELECTOR_GUI_H_

#include "alt_video_display.h"
#include "fonts.h"
#include "skin1.h"
#include "app_selector.h"
#include "fonts.h" 
#include "simple_graphics.h"
#include "gimp_bmp.h"

#define AS_MAX_INFO_LINES 500
#define AS_TAB_SPACES 4

#define BUTTON_NOT_SELECTED 0
#define BUTTON_PEN_UP 1
#define BUTTON_SELECTED 2

#define NO_BUTTONS 0
#define OK_ONLY 1
#define OK_CANCEL 2

#define AS_SCR_SVR_INCR_VALUE 1
#define AS_SCR_SVR_TIMEOUT (60 * 5)

// Gradient box types
#define AS_GRAD_DOWN       0
#define AS_GRAD_UP         1
#define AS_GRAD_LEFT       2
#define AS_GRAD_RIGHT      3
#define AS_GRAD_DOWN_RIGHT 4
#define AS_GRAD_DOWN_LEFT  5
#define AS_GRAD_UP_RIGHT   6
#define AS_GRAD_UP_LEFT    7

typedef struct {
  unsigned int loc_x;
  unsigned int loc_y;
  unsigned int size_x;
  unsigned int size_y;
  unsigned int corner_radius;
  char title[64];
  char* button_graphic_not_pressed;
  char* button_graphic_pressed;
  unsigned int is_selected;
  unsigned int pen_down_event_occured;
  unsigned int pen_up_event_occured;
} app_selector_button;

typedef struct {
  app_selector_button button[AS_MAX_SDCARD_APPS];
  int num_buttons;
  int scroll_position;
} buttons_struct;

typedef struct{
  char text[MAX_STRING_LENGTH];
  unsigned int loc_x;
  unsigned int loc_y;
  struct abc_font_struct* font;
  unsigned int fg_color;
  unsigned int bg_color;
} text_string_struct;
  
 
typedef struct {
  text_string_struct line[MAX_MENU_TITLE_LINES];
  int num_title_lines;
} menu_title_struct;

typedef struct {
  unsigned int loc_x;
  unsigned int loc_y;
  unsigned int size_x;
  unsigned int size_y;
  unsigned int corner_radius;
  unsigned int color;
} progress_bar;

typedef struct {
  unsigned int loc_x;
  unsigned int loc_y;
  unsigned int size_x;
  unsigned int size_y;
  unsigned int corner_radius;
  char text[64];
  unsigned int text_start_x;
  unsigned int text_start_y;
  unsigned int bar_start_x;
  unsigned int bar_size_x;
  unsigned int bar_start_y;
  unsigned int bar_size_y;
} progress_window;

typedef struct {
  char* text;
  int text_length;
  int *line_index;
  int num_lines;
  int scroll_position;
  int lines_displayable_at_once;
  int start_x;
  int end_x;
  int start_y;
  int end_y;
  struct abc_font_struct* font;
  unsigned char** rendered_letters;
} text_window_struct;


typedef struct {
  int pen_is_down;
  int touchscreen_x; 
  int touchscreen_y;
} as_touchscreen_message;


// Function Prototypes

int AsMainMenu( alt_video_display* display, 
                app_list_struct* app_list,
                alt_touchscreen* touchscreen );

void AsPrintMenuBorders( alt_video_display* display );

int AsBuildSelectionButtons( buttons_struct* selection_buttons, 
                             app_list_struct* app_list,
                             alt_video_display* display,
                             progress_bar* progress_bar );

int AsBuildSelectionButton( app_info* app, 
                            app_selector_button* button, 
                            int app_index, 
                            alt_video_display* temp_buffer );
                        
int AsPrintMainMenu( alt_video_display* display,
                 menu_title_struct* title, 
                 buttons_struct* selection_buttons,
                 buttons_struct* command_buttons,
                 buttons_struct* scroll_buttons );         
                     
int AsBuildMainMenuTitle( menu_title_struct* title );

int AsBuildAppInfoTitle( menu_title_struct* title, char app_name[] );

int AsBuildMainMenuCommandButtons( buttons_struct* command_buttons );

int AsBuildScrollButtons( buttons_struct* scroll_buttons );

int AsPrintCommandButtons( alt_video_display* display, buttons_struct* command_buttons );

int AsPrintSelectionButtons( alt_video_display* display, buttons_struct* selection_buttons );

int AsPrintScrollButtons( alt_video_display* display, buttons_struct* scroll_buttons );

int AsCoordsAreOnButton( int touchscreen_x, int touchscreen_y, int pen_is_down, app_selector_button* button );
                        
void AsPrintCommandButton( alt_video_display* display, 
                           app_selector_button* button );

void AsUpdateCommandButtonText( alt_video_display* display, app_selector_button* button, char newtext[] );                           

int AsPrintSelectionButton( alt_video_display* display, app_selector_button* button );
                             
void AsPrintScrollButton( alt_video_display* display, 
                          app_selector_button* button, 
                          int direction );
                     
void AsInitButtonStates( buttons_struct* selection_buttons, 
                     buttons_struct* command_buttons,
                     buttons_struct* scroll_buttons );

void AsInitButtonState( app_selector_button* button );
                     
void AsButtonUp( app_selector_button* button );

void AsButtonDown( app_selector_button* button );

void AsUpdateAppSelectionList( alt_video_display* display, 
                               int touchscreen_x,
                               int touchscreen_y,
                               int pen_is_down,
                               buttons_struct* selection_buttons );

int AsUpdateCommandButtons( alt_video_display* display, 
                            int touchscreen_x,
                            int touchscreen_y,
                            int pen_is_down,
                            buttons_struct* command_buttons );    

int AsUpdateScrollButtons( alt_video_display* display, 
                           int touchscreen_x,
                           int touchscreen_y,
                           int pen_is_down,
                           buttons_struct* scroll_buttons );

int AsUpdateAppSelectionButton( alt_video_display* display, 
                             int touchscreen_x,
                             int touchscreen_y,
                             int pen_is_down,
                             app_selector_button* button,
                             int button_display_index );

int AsUpdateCommandButton( alt_video_display* display,
                           int touchscreen_x,
                           int touchscreen_y,
                           int pen_is_down,
                           app_selector_button* button );
                           
int AsUpdateScrollButton( alt_video_display* display, 
                          int touchscreen_x,
                          int touchscreen_y,
                          int pen_is_down,
                          app_selector_button* button,
                          int direction );                 

int AsConfirmInfoWindow( alt_video_display* display,
                         alt_touchscreen* touchscreen,
                         char string[],
                         int buttons );
                                               
int AsPrintConfirmWindow( unsigned int window_x_start, 
                          unsigned int window_width, 
                          unsigned int window_y_start, 
                          unsigned int window_height, 
                          alt_video_display* display, 
                          buttons_struct* command_buttons, 
                          char string[] );                      

int AsBuildOKCancelButtons( unsigned int x_start, 
                            unsigned int y_start,
                            buttons_struct* command_buttons );

int AsBuildOKButton( unsigned int x_start, 
                     unsigned int y_start,
                     buttons_struct* command_buttons );    
                     
int AsPrintProgressWindow( progress_window* window, alt_video_display* display );

int AsBuildProgressWindow( char* text, progress_window* window );

int AsUpdateProgressWindow( progress_window* window, alt_video_display* display, int percent_complete );

int AsRedrawSelectionList( buttons_struct* selection_buttons,
                           app_list_struct* app_list,
                           alt_video_display* display );

int AsCoordsAreInArea( int coord_x, int coord_y, int coords_are_active,
                       int start_x, int start_y, int end_x, int end_y);

int AsVidCopyImageToBuffer( char* dest, char* src, 
                            int dest_width, 
                            int src_width, int src_height );
                      
void AsRenderSelectionButton( alt_video_display* display, 
                              app_selector_button* button, 
                              app_info* app, 
                              int app_index,
                              int is_selected );

void AsDisplaySplashScreen( alt_video_display* display,
                            struct gimp_image_struct* CIII_image );

int AsScreenSaver( alt_video_display* display, 
                   alt_touchscreen* touchscreen, 
                   struct gimp_image_struct* image );
                   
int AsPrintScrollIndicator( alt_video_display* display, 
                            int scroll_position, 
                            int num_positions );
                            
int AsUpdateScrollIndicator( alt_video_display* display, 
                             int scroll_position, 
                             int num_selections );
                             
int AsShowAppInfo( char app_name[], 
                   alt_video_display* display,
                   alt_touchscreen* touchscreen );       

int AsShowWebServerInfo( alt_video_display* display, 
                         alt_touchscreen* touchscreen );

int AsTextWindow( alt_video_display* display,
                  alt_touchscreen* touchscreen,
                  char* title_text,
                  char* text,
                  struct abc_font_struct font[] );

int AsPrintTextWindow( alt_video_display* display,
                    menu_title_struct* title, 
                    text_window_struct* text_window,
                    buttons_struct* command_buttons,
                    buttons_struct* scroll_buttons );
                    
int AsPrintTextWindowText( alt_video_display * display, 
                     text_window_struct* text_window,
                     int text_line,
                     int begin_position,
                     int num_lines );

int AsUpdateTextWindowScroll( alt_video_display* display,
                      text_window_struct* text_window );
                    
int AsInitTextWindow( text_window_struct* text_window, 
                      struct abc_font_struct* font, 
                      unsigned char** rendered_letters );

int AsCountInfoLines( text_window_struct* text_window );

int AsCopyBetweenFrames( int start_x, int end_x,
                         int start_y, int end_y,
                         int dest_buffer_index, 
                         int src_buffer_index,
                         alt_video_display* display );
                         
int AsScrollTextWindowText( alt_video_display * display, 
                            text_window_struct* text_window,
                            int last_scroll_position );

alt_u32 LEDAlarmCallback (void* context);             

void LedTask( void* pdata ); 
void GuiTask( void* pdata );
void TouchscreenTask( void* pdata );
void OsTouchscreenGetPenBlocking( int* pen_is_down, int* touchscreen_x, int* touchscreen_y, int timeout );
void OsTouchscreenGetPenNonBlocking( int* pen_is_down, int* touchscreen_x, int* touchscreen_y );
int AsInitTouchscreen( alt_touchscreen* touchscreen );
int AsBuildProgressBar( int x_start, int y_start, int x_size, int y_size, int corner_radius, int color, progress_bar* bar );
int AsUpdateProgressBar( progress_bar* bar, alt_video_display* display, int percent_complete );
int AsPrerenderFont( unsigned char* rendered_letters[],
                     struct abc_font_struct font[],
                     int fg_color,
                     int bg_color );
int AsFreeRenderedFont( unsigned char* rendered_letters[] );                     
int AsVidPrintString( int current_x, 
                      int current_y, 
                      struct abc_font_struct font[], 
                      unsigned char** rendered_letters, 
                      alt_video_display * display, 
                      char string[]);
int AsGradBox( int horiz_start, 
               int vert_start, 
               int horiz_end, 
               int vert_end, 
               unsigned int start_color,
               unsigned int end_color, 
               int direction,
               int amplitude,
               alt_video_display* display);
       

#endif /*APP_SELECTOR_GUI_H_*/
