## Generated SDC file "cycloneIII_3c25_niosII_video.sdc"

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

## DATE    "Tue Mar 30 13:21:31 2010"

##
## DEVICE  "EP3C25F324C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}] -add
create_clock -name {top_clkin_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {top_clkin_50}]
create_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_capture} -period 7.518 -waveform { 0.000 3.759 } [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[*].dq[*].dqi|auto_generated|input_cell_*[0]|clk}] -add
create_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic} -period 7.518 -waveform { 0.000 3.759 } [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|DDR_CLK_OUT[0].ddr_clk_out_p|auto_generated|input_cell_h[0]|clk}]
create_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_top_mem_clk_mimic_launch_clock} -period 7.518 -waveform { 0.000 3.759 } [get_ports {top_mem_clk}] -add
create_clock -name {tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}] -add
create_clock -name {TX_CLK} -period 40.000 -waveform { 0.000 20.000 } [get_ports {top_HC_TX_CLK}]
create_clock -name {RX_CLK} -period 40.000 -waveform { 0.000 20.000 } [get_ports {top_HC_RX_CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

derive_pll_clocks
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {top_mem_clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {top_mem_clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_rise} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {top_mem_clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {top_mem_clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {top_mem_clk_n}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {top_mem_clk_n}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_rise} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {top_mem_clk_n}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]} -invert [get_ports {top_mem_clk_n}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_1} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[0].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_2} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[5].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_3} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[7].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_4} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[1].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_5} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[3].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_6} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[1].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_7} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[2].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_8} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[3].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_9} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[4].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_10} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[6].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_11} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[7].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_12} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[0].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_13} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[2].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_14} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[4].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_15} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[5].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_16} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[6].dqi|auto_generated|input_cell_h[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_17} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[0].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_18} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[1].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_19} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[2].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_20} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[3].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_21} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[4].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_22} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[5].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_23} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[6].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_24} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[0].dq[7].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_25} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[7].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_26} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[0].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_27} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[1].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_28} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[2].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_29} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[3].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_30} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[4].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_31} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[5].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_32} -source [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[1].dq[6].dqi|auto_generated|input_cell_l[0]|clk}] -add
create_generated_clock -name {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock} -source [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}] -divide_by 2 -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]} [get_pins {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q}] 
create_generated_clock -name {ssram_clk} -source [get_pins {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[1]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[1]} [get_ports {top_ssram_clk}] 
create_generated_clock -name {video_clk} -source [get_pins {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[0]}] -master_clock {cycloneIII_3c25_niosII_video_sopc_instance|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[0]} [get_ports {top_clk_to_offchip_video}] 


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

set_input_delay -add_delay  -clock [get_clocks {tck}]  20.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay  -clock [get_clocks {tck}]  20.000 [get_ports {altera_reserved_tms}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[0]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[0]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[1]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[1]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[2]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[2]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[3]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[3]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[4]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[4]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[5]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[5]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[6]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[6]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[7]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[7]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[8]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[8]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[9]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[9]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[10]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[10]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[11]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[11]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[12]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[12]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[13]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[13]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[14]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[14]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[15]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[15]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[16]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[16]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[17]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[17]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[18]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[18]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[19]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[19]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[20]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[20]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[21]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[21]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[22]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[22]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[23]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[23]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[24]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[24]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[25]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[25]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[26]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[26]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[27]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[27]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[28]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[28]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[29]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[29]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[30]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[30]}]
set_input_delay -add_delay -max -clock [get_clocks {ssram_clk}]  4.300 [get_ports {top_flash_ssram_d[31]}]
set_input_delay -add_delay -min -clock [get_clocks {ssram_clk}]  2.100 [get_ports {top_flash_ssram_d[31]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {tck}]  20.000 [get_ports {altera_reserved_tdo}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_DEN}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_DEN}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_HD}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_HD}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[0]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[0]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[1]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[1]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[2]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[2]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[3]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[3]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[4]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[4]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[5]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[5]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[6]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[6]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_LCD_DATA[7]}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_LCD_DATA[7]}]
set_output_delay -add_delay -max -clock [get_clocks {video_clk}]  7.000 [get_ports {top_HC_VD}]
set_output_delay -add_delay -min -clock [get_clocks {video_clk}]  2.000 [get_ports {top_HC_VD}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_cs_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_cs_n}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_oe_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_oe_n}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[0]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[0]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[4]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[4]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[5]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[5]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[6]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[6]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[7]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[7]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[8]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[8]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[9]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[9]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[10]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[10]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[11]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[11]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[12]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[12]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[13]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[13]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[14]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[14]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[15]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[15]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[16]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[16]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[17]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[17]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[18]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[18]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[19]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[19]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[20]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[20]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[21]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[21]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[22]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[22]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_a[23]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_a[23]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[0]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[0]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[4]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[4]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[5]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[5]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[6]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[6]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[7]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[7]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[8]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[8]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[9]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[9]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[10]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[10]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[11]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[11]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[12]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[12]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[13]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[13]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[14]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[14]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[15]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[15]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[16]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[16]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[17]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[17]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[18]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[18]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[19]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[19]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[20]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[20]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[21]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[21]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[22]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[22]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[23]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[23]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[24]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[24]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[25]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[25]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[26]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[26]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[27]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[27]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[28]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[28]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[29]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[29]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[30]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[30]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_ssram_d[31]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_ssram_d[31]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_flash_wr_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_flash_wr_n}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[0]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[0]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[1]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[1]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[2]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[2]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[2]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[2]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[3]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[3]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[3]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[3]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[4]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[4]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[4]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[4]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[5]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[5]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[5]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[5]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[6]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[6]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[6]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[6]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[7]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[7]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[7]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[7]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[8]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[8]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[8]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[8]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[9]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[9]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[9]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[9]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[10]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[10]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[10]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[10]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[11]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[11]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[11]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[11]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_addr[12]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_addr[12]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_addr[12]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_addr[12]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_ba[0]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_ba[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_ba[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_ba[0]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_ba[1]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_ba[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_ba[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_ba[1]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_cas_n}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_cas_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_cas_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_cas_n}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_cke}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_cke}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_cke}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_cke}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_cs_n}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_cs_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_cs_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_cs_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]  1.524 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]  -1.524 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]  5.433 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]  2.085 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]  5.433 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]  2.085 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]  1.524 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]  -1.524 [get_ports {top_mem_dqs[0]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]  1.524 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]  -1.524 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]  5.433 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]  2.085 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]  5.433 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]  2.085 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]  1.524 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]  -1.524 [get_ports {top_mem_dqs[1]}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_ras_n}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_ras_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_ras_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_ras_n}]
set_output_delay -add_delay -max -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  0.620 [get_ports {top_mem_we_n}]
set_output_delay -add_delay -min -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -0.620 [get_ports {top_mem_we_n}]
set_output_delay -add_delay -max -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  0.620 [get_ports {top_mem_we_n}]
set_output_delay -add_delay -min -clock_fall -clock [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -0.620 [get_ports {top_mem_we_n}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_adsc_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_adsc_n}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_bw_n[0]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_bw_n[0]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_bw_n[1]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_bw_n[1]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_bw_n[2]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_bw_n[2]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_bw_n[3]}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_bw_n[3]}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_bwe_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_bwe_n}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_ce_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_ce_n}]
set_output_delay -add_delay -max -clock [get_clocks {ssram_clk}]  1.700 [get_ports {top_ssram_oe_n}]
set_output_delay -add_delay -min -clock [get_clocks {ssram_clk}]  -0.700 [get_ports {top_ssram_oe_n}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -exclusive -group [get_clocks {tck}] 
set_clock_groups -exclusive -group [get_clocks {TX_CLK}] 
set_clock_groups -exclusive -group [get_clocks {RX_CLK}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {top_clkin_50}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {top_clkin_50}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_capture}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_rise}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_rise}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -fall_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]
set_false_path  -fall_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[2]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[2]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]
set_false_path  -from  [get_clocks {top_clkin_50}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {top_clkin_50}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_capture}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[4]}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_rise}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_rise}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ddr_mimic}]
set_false_path  -fall_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDQSS}]
set_false_path  -fall_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDQSS}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_tDSS}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[1]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_tDSS}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[2]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_p_top_mem_clk_ac_fall}]
set_false_path  -rise_from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[2]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_ck_n_top_mem_clk_n_ac_fall}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_1}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_2}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_3}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_4}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_5}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_6}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_7}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_8}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_9}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_10}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_11}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_12}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_13}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_14}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_15}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_16}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_17}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_18}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_19}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_20}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_21}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_22}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_23}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_24}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_25}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_26}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_27}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_28}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_29}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_30}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_31}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_32}]
set_false_path -from [get_keepers {{top_mem_dq[0]} {top_mem_dq[1]} {top_mem_dq[2]} {top_mem_dq[3]} {top_mem_dq[4]} {top_mem_dq[5]} {top_mem_dq[6]} {top_mem_dq[7]} {top_mem_dq[10]} {top_mem_dq[11]} {top_mem_dq[12]} {top_mem_dq[13]} {top_mem_dq[14]} {top_mem_dq[15]} {top_mem_dq[8]} {top_mem_dq[9]}}] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_1}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_2}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_3}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_4}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_5}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_6}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_7}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_8}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_9}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_10}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_11}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_12}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_13}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_14}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_15}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_16}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_17}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_18}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_19}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_20}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_21}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_22}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_23}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_24}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_25}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_26}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_27}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_28}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_29}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_30}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_31}]
set_false_path -from [get_ports *] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_dq_32}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_write}] -to [get_registers {*|alt_jtag_atlantic:*|read_write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|td_shift[0]*}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|write_stalled*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [get_registers *]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_dd9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_cd9:dffpipe12|dffe13a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ld9:dffpipe18|dffe19a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_kd9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_pd9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_od9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_jd9:dffpipe19|dffe20a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_hd9:dffpipe15|dffe16a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_nd9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_md9:dffpipe6|dffe7a*}]
set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_gd9:dffpipe19|dffe20a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_fd9:dffpipe15|dffe16a*}]
set_false_path -to [get_ports {top_mem_clk}]
set_false_path -to [get_ports {top_mem_clk_n}]
set_false_path -from [get_registers *] -to [get_ports {top_mem_dqs[0]}]
set_false_path -from [get_registers *] -to [get_ports {top_mem_dqs[1]}]
set_false_path -from [get_keepers {{top_mem_dq[0]} {top_mem_dq[1]} {top_mem_dq[2]} {top_mem_dq[3]} {top_mem_dq[4]} {top_mem_dq[5]} {top_mem_dq[6]} {top_mem_dq[7]} {top_mem_dq[10]} {top_mem_dq[11]} {top_mem_dq[12]} {top_mem_dq[13]} {top_mem_dq[14]} {top_mem_dq[15]} {top_mem_dq[8]} {top_mem_dq[9]}}] -to [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[3]}]
set_false_path -to [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|dpio|dqs_group[*].dq[*].dqi|auto_generated|input_*_*[0]|clrn}]
set_false_path -from [get_keepers {{top_mem_dq[0]} {top_mem_dq[1]} {top_mem_dq[2]} {top_mem_dq[3]} {top_mem_dq[4]} {top_mem_dq[5]} {top_mem_dq[6]} {top_mem_dq[7]} {top_mem_dq[10]} {top_mem_dq[11]} {top_mem_dq[12]} {top_mem_dq[13]} {top_mem_dq[14]} {top_mem_dq[15]} {top_mem_dq[8]} {top_mem_dq[9]}}] -to [get_registers *]
set_false_path -to [get_keepers {{top_mem_dq[0]} {top_mem_dq[1]} {top_mem_dq[2]} {top_mem_dq[3]} {top_mem_dq[4]} {top_mem_dq[5]} {top_mem_dq[6]} {top_mem_dq[7]} {top_mem_dq[10]} {top_mem_dq[11]} {top_mem_dq[12]} {top_mem_dq[13]} {top_mem_dq[14]} {top_mem_dq[15]} {top_mem_dq[8]} {top_mem_dq[9]} {top_mem_dm[0]} {top_mem_dm[1]}}]
set_false_path -from [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|*seq_wrapper|*seq_inst|*dgrb|?d_lat*|clk}] 
set_false_path -from [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|*seq_wrapper|*seq_inst|seq_mem_clk_disable*}] 
set_false_path -from [get_pins -compatibility_mode {*auk_*_hp_controller_inst|control_wlat_r*}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|*pll|altpll_component|auto_generated|pll_lock_sync|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|global_pre_clear|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|reset_master_ams|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|mem_clk_pipe|ams_pipe[*]|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|write_clk_pipe|ams_pipe[*]|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|measure_clk_pipe|ams_pipe[*]|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|resync_clk_pipe|ams_pipe[*]|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|clk_div_reset_ams_n_r|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|clk_div_reset_ams_n|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll_reconfig_reset_ams_n_r|clrn}] 
set_false_path -through [get_pins -compatibility_mode {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll_reconfig_reset_ams_n|clrn}] 
set_false_path -from [get_pins -compatibility_mode {*_alt_mem_phy_inst|*seq_wrapper|*seq_inst|*|seq_mmc_start*|*}] -to [get_keepers {*alt_mem_phy_mimic:mmc|seq_mmc_start_metastable*}]
set_false_path -from [get_keepers {*_alt_mem_phy_inst|*seq_wrapper|*seq_inst|seq_ac_add_1t_ac_lat_internal*}] 
set_false_path -from [get_pins -compatibility_mode {*_alt_mem_phy_inst|*mmc|mimic_done_out*}] -to [get_keepers {*_alt_mem_phy_inst|*seq_wrapper|*seq_inst|*dgrb|*v_mmc_seq_done_1r}]
set_false_path -from [get_registers *] -to [get_keepers {top_mem_cke top_mem_cs_n {top_mem_addr[0]} {top_mem_addr[10]} {top_mem_addr[11]} {top_mem_addr[12]} {top_mem_addr[1]} {top_mem_addr[2]} {top_mem_addr[3]} {top_mem_addr[4]} {top_mem_addr[5]} {top_mem_addr[6]} {top_mem_addr[7]} {top_mem_addr[8]} {top_mem_addr[9]} {top_mem_ba[0]} {top_mem_ba[1]} top_mem_cas_n top_mem_ras_n top_mem_we_n}]
set_false_path -from [get_ports {top_button[*]}] 
set_false_path -from [get_ports {top_reset_n}] 
set_false_path -to [get_ports {top_led[*]}]
set_false_path -from [get_keepers {*_domain_synch|data_out}] 
set_false_path -from [get_keepers {*oci_debug|resetrequest}] 
set_false_path -from [get_keepers {*|lcd_sgdma:the_lcd_sgdma|lcd_sgdma_chain:the_lcd_sgdma_chain|control_status_slave_which_resides_within_lcd_sgdma:the_control_status_slave_which_resides_within_lcd_sgdma|csr_irq}] -to [get_keepers {*|cpu_data_master_arbitrator:the_cpu_data_master|lcd_sgdma_csr_irq_from_sa_clock_crossing_cpu_data_master_module:lcd_sgdma_csr_irq_from_sa_clock_crossing_cpu_data_master|data_in_d1}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_break:the_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[33]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_ready}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[0]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_error}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr[34]}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_ocimem:the_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_tck:the_cpu_jtag_debug_module_tck|*sr*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_sysclk:the_cpu_jtag_debug_module_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_jtag_debug_module_wrapper:the_cpu_jtag_debug_module_wrapper|cpu_jtag_debug_module_sysclk:the_cpu_jtag_debug_module_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*cpu:the_cpu|cpu_nios2_oci:the_cpu_nios2_oci|cpu_nios2_oci_debug:the_cpu_nios2_oci_debug|monitor_go}]
set_false_path -from [get_pins -nocase -compatibility_mode {*the*clock*|slave_writedata_d1*|*}] -to [get_registers *]
set_false_path -from [get_pins -nocase -compatibility_mode {*the*clock*|slave_nativeaddress_d1*|*}] -to [get_registers *]
set_false_path -from [get_pins -nocase -compatibility_mode {*the*clock*|slave_readdata_p1*}] -to [get_registers *]
set_false_path -from [get_keepers -nocase {*the*clock*|slave_readdata_p1*}] -to [get_registers *]


