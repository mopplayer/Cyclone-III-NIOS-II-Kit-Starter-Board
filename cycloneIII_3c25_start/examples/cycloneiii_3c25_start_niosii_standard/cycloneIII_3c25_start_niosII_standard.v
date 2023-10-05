/*cycloneIII_3c25_start_niosII_standard.v
/*This is a top level wrapper file that instanciates the
/*nios2 sopc builder system
/*
*/
module cycloneIII_3c25_start_niosII_standard(
               // global signals:
input            osc_clk,
input            reset_n,

               // the_button and led pios
input   [  3: 0] button,
output  [  3: 0] led, 		// note: led[1] needs distinct Assignment Setting: 
							// I/O Standard = "SSTL-2 Class I" 
							// due to location within the DDR block  
													              
                // ddr
output  [ 12: 0] ddr_addr,
output  [  1: 0] ddr_ba,
output           ddr_cas_n,
output           ddr_cke,
inout            ddr_clk_n,
inout            ddr_clk,
output           ddr_cs_n,
output  [  1: 0] ddr_dm,
inout   [ 15: 0] ddr_dq,
inout   [  1: 0] ddr_dqs,
output           ddr_ras_n,
output           ddr_we_n,
                 
               // flash/ssram shared bus
output  [ 23: 0] flash_ssram_a,
inout   [ 31: 0] flash_ssram_d,                             
               
output           ssram_adsc_n,
output  [  3: 0] ssram_bw_n,
output           ssram_bwe_n,
output           ssram_ce_n,
output           ssram_oe_n,
output           flash_oe_n,
output           flash_cs_n,
output           flash_wr_n,
output           ssram_clk,
output           flash_reset_n,           
                                  
output           hsmc_clk
);

  assign flash_reset_n = reset_n;
cycloneIII_3c25_start_niosII_standard_sopc this_cycloneIII_3c25_start_niosII_standard_SOPC
	(
		.adsc_n_to_the_ext_ssram(ssram_adsc_n),
		.bw_n_to_the_ext_ssram(ssram_bw_n),
		.bwe_n_to_the_ext_ssram(ssram_bwe_n),
		.chipenable1_n_to_the_ext_ssram(ssram_ce_n),
		.flash_ssram_tristate_bridge_address(flash_ssram_a),
		.flash_ssram_tristate_bridge_data(flash_ssram_d),
		.mem_addr_from_the_altmemddr(ddr_addr),
		.mem_ba_from_the_altmemddr(ddr_ba),
		.mem_cas_n_from_the_altmemddr(ddr_cas_n),
		.mem_cke_from_the_altmemddr(ddr_cke),
		.mem_clk_n_to_and_from_the_altmemddr(ddr_clk_n),
		.mem_clk_to_and_from_the_altmemddr(ddr_clk),
		.mem_cs_n_from_the_altmemddr(ddr_cs_n),
		.mem_dm_from_the_altmemddr(ddr_dm),
		.mem_dq_to_and_from_the_altmemddr(ddr_dq),
		.mem_dqs_to_and_from_the_altmemddr(ddr_dqs),
		.mem_ras_n_from_the_altmemddr(ddr_ras_n),
		.mem_we_n_from_the_altmemddr(ddr_we_n),
		.out_port_from_the_led_pio(led),
		.outputenable_n_to_the_ext_ssram(ssram_oe_n),
		.read_n_to_the_ext_flash(flash_oe_n),
		.select_n_to_the_ext_flash(flash_cs_n),
		.write_n_to_the_ext_flash(flash_wr_n),
		.osc_clk(osc_clk),
		.global_reset_n_to_the_altmemddr(reset_n),
		.in_port_to_the_button_pio(button),
		.reset_n(reset_n),
		.ssram_clk(ssram_clk)
	);
endmodule
