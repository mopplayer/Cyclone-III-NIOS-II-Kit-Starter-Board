## Generated SDC file "cycloneIII_3c25_start_niosII_standard.sdc"

## Copyright (C) 1991-2009 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 9.1 Build 222 10/21/2009 SJ Web Edition"

## DATE    "Fri Jan 08 14:52:36 2010"

##
## DEVICE  "EP3C25F324C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {osc_clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {osc_clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {button[0]}]
set_input_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {button[1]}]
set_input_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {button[2]}]
set_input_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {button[3]}]
set_input_delay -add_delay  -clock [get_clocks {osc_clk}]  0.400 [get_ports {osc_clk}]
set_input_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {reset_n}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {led[0]}]
set_output_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {led[1]}]
set_output_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {led[2]}]
set_output_delay -add_delay  -clock [get_clocks {osc_clk}]  0.100 [get_ports {led[3]}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_write}] -to [get_registers {*|alt_jtag_atlantic:*|read_write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|td_shift[0]*}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|write_stalled*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [all_registers]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_dd9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_cd9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_gd9:dffpipe19|dffe20a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_fd9:dffpipe15|dffe16a*}]
set_false_path -from [get_pins -nocase -compatibility_mode {*the*clock*|slave_writedata_d1*|*}] -to [all_registers]
set_false_path -from [get_pins -nocase -compatibility_mode {*the*clock*|slave_nativeaddress_d1*|*}] -to [all_registers]
set_false_path -from [get_pins -nocase -compatibility_mode {*the*clock*|slave_readdata_p1*}] -to [all_registers]
set_false_path -from [get_keepers -nocase {*the*clock*|slave_readdata_p1*}] -to [all_registers]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_break:the_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[33]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_ready}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[0]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_error}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[34]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_ocimem:the_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_sysclk:the_cpu_jtag_debug_module_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_sysclk:the_cpu_jtag_debug_module_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_go}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|sr[0]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|sr[35]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|sr[37]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|count[9]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|state}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|td_shift[10]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|wdata[0]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|wdata[7]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|write_stalled}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {sld_hub:auto_hub|irsr_reg[6]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {sld_hub:auto_hub|jtag_ir_reg[9]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {sld_hub:auto_hub|node_ena[1]~reg0}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {sld_hub:auto_hub|node_ena[2]~reg0}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {sld_hub:auto_hub|sld_rom_sr:hub_info_reg|WORD_SR[3]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {sld_hub:auto_hub|tdo_bypass_reg}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|hub_mode_reg[0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|hub_mode_reg[1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[1][0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[1][1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[1][2]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[1][3]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[1][4]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[2][0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[2][1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[2][2]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[2][3]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|irf_reg[2][4]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|node_ena[1]~reg0}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|node_ena[2]~reg0}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|reset_ena_reg}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[1][0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[1][1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[1][2]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[1][3]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[1][4]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[2][0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[2][1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[2][2]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[2][3]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|shadow_irf_reg[2][4]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[2]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[3]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[4]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[5]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[6]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[7]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[8]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[9]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[10]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[11]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[12]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[13]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[14]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|state[15]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|tms_cnt[0]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|tms_cnt[1]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|sld_shadow_jsm:shadow_jsm|tms_cnt[2]}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|virtual_dr_scan_reg}]
set_false_path -from [get_ports {altera_reserved_tms}] -to [get_keepers {sld_hub:auto_hub|virtual_ir_scan_reg}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|sr[15]}]
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_keepers {cycloneIII_3c25_start_niosII_standard_sopc:this_cycloneIII_3c25_start_niosII_standard_SOPC|jtag_uart:the_jtag_uart|alt_jtag_atlantic:jtag_uart_alt_jtag_atlantic|td_shift[0]}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

