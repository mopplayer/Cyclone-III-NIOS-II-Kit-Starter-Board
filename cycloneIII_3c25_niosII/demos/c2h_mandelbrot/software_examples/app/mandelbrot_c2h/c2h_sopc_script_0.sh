new_module c_hardware_accelerator
rename_module accelerator_mandelbrot_hw_draw_int_mandelbrot
select_module accelerator_mandelbrot_hw_draw_int_mandelbrot
edit_module C_FILE="D:/board_development/c2h_mandelbrot/software_examples/app/mandelbrot_c2h/././obj/hw_mandelbrot.c2h_pre" Subroutine_Name="hw_draw_int_mandelbrot" Accelerator_Group="mandelbrot" Preprocessor_Arguments=" " Output_Driver_File="D:/board_development/c2h_mandelbrot/software_examples/app/mandelbrot_c2h/././alt_c2h_hw_draw_int_mandelbrot.c" Output_Rules_File_Directory=" " dcache_flush="0" force_recompile="1" report_only="0" Generation_State="1" target_cpu_name="cpu" C2H_Legacy="0"
select_module descriptor_memory
lock_base_address lock=1 s2
lock_base_address lock=1 s1
select_module accelerator_mandelbrot_hw_draw_int_mandelbrot_managed_instance
lock_base_address lock=1 dummy_slave
lock_base_address lock=1 cpu_interface0
lock_base_address lock=1 sub_hw_draw_int_mandelbrot0
select_module sysid
lock_base_address lock=1 control_slave
select_module colour_lookup_table
lock_base_address lock=1 s2
lock_base_address lock=1 s1
select_module pio_id_eeprom_scl
lock_base_address lock=1 s1
select_module push_buttons
lock_base_address lock=1 s1
select_module jtag_uart
lock_base_address lock=1 avalon_jtag_slave
select_module lcd_ta_formatter_to_fifo
lock_base_address lock=1 in
select_module pipeline_bridge
lock_base_address lock=1 s1
select_module flash
lock_base_address lock=1 s1
select_module pio_id_eeprom_dat
lock_base_address lock=1 s1
select_module lcd_ta_fifo_to_sequencer
lock_base_address lock=1 in
select_module cpu
lock_base_address lock=1 jtag_debug_module
select_module lcd_data_format_adapter
lock_base_address lock=1 in
select_module frame_buffer
lock_base_address lock=1 s1
select_module lcd_on_chip_memory_fifo
lock_base_address lock=1 in
select_module lcd_pixel_converter
lock_base_address lock=1 in
select_module tristate_bridge
lock_base_address lock=1 avalon_slave
select_module lcd_sgdma
lock_base_address lock=1 csr
select_module clock_crossing_bridge
lock_base_address lock=1 s1
select_module lcd_i2c_dat
lock_base_address lock=1 s1
select_module lcd_i2c_scl
lock_base_address lock=1 s1
select_module touchPanel_spi
lock_base_address lock=1 spi_control_port
select_module system_tick
lock_base_address lock=1 s1
select_module lcd_i2c_cs
lock_base_address lock=1 s1
select_module frame_buffer_pipeline_bridge
lock_base_address lock=1 s1
select_module lcd_video_sequencer
lock_base_address lock=1 in
select_module touchPanel_irq_n
lock_base_address lock=1 s1
select_module lcd_data_format_adapter_1
lock_base_address lock=1 in
select_module flash_ssram_pipeline_bridge
lock_base_address lock=1 s1
select_module ssram
lock_base_address lock=1 s1
select_module ddr_sdram_clock_crossing_bridge
lock_base_address lock=1 s1
auto_address
select_module descriptor_memory
lock_base_address lock=0 s2
lock_base_address lock=0 s1
select_module accelerator_mandelbrot_hw_draw_int_mandelbrot_managed_instance
lock_base_address lock=0 dummy_slave
lock_base_address lock=0 cpu_interface0
lock_base_address lock=0 sub_hw_draw_int_mandelbrot0
select_module sysid
lock_base_address lock=0 control_slave
select_module colour_lookup_table
lock_base_address lock=0 s2
lock_base_address lock=0 s1
select_module pio_id_eeprom_scl
lock_base_address lock=0 s1
select_module push_buttons
lock_base_address lock=0 s1
select_module jtag_uart
lock_base_address lock=0 avalon_jtag_slave
select_module lcd_ta_formatter_to_fifo
lock_base_address lock=0 in
select_module pipeline_bridge
lock_base_address lock=0 s1
select_module pio_id_eeprom_dat
lock_base_address lock=0 s1
select_module flash
lock_base_address lock=0 s1
select_module lcd_ta_fifo_to_sequencer
lock_base_address lock=0 in
select_module cpu
lock_base_address lock=0 jtag_debug_module
select_module lcd_data_format_adapter
lock_base_address lock=0 in
select_module frame_buffer
lock_base_address lock=0 s1
select_module lcd_on_chip_memory_fifo
lock_base_address lock=0 in
select_module lcd_pixel_converter
lock_base_address lock=0 in
select_module tristate_bridge
lock_base_address lock=0 avalon_slave
select_module lcd_sgdma
lock_base_address lock=0 csr
select_module clock_crossing_bridge
lock_base_address lock=0 s1
select_module lcd_i2c_dat
lock_base_address lock=0 s1
select_module lcd_i2c_scl
lock_base_address lock=0 s1
select_module touchPanel_spi
lock_base_address lock=0 spi_control_port
select_module system_tick
lock_base_address lock=0 s1
select_module lcd_i2c_cs
lock_base_address lock=0 s1
select_module frame_buffer_pipeline_bridge
lock_base_address lock=0 s1
select_module lcd_video_sequencer
lock_base_address lock=0 in
select_module touchPanel_irq_n
lock_base_address lock=0 s1
select_module lcd_data_format_adapter_1
lock_base_address lock=0 in
select_module flash_ssram_pipeline_bridge
lock_base_address lock=0 s1
select_module ssram
lock_base_address lock=0 s1
select_module ddr_sdram_clock_crossing_bridge
lock_base_address lock=0 s1
wizard_finish

