derive_pll_clocks -create_base_clocks


## Setting up some handy PLL name aliases 
set int_system_clock inst2|altpll_component|auto_generated|pll1|clk[0]
set int_video_clock inst2|altpll_component|auto_generated|pll1|clk[2]


## Derive the video and ssram clocks offchip
create_generated_clock -name ext_video_clock -source [get_pins $int_video_clock] [get_ports video_clk]
create_generated_clock -name ext_ssram_clock -source [get_pins $int_system_clock] [get_ports ssram_clk]
create_clock -period 10.000 -name virtual_video_clock
create_clock -period 10.000 -name virtual_ssram_clock 


## Cutting paths between the JTAG and all other ports
set_clock_groups -asynchronous -group {altera_internal_jtag|tckutap}


## Cutting paths for the slow I/O
set_false_path -to [get_ports {touch_panel_*}]
set_false_path -from [get_ports {touch_panel_*}]
set_false_path -to [get_ports {eeprom_*}]
set_false_path -from [get_ports {eeprom_dat}]
set_false_path -to [get_ports {lcd_i2c_*}]
set_false_path -from [get_ports {lcd_i2c_dat}]
set_false_path -to [get_ports {serial_clk}]
set_false_path -from [get_ports {push_buttons[*]}]


## Cutting paths for the JTAG tdo, tdi, and tms pins
set_false_path -to [get_ports altera_reserved_tdo]
set_false_path -from [get_ports altera_reserved_tdi]
set_false_path -from [get_ports altera_reserved_tms]


## Cutting the input reset path since SOPC Builder syncronizes the reset input
set_false_path -from [get_ports pld_clear_n]


## Constraints for the SSRAM and Flash bus.  Using the SSRAM setup and hold times since the CFI Flash component
## will make sure that the setup/hold/wait times of the Flash are met.  The SSRAM memory has the following timing
## at 200MHz:  Tsu = 1.4ns, Th = 0.4ns, Tco = 3.1ns.  Using overestimates since board trace lengths haven't been factored
## in and to give some timing margin.
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports flash_*]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports flash_*]
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports tristate_bus_*]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports tristate_bus_*]
set_input_delay -clock ext_ssram_clock -max 3.2 [get_ports tristate_bus_data[*]] -add_delay
set_input_delay -clock ext_ssram_clock -min 0 [get_ports tristate_bus_data[*]] -add_delay
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports ssram_adsc_n]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports ssram_adsc_n]
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports ssram_bw_n[*]]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports ssram_bw_n[*]]
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports ssram_bwe_n]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports ssram_bwe_n]
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports ssram_chipenable_n]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports ssram_chipenable_n]
set_output_delay -clock ext_ssram_clock -max 1.5 [get_ports ssram_outputenable_n]
set_output_delay -clock ext_ssram_clock -min -0.5 [get_ports ssram_outputenable_n]
set_output_delay -clock virtual_ssram_clock 0 [get_ports ssram_clk]



## Constraining the LCD interface (worst case Tsu = 1.549ns, Th = 0.298ns for the offchip video interface).
## Using overestimates since board trace lengths haven't been factored in and to give some timing margin.
set_output_delay -clock ext_video_clock -max 2 [get_ports lcd_den]
set_output_delay -clock ext_video_clock -min -1 [get_ports lcd_den]
set_output_delay -clock ext_video_clock -max 2 [get_ports lcd_hd]
set_output_delay -clock ext_video_clock -min -1 [get_ports lcd_hd]
set_output_delay -clock ext_video_clock -max 2 [get_ports lcd_rgb[*]]
set_output_delay -clock ext_video_clock -min -1 [get_ports lcd_rgb[*]]
set_output_delay -clock ext_video_clock -max 2 [get_ports lcd_vd]
set_output_delay -clock ext_video_clock -min -1 [get_ports lcd_vd]
set_output_delay -clock virtual_video_clock 0 [get_ports video_clk]


## Cutting paths between reset blocks
set_false_path -from {system:inst|system_reset_system_clk_domain_synch_module:system_reset_system_clk_domain_synch|data_out*} -to {*}
set_false_path -from {system:inst|system_reset_ext_clk_one_domain_synch_module:system_reset_ext_clk_one_domain_synch|data_out*} -to {*}
set_false_path -from {system:inst|cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|resetrequest*} -to {*}