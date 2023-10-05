## Generated SDC file "cycloneIII_3c25_start_power.sdc"

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

## DATE    "Wed Dec 23 19:17:04 2009"

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

derive_pll_clocks -create_base_clocks


#**************************************************************
# Create Generated Clock
#**************************************************************

create_clock -name {i_clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {i_clk}] -add

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



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -exclusive -group [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[0]}] -group [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[1] cgen|pll|altpll_component|auto_generated|pll1|clk[2]}] 
set_clock_groups -exclusive -group [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[1]}] -group [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[0] cgen|pll|altpll_component|auto_generated|pll1|clk[2]}] 
set_clock_groups -exclusive -group [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[2]}] -group [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[0] cgen|pll|altpll_component|auto_generated|pll1|clk[1]}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[3]}]  -to  [get_clocks {cgen|pll|altpll_component|auto_generated|pll1|clk[0] cgen|pll|altpll_component|auto_generated|pll1|clk[1] cgen|pll|altpll_component|auto_generated|pll1|clk[2]}]
set_false_path -from [get_ports {i_nfreq_next i_noutput_ena i_nperc_next i_nrst}] 
set_false_path -to [get_ports {o_outputs[0] o_outputs[1] o_outputs[2] o_outputs[3] o_outputs[4] o_outputs[5] o_outputs[6] o_outputs[7] o_outputs[8] o_outputs[9] o_outputs[10] o_outputs[11] o_outputs[12] o_outputs[13] o_outputs[14] o_outputs[15] o_outputs[16] o_outputs[17] o_outputs[18] o_outputs[19] o_outputs[20] o_outputs[21] o_outputs[22] o_outputs[23] o_outputs[24] o_outputs[25] o_outputs[26] o_outputs[27] o_outputs[28] o_outputs[29] o_outputs[30] o_outputs[31] o_outputs[32] o_outputs[33] o_outputs[34] o_outputs[35] o_outputs[36] o_outputs[37] o_outputs[38] o_outputs[39] o_outputs[40] o_outputs[41] o_outputs[42] o_outputs[43] o_outputs[44] o_outputs[45] o_outputs[46] o_outputs[47] o_outputs[48] o_outputs[49] o_outputs[50] o_outputs[51] o_outputs[52] o_outputs[53] o_outputs[54] o_outputs[55] o_outputs[56] o_outputs[57] o_outputs[58] o_outputs[59] o_outputs[60] o_outputs[61] o_outputs[62] o_outputs[63]}]
set_false_path -to [get_ports {o_nfreq_state[0] o_nfreq_state[1] o_nperc_state[0] o_nperc_state[1]}]


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