#**************************************************************
# Set Multicycle Path
#**************************************************************

set_multicycle_path -setup -end -from  [get_clocks {ssram_clk}]  -to  [get_clocks {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[0]}] 2
set_multicycle_path -setup -end -to [get_keepers {{top_mem_addr[0]} {top_mem_addr[10]} {top_mem_addr[11]} {top_mem_addr[12]} {top_mem_addr[1]} {top_mem_addr[2]} {top_mem_addr[3]} {top_mem_addr[4]} {top_mem_addr[5]} {top_mem_addr[6]} {top_mem_addr[7]} {top_mem_addr[8]} {top_mem_addr[9]} {top_mem_ba[0]} {top_mem_ba[1]} top_mem_cas_n top_mem_ras_n top_mem_we_n}] 2
set_multicycle_path -hold -end -to [get_keepers {{top_mem_addr[0]} {top_mem_addr[10]} {top_mem_addr[11]} {top_mem_addr[12]} {top_mem_addr[1]} {top_mem_addr[2]} {top_mem_addr[3]} {top_mem_addr[4]} {top_mem_addr[5]} {top_mem_addr[6]} {top_mem_addr[7]} {top_mem_addr[8]} {top_mem_addr[9]} {top_mem_ba[0]} {top_mem_ba[1]} top_mem_cas_n top_mem_ras_n top_mem_we_n}] 1
set_multicycle_path -setup -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_altsyncram_dpm_fifo:U_RTSM|altsyncram*}] -to [get_registers *] 5
set_multicycle_path -setup -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] -to [get_registers *] 5
set_multicycle_path -setup -end -from [get_registers *] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] 5
set_multicycle_path -hold -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_altsyncram_dpm_fifo:U_RTSM|altsyncram*}] -to [get_registers *] 5
set_multicycle_path -hold -end -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] -to [get_registers *] 5
set_multicycle_path -hold -end -from [get_registers *] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|altera_tse_retransmit_cntl:U_RETR|*}] 5


