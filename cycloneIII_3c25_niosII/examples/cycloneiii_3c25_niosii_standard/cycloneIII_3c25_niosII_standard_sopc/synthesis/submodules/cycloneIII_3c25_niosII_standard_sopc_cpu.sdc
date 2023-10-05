# Legal Notice: (C)2012 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	cycloneIII_3c25_niosII_standard_sopc_cpu 	cycloneIII_3c25_niosII_standard_sopc_cpu:*
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_oci 	cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_oci:the_cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_oci
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_oci_break 	cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_oci_break:the_cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_oci_break
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_ocimem 	cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_ocimem:the_cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_ocimem
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug 	cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_oci_debug:the_cycloneIII_3c25_niosII_standard_sopc_cpu_nios2_oci_debug
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_wrapper 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_debug_module_wrapper:the_cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_debug_module_wrapper
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_tck 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_debug_module_tck:the_cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_debug_module_tck
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sysclk 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_debug_module_sysclk:the_cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_debug_module_sysclk
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_oci_path 	 [format "%s|%s" $cycloneIII_3c25_niosII_standard_sopc_cpu $cycloneIII_3c25_niosII_standard_sopc_cpu_oci]
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_oci_break_path 	 [format "%s|%s" $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_path $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_break]
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_ocimem_path 	 [format "%s|%s" $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_path $cycloneIII_3c25_niosII_standard_sopc_cpu_ocimem]
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug_path 	 [format "%s|%s" $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_path $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug]
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_tck_path 	 [format "%s|%s|%s" $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_path $cycloneIII_3c25_niosII_standard_sopc_cpu_wrapper $cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_tck]
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $cycloneIII_3c25_niosII_standard_sopc_cpu_oci_path $cycloneIII_3c25_niosII_standard_sopc_cpu_wrapper $cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sysclk]
set 	cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr 	 [format "%s|*sr" $cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_oci_break_path|break_readreg*] -to [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr*]
set_false_path -from [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr*]
set_false_path -from *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sr*    -to *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$cycloneIII_3c25_niosII_standard_sopc_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$cycloneIII_3c25_niosII_standard_sopc_cpu_oci_debug_path|monitor_go
