## Generated SDC file "cycloneIII_3c25_start_my_first_fpga.sdc"

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

## DATE    "Tue Mar 30 11:37:34 2010"

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

derive_pll_clocks -create_base_clocks


#**************************************************************
# Create Generated Clock
#**************************************************************



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

set_input_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  10.000 [get_ports {button[0]}]
set_input_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {button[0]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  10.000 [get_ports {led[0]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {led[0]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  10.000 [get_ports {led[1]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {led[1]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  10.000 [get_ports {led[2]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {led[2]}]
set_output_delay -add_delay -max -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  10.000 [get_ports {led[3]}]
set_output_delay -add_delay -min -clock [get_clocks {inst1|altpll_component|auto_generated|pll1|clk[0]}]  1.000 [get_ports {led[3]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



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

