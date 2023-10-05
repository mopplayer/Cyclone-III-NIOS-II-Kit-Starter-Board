## Generated SDC file "my_constraints.sdc"

## Copyright (C) 1991-2010 Altera Corporation
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
## VERSION "Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Full Version"

## DATE    "Tue Mar 30 15:00:36 2010"

##
## DEVICE  "EP3C25F324C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {ext_50M_clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {ext_50M_clk}]
create_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_capture} -period 6.666 -waveform { 0.000 3.333 } [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[*].dq[*].dqi|auto_generated|input_cell_*[0]|clk}] -add
create_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic} -period 6.666 -waveform { 0.000 3.333 } [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|DDR_CLK_OUT[0].ddr_clk_out_p|auto_generated|input_cell_h[0]|clk}]
create_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_mem_clk[0]_mimic_launch_clock} -period 6.666 -waveform { 0.000 3.333 } [get_ports {mem_clk[0]}] -add
create_clock -name {virtual_video_clock} -period 10.000 -waveform { 0.000 5.000 } 
create_clock -name {virtual_ssram_clock} -period 10.000 -waveform { 0.000 5.000 } 


#**************************************************************
# Create Generated Clock
#**************************************************************

derive_pll_clocks
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {mem_clk[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {mem_clk[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_rise} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {mem_clk[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {mem_clk[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {mem_clk_n[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {mem_clk_n[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_rise} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {mem_clk_n[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {mem_clk_n[0]}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_1} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[0].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_2} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[1].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_3} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[2].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_4} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[3].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_5} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[4].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_6} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[5].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_7} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[6].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_8} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[7].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_9} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[0].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_10} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[1].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_11} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[2].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_12} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[3].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_13} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[4].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_14} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[5].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_15} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[6].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_16} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[7].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_17} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[0].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_18} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[1].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_19} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[2].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_20} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[3].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_21} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[4].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_22} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[5].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_23} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[6].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_24} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[7].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_25} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[0].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_26} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[1].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_27} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[2].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_28} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[3].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_29} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[4].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_30} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[5].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_31} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[6].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_32} -source [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[7].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|scan_clk|q_clock} -source [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -divide_by 2 -master_clock {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_pins {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|scan_clk|q}] 
create_generated_clock -name {ext_video_clock} -source [get_pins {inst2|altpll_component|auto_generated|pll1|clk[2]}] -master_clock {inst2|altpll_component|auto_generated|pll1|clk[2]} [get_ports {video_clk}] 
create_generated_clock -name {ext_ssram_clock} -source [get_pins {inst2|altpll_component|auto_generated|pll1|clk[0]}] -master_clock {inst2|altpll_component|auto_generated|pll1|clk[0]} [get_ports {ssram_clk}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

derive_clock_uncertainty


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[0]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[0]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[1]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[1]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[2]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[2]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[3]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[3]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[4]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[4]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[5]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[5]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[6]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[6]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[7]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[7]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[8]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[8]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[9]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[9]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[10]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[10]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[11]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[11]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[12]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[12]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[13]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[13]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[14]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[14]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[15]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[15]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[16]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[16]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[17]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[17]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[18]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[18]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[19]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[19]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[20]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[20]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[21]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[21]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[22]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[22]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[23]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[23]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[24]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[24]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[25]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[25]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[26]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[26]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[27]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[27]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[28]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[28]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[29]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[29]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[30]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[30]}]
set_input_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  3.200 [get_ports {tristate_bus_data[31]}]
set_input_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  0.000 [get_ports {tristate_bus_data[31]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {flash_read_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {flash_read_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {flash_reset_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {flash_reset_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {flash_select_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {flash_select_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {flash_write_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {flash_write_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_den}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_den}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_hd}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_hd}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[0]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[0]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[4]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[4]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[5]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[5]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[6]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[6]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_rgb[7]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_rgb[7]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_video_clock}]  2.000 [get_ports {lcd_vd}]
set_output_delay -add_delay -min -clock [get_clocks {ext_video_clock}]  -1.000 [get_ports {lcd_vd}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[1]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[1]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[2]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[2]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[2]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[2]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[3]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[3]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[3]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[3]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[4]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[4]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[4]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[4]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[5]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[5]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[5]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[5]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[6]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[6]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[6]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[6]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[7]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[7]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[7]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[7]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[8]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[8]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[8]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[8]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[9]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[9]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[9]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[9]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[10]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[10]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[10]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[10]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[11]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[11]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[11]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[11]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_addr[12]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_addr[12]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_addr[12]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_addr[12]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_ba[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_ba[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_ba[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_ba[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_ba[1]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_ba[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_ba[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_ba[1]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_cas_n}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_cas_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_cas_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_cas_n}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_cke[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_cke[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_cke[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_cke[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_cs_n[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_cs_n[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_cs_n[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_cs_n[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS}]  4.820 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS}]  1.846 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS}]  1.353 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS}]  -1.353 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS}]  1.353 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS}]  -1.353 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS}]  4.820 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS}]  1.846 [get_ports {mem_dqs[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS}]  4.820 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS}]  1.846 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS}]  1.353 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS}]  -1.353 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS}]  1.353 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS}]  -1.353 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS}]  4.820 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS}]  1.846 [get_ports {mem_dqs[1]}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_ras_n}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_ras_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_ras_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_ras_n}]
set_output_delay -add_delay -max -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  0.620 [get_ports {mem_we_n}]
set_output_delay -add_delay -min -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]  -0.620 [get_ports {mem_we_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  0.620 [get_ports {mem_we_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]  -0.620 [get_ports {mem_we_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_adsc_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_adsc_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_bw_n[0]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_bw_n[0]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_bw_n[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_bw_n[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_bw_n[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_bw_n[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_bw_n[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_bw_n[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_bwe_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_bwe_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_chipenable_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_chipenable_n}]
set_output_delay -add_delay  -clock [get_clocks {virtual_ssram_clock}]  0.000 [get_ports {ssram_clk}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {ssram_outputenable_n}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {ssram_outputenable_n}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[4]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[4]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[5]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[5]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[6]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[6]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[7]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[7]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[8]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[8]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[9]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[9]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[10]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[10]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[11]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[11]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[12]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[12]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[13]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[13]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[14]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[14]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[15]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[15]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[16]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[16]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[17]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[17]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[18]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[18]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[19]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[19]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[20]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[20]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[21]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[21]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[22]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[22]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_address[23]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_address[23]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[0]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[0]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[4]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[4]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[5]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[5]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[6]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[6]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[7]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[7]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[8]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[8]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[9]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[9]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[10]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[10]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[11]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[11]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[12]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[12]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[13]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[13]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[14]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[14]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[15]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[15]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[16]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[16]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[17]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[17]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[18]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[18]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[19]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[19]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[20]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[20]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[21]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[21]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[22]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[22]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[23]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[23]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[24]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[24]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[25]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[25]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[26]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[26]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[27]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[27]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[28]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[28]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[29]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[29]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[30]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[30]}]
set_output_delay -add_delay -max -clock [get_clocks {ext_ssram_clock}]  1.500 [get_ports {tristate_bus_data[31]}]
set_output_delay -add_delay -min -clock [get_clocks {ext_ssram_clock}]  -0.500 [get_ports {tristate_bus_data[31]}]
set_output_delay -add_delay  -clock [get_clocks {virtual_video_clock}]  0.000 [get_ports {video_clk}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {ext_50M_clk}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]
set_false_path  -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {ext_50M_clk}]
set_false_path  -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]
set_false_path  -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_capture}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}]
set_false_path  -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_rise}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_rise}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {{inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS}}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ddr_mimic}]
set_false_path  -fall_from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDQSS}]
set_false_path  -fall_from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDQSS}]
set_false_path  -rise_from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_tDSS}]
set_false_path  -rise_from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_tDSS}]
set_false_path  -rise_from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[2]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_p_mem_clk[0]_ac_fall}]
set_false_path  -rise_from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[2]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_ck_n_mem_clk_n[0]_ac_fall}]
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
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_hd9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_gd9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_kd9:dffpipe19|dffe20a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_id9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_re9:dffpipe19|dffe20a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_qe9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_fd9:dffpipe10|dffe11a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_ed9:dffpipe6|dffe7a*}]
set_false_path -to [get_ports {mem_clk[0]}]
set_false_path -to [get_ports {mem_clk_n[0]}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_1}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_2}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_3}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_4}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_5}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_6}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_7}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_8}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_9}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_10}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_11}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_12}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_13}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_14}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_15}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_16}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_17}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_18}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_19}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_20}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_21}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_22}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_23}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_24}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_25}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_26}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_27}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_28}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_29}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_30}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_31}]
set_false_path -from [get_ports *] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_dq_32}]
set_false_path -from [all_registers] -to [get_ports {mem_dqs[0]}]
set_false_path -from [all_registers] -to [get_ports {mem_dqs[1]}]
set_false_path -from [get_keepers {{mem_dq[0]} {mem_dq[1]} {mem_dq[2]} {mem_dq[3]} {mem_dq[4]} {mem_dq[5]} {mem_dq[6]} {mem_dq[7]} {mem_dq[10]} {mem_dq[11]} {mem_dq[12]} {mem_dq[13]} {mem_dq[14]} {mem_dq[15]} {mem_dq[8]} {mem_dq[9]}}] -to [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}]
set_false_path -to [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|dpio|dqs_group[*].dq[*].dqi|auto_generated|input_*_*[0]|clrn}]
set_false_path -from [get_keepers {{mem_dq[0]} {mem_dq[1]} {mem_dq[2]} {mem_dq[3]} {mem_dq[4]} {mem_dq[5]} {mem_dq[6]} {mem_dq[7]} {mem_dq[10]} {mem_dq[11]} {mem_dq[12]} {mem_dq[13]} {mem_dq[14]} {mem_dq[15]} {mem_dq[8]} {mem_dq[9]}}] -to [all_registers]
set_false_path -to [get_keepers {{mem_dq[0]} {mem_dq[1]} {mem_dq[2]} {mem_dq[3]} {mem_dq[4]} {mem_dq[5]} {mem_dq[6]} {mem_dq[7]} {mem_dq[10]} {mem_dq[11]} {mem_dq[12]} {mem_dq[13]} {mem_dq[14]} {mem_dq[15]} {mem_dq[8]} {mem_dq[9]} {mem_dm[0]} {mem_dm[1]}}]
set_false_path -from [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|*seq_wrapper|*seq_inst|*dgrb|?d_lat*|clk}] 
set_false_path -from [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|*seq_wrapper|*seq_inst|seq_mem_clk_disable*}] 
set_false_path -from [get_pins -compatibility_mode {*auk_*_hp_controller_inst|control_wlat_r*}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|*pll|altpll_component|auto_generated|pll_lock_sync|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|global_pre_clear|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|reset_master_ams|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|measure_clk_pipe|ams_pipe[*]|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|resync_clk_pipe|ams_pipe[*]|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|clk_div_reset_ams_n_r|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|clk_div_reset_ams_n|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll_reconfig_reset_ams_n_r|clrn}] 
set_false_path -through [get_pins -compatibility_mode {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll_reconfig_reset_ams_n|clrn}] 
set_false_path -from [get_pins -compatibility_mode {*_alt_mem_phy_inst|*seq_wrapper|*seq_inst|*|seq_mmc_start*|*}] -to [get_keepers {*alt_mem_phy_mimic:mmc|seq_mmc_start_metastable*}]
set_false_path -from [get_keepers {*_alt_mem_phy_inst|*seq_wrapper|*seq_inst|seq_ac_add_1t_ac_lat_internal*}] 
set_false_path -from [get_pins -compatibility_mode {*_alt_mem_phy_inst|*mmc|mimic_done_out*}] -to [get_keepers {*_alt_mem_phy_inst|*seq_wrapper|*seq_inst|*dgrb|*v_mmc_seq_done_1r}]
set_false_path -from [all_registers] -to [get_keepers {{mem_addr[0]} {mem_addr[10]} {mem_addr[11]} {mem_addr[12]} {mem_addr[1]} {mem_addr[2]} {mem_addr[3]} {mem_addr[4]} {mem_addr[5]} {mem_addr[6]} {mem_addr[7]} {mem_addr[8]} {mem_addr[9]} {mem_ba[0]} {mem_ba[1]} mem_cas_n mem_ras_n mem_we_n {mem_cke[0]} {mem_cs_n[0]}}]
set_false_path -to [get_ports {touch_panel_*}]
set_false_path -from [get_ports {touch_panel_*}] 
set_false_path -to [get_ports {eeprom_*}]
set_false_path -from [get_ports {eeprom_dat}] 
set_false_path -to [get_ports {lcd_i2c_*}]
set_false_path -from [get_ports {lcd_i2c_dat}] 
set_false_path -to [get_ports {serial_clk}]
set_false_path -from [get_ports {push_buttons[*]}] 
set_false_path -to [get_ports {altera_reserved_tdo}]
set_false_path -from [get_ports {altera_reserved_tdi}] 
set_false_path -from [get_ports {altera_reserved_tms}] 
set_false_path -from [get_ports {pld_clear_n}] 
set_false_path -from [get_keepers {system:inst|system_reset_system_clk_domain_synch_module:system_reset_system_clk_domain_synch|data_out*}] 
set_false_path -from [get_keepers {system:inst|system_reset_ext_clk_one_domain_synch_module:system_reset_ext_clk_one_domain_synch|data_out*}] 
set_false_path -from [get_keepers {system:inst|cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|resetrequest*}] 
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_break:the_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[33]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_ready}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[0]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_error}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[34]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_ocimem:the_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_sysclk:the_cpu_jtag_debug_module_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_sysclk:the_cpu_jtag_debug_module_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_go}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] 9.000
set_max_delay -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}] 9.000
set_max_delay -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_mem_clk[0]_mimic_launch_clock}]  -to  [get_clocks {*ddr_mimic}] 2.500
set_max_delay -from [get_keepers {{mem_dq[0]} {mem_dq[1]} {mem_dq[2]} {mem_dq[3]} {mem_dq[4]} {mem_dq[5]} {mem_dq[6]} {mem_dq[7]} {mem_dq[10]} {mem_dq[11]} {mem_dq[12]} {mem_dq[13]} {mem_dq[14]} {mem_dq[15]} {mem_dq[8]} {mem_dq[9]}}] -to [all_registers] 2.428


#**************************************************************
# Set Minimum Delay
#**************************************************************

set_min_delay -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -9.000
set_min_delay -from  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {inst|the_frame_buffer|frame_buffer_controller_phy_inst|frame_buffer_phy_inst|frame_buffer_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}] -9.000
set_min_delay -from [get_keepers {{mem_dq[0]} {mem_dq[1]} {mem_dq[2]} {mem_dq[3]} {mem_dq[4]} {mem_dq[5]} {mem_dq[6]} {mem_dq[7]} {mem_dq[10]} {mem_dq[11]} {mem_dq[12]} {mem_dq[13]} {mem_dq[14]} {mem_dq[15]} {mem_dq[8]} {mem_dq[9]}}] -to [all_registers] 1.972


#**************************************************************
# Set Input Transition
#**************************************************************

