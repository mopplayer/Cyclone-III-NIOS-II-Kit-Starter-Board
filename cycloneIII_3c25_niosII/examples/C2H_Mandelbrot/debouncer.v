//Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module debouncer
(
	clk,
	reset_n,
	in_signal_n,
	out_signal
);

	parameter NUMBER_OF_INPUTS = 4;
	parameter PERIOD = 32768;
	parameter COUNTER_WIDTH = 16;

	input clk;
	input reset_n;
	input [NUMBER_OF_INPUTS-1:0] in_signal_n;

	wire [NUMBER_OF_INPUTS-1:0] out_signal;
	output [NUMBER_OF_INPUTS-1:0] out_signal;

	reg [COUNTER_WIDTH-1:0] counter [NUMBER_OF_INPUTS-1:0];
	reg filtered_result [NUMBER_OF_INPUTS-1:0];
	reg filtered_result_d1 [NUMBER_OF_INPUTS-1:0];
	reg filtered_result_d2 [NUMBER_OF_INPUTS-1:0];
	reg filtered_result_d3 [NUMBER_OF_INPUTS-1:0];

	wire period_reached [NUMBER_OF_INPUTS-1:0];

	genvar i;
	generate for(i = 0; i < NUMBER_OF_INPUTS; i = i + 1)
	begin: the_counter_block
		always @ (posedge clk or negedge reset_n)
		begin
			if (reset_n == 0)
			begin
				counter[i] <= 0;
			end
			else if (in_signal_n[i] == 1)
			begin
				counter[i] <= 0;  // button was pushed
			end
			else if(period_reached[i] == 0)
			begin
				counter[i] <= counter[i] + 1;  // keep counting
			end
			else
			begin
				counter[i] <= counter[i];  // all done, time to hold
			end
		end
	end
	endgenerate

   	generate for(i = 0; i < NUMBER_OF_INPUTS; i = i + 1)
	begin: the_output_pipeline_block
		always @ (posedge clk or negedge reset_n)
		begin 
			if(reset_n == 0)
			begin
				filtered_result[i] <= 0;
				filtered_result_d1[i] <= 0;
				filtered_result_d2[i] <= 0;
				filtered_result_d3[i] <= 0;
			end
			else
			begin  // detect if the counter hit the terminal value and pass it through 4 registers
				filtered_result[i] <= period_reached[i];
				filtered_result_d1[i] <= filtered_result[i];
				filtered_result_d2[i] <= filtered_result_d1[i];
				filtered_result_d3[i] <= filtered_result_d2[i];
			end
		end
	end
	endgenerate
	

   	generate for(i = 0; i < NUMBER_OF_INPUTS; i = i + 1)
	begin: the_edge_detect_block
	    assign period_reached[i] = (counter[i] == PERIOD);
		assign out_signal[i] = period_reached[i] & (!filtered_result_d3[i]); // rising edge detect pulse 4 clocks wide
	end
	endgenerate
endmodule
