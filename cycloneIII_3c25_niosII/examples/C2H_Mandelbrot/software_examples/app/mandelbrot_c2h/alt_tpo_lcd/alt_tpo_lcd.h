#ifndef ALT_TPO_LCD_H_
#define ALT_TPO_LCD_H_

#include "alt_types.h"

// todo: remove. I put this into altera_avalon_pio_regs.h for 7.2 release
#define ALTERA_AVALON_PIO_DIRECTION_INPUT  0
#define ALTERA_AVALON_PIO_DIRECTION_OUTPUT 1

#define ALT_TPO_LCD_ADDR_CHIP_ID 0x1
#define ALT_TPO_LCD_ADDR_RESOLUTION 0x2
#define ALT_TPO_LCD_ADDR_RES_SEL_STBY 0x03

#define ALT_TPO_LCD_CHIP_ID_CONENTS 0xC1


typedef struct alt_tpo_lcd
{
  alt_u32 scen_pio;
  alt_u32 scl_pio;
  alt_u32 sda_pio;
} alt_tpo_lcd;

/*
 * Prototypes for public API 
 */
void alt_tpo_lcd_write_config_register(
   alt_tpo_lcd *lcd, alt_u8 addr, alt_u8 data);
                                       
alt_u8 alt_tpo_lcd_read_config_register(
  alt_tpo_lcd *lcd, alt_u8 addr);

int alt_tpo_lcd_init(alt_tpo_lcd *lcd, alt_u32 width, alt_u32 height);

// this may not be shipped
void alt_tpo_lcd_config_monitor(alt_tpo_lcd *lcd);

#endif /*ALT_TPO_LCD_H_*/
