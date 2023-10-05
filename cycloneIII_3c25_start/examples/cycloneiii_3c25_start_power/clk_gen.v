
module clk_gen (
	i_clk,
	i_rst,
	i_freq_state,
	o_var_clk,
	o_clk12_5);

input i_clk;
input i_rst;
input [1:0] i_freq_state;
output o_var_clk;
output o_clk12_5;

wire clk100;
wire clk66;
wire clk33;
wire clk_zero;


pll pll (.inclk0(i_clk),
		 .areset(i_rst),
		 .c0(clk100), 
		 .c1(clk66),
		 .c2(clk33), 
		 .c3(o_clk12_5));
		
clk_mux clk_mux(.data0(clk_zero), // i_freq_state 00 = 0MHz
				.data1(clk33),    // i_freq_state 01 = 33MHz
				.data2(clk66),    // i_freq_state 10 = 66MHz
				.data3(clk100),   // i_freq_state 11 = 100MHz
				.sel(i_freq_state),
				.result(o_var_clk));		

assign clk_zero = 1'b0; // special case for 0 MHz

endmodule