#**************************************************************
# Set Maximum Delay
#**************************************************************

set_max_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}] 9.000
set_max_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}] 9.000
set_max_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_top_mem_clk_mimic_launch_clock}]  -to  [get_clocks {*ddr_mimic}] 2.500
set_max_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}] 9.000
set_max_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}] 9.000
set_max_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_top_mem_clk_mimic_launch_clock}]  -to  [get_clocks {*ddr_mimic}] 2.500
set_max_delay -from [get_keepers {{top_mem_dq[0]} {top_mem_dq[1]} {top_mem_dq[2]} {top_mem_dq[3]} {top_mem_dq[4]} {top_mem_dq[5]} {top_mem_dq[6]} {top_mem_dq[7]} {top_mem_dq[10]} {top_mem_dq[11]} {top_mem_dq[12]} {top_mem_dq[13]} {top_mem_dq[14]} {top_mem_dq[15]} {top_mem_dq[8]} {top_mem_dq[9]}}] -to [get_registers *] 2.620
set_max_delay -from [get_pins {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[1]}] -to [get_ports {top_ssram_clk}] 8.500
set_max_delay -from [get_pins {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[0]}] -to [get_ports {top_clk_to_offchip_video}] 8.500
set_max_delay -from [get_ports {top_HC_ADC_DOUT top_HC_ADC_PENIRQ_N}] 4.000
set_max_delay -to [get_ports {top_HC_ADC_CS_N top_HC_ADC_DCLK top_HC_ADC_DIN}] 14.000
set_max_delay -from [get_ports {top_HC_ID_I2CDAT}] 4.000
set_max_delay -to [get_ports {top_HC_ID_I2CDAT top_HC_ID_I2CSCL}] 12.000
set_max_delay -from [get_ports {top_HC_SDA}] 4.000
set_max_delay -to [get_ports {top_HC_SDA}] 12.000
set_max_delay -from [get_ports {top_HC_SD_DAT}] 4.000
set_max_delay -to [get_ports {top_HC_SD_DAT3 top_HC_SD_CMD top_HC_SD_CLK}] 12.000
set_max_delay -from [get_ports {top_HC_MDIO}] 4.000
set_max_delay -to [get_ports {top_HC_MDIO}] 12.000
set_max_delay -to [get_ports {top_HC_MDC top_HC_SCEN top_HC_UART_TXD}] 12.000
set_max_delay -from [get_ports { top_HC_RX_COL top_HC_RX_CRS top_HC_RX_D[*] top_HC_RX_DV top_HC_RX_ERR}] 4.000
set_max_delay -to [get_ports {top_HC_TX_D[*] top_HC_TX_EN}] 12.000
set_max_delay -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|dout_reg_sft*}] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*}] 7.000
set_max_delay -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|eop_sft*}] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*}] 7.000
set_max_delay -from [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_tx_min_ff:U_TXFF|sop_reg*}] -to [get_registers {*|altera_tse_top_w_fifo:U_MAC|altera_tse_top_1geth:U_GETH|altera_tse_mac_tx:U_TX|*}] 7.000


#**************************************************************
# Set Minimum Delay
#**************************************************************

set_min_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}] -9.000
set_min_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}] -9.000
set_min_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}] -9.000
set_min_delay -from  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|pll|altpll_component|auto_generated|pll1|clk[0]}]  -to  [get_clocks {cycloneIII_3c25_niosII_video_sopc_instance|the_ddr_sdram|ddr_sdram_controller_phy_inst|ddr_sdram_phy_inst|ddr_sdram_phy_alt_mem_phy_inst|clk|scan_clk|q_clock}] -9.000
set_min_delay -from [get_keepers {{top_mem_dq[0]} {top_mem_dq[1]} {top_mem_dq[2]} {top_mem_dq[3]} {top_mem_dq[4]} {top_mem_dq[5]} {top_mem_dq[6]} {top_mem_dq[7]} {top_mem_dq[10]} {top_mem_dq[11]} {top_mem_dq[12]} {top_mem_dq[13]} {top_mem_dq[14]} {top_mem_dq[15]} {top_mem_dq[8]} {top_mem_dq[9]}}] -to [get_registers *] 1.781
set_min_delay -from [get_pins {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[1]}] -to [get_ports {top_ssram_clk}] 3.500
set_min_delay -from [get_pins {*|the_pll|the_pll|altpll_component|auto_generated|pll1|clk[0]}] -to [get_ports {top_clk_to_offchip_video}] 3.500
set_min_delay -from [get_ports {top_HC_ADC_DOUT top_HC_ADC_PENIRQ_N}] 0.000
set_min_delay -to [get_ports {top_HC_ADC_CS_N top_HC_ADC_DCLK top_HC_ADC_DIN}] 4.000
set_min_delay -from [get_ports {top_HC_ID_I2CDAT}] 0.000
set_min_delay -to [get_ports {top_HC_ID_I2CDAT top_HC_ID_I2CSCL}] 4.000
set_min_delay -from [get_ports {top_HC_SDA}] 0.000
set_min_delay -to [get_ports {top_HC_SDA}] 4.000
set_min_delay -from [get_ports {top_HC_SD_DAT}] 0.000
set_min_delay -to [get_ports {top_HC_SD_DAT3 top_HC_SD_CMD top_HC_SD_CLK}] 4.000
set_min_delay -from [get_ports {top_HC_MDIO}] 0.000
set_min_delay -to [get_ports {top_HC_MDIO}] 4.000
set_min_delay -to [get_ports {top_HC_MDC top_HC_SCEN top_HC_UART_TXD}] 4.000
set_min_delay -from [get_ports { top_HC_RX_COL top_HC_RX_CRS top_HC_RX_D[*] top_HC_RX_DV top_HC_RX_ERR}] 0.000
set_min_delay -to [get_ports {top_HC_TX_D[*] top_HC_TX_EN}] 4.000
set_false_path -from {cycloneIII_3c25_niosII_video_sopc:cycloneIII_3c25_niosII_video_sopc_instance|tse_mac:the_tse_mac|altera_tse_mac:altera_tse_mac_inst|altera_tse_top_gen_host:top_gen_host_inst|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_mii_tx_if:U_MTX|mii_txd_reg[2]} -to {top_HC_TX_D[2]}
set_false_path -from {cycloneIII_3c25_niosII_video_sopc:cycloneIII_3c25_niosII_video_sopc_instance|tse_mac:the_tse_mac|altera_tse_mac:altera_tse_mac_inst|altera_tse_top_gen_host:top_gen_host_inst|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_mii_tx_if:U_MTX|mii_txd_reg[1]} -to {top_HC_TX_D[1]}
set_false_path -from {cycloneIII_3c25_niosII_video_sopc:cycloneIII_3c25_niosII_video_sopc_instance|tse_mac:the_tse_mac|altera_tse_mac:altera_tse_mac_inst|altera_tse_top_gen_host:top_gen_host_inst|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_mii_tx_if:U_MTX|mii_txdv_reg} -to {top_HC_TX_EN}
set_false_path -from {cycloneIII_3c25_niosII_video_sopc:cycloneIII_3c25_niosII_video_sopc_instance|tse_mac:the_tse_mac|altera_tse_mac:altera_tse_mac_inst|altera_tse_top_gen_host:top_gen_host_inst|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_mii_tx_if:U_MTX|mii_txd_reg[0]} -to {top_HC_TX_D[0]}
set_false_path -from {cycloneIII_3c25_niosII_video_sopc:cycloneIII_3c25_niosII_video_sopc_instance|tse_mac:the_tse_mac|altera_tse_mac:altera_tse_mac_inst|altera_tse_top_gen_host:top_gen_host_inst|altera_tse_top_w_fifo_10_100_1000:U_MAC_TOP|altera_tse_mii_tx_if:U_MTX|mii_txd_reg[3]} -to {top_HC_TX_D[3]}

#**************************************************************
# Set Input Transition
#**************************************************************

