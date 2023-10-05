//
// This Power Demo operates very simply as follows:
//
// The input clock i_clk PIN_B9 <or PIN_V9> is the 50 MHz oscillator on the Starter Kit board
//
// There are four input BUTTONs which control the Demo:
//
// Pressing BUTTON1 PIN_F1 resets the demo to the beginning, node i_nrst 
// Pressing BUTTON2 PIN_F2 advances the demo to the next higher frequency, node i_nfreq_next
// Pressing BUTTON3 PIN_A10 advances the demo to the next higher resource utilization, node i_nperc_next
// Pressing and HOLDING BUTTON4 PIN_B10 enables the outputs to toggle, node i_noutput_ena
//
// The LEDs indicate what state the Power Demo is currently demonstrating:
//
// LED0 o_nfreq_state[0] PIN_P13 is bit 0 of the frequency advance indicator.
// LED1 o_nfreq_state[1] PIN_P12 is bit 1 of the frequency advance indicator.
// LED2 o_nperc_state[0] PIN_N12 is bit 0 of the resource  advance indicator.
// LED3 o_nperc_state[1] PIN_N9  is bit 1 of the resource  advance indicator.
//
// Example: 
// LED0 ON
// LED1 OFF
// LED2 ON
// LED3 OFF
// BUTTON4 not pressed
//
// This indicates that the demo is at the first frequency, first resource level, no outputs driven 
//
//
// CURRENT MEASUREMENTS: 
// 
// Power down the board, remove Jumper JP6 and attach 
// a Digital Multi-Meter across the tow pins, 1 and 2. 
// Set the multi-meter on current to read in milliamps (mA) scale.
// Power up the board and begin advancing through the various BUTTON2, BUTTON3 options.
// Notice how current increases as frequency and resources increase.
// Press and hold down BUTTON4 to enable the output pins on the HSMC connector J1
// This further increases power for each resource utilization percentage used by the Cyclone III FPGA
//
// The number of outputs can be adjusted by changing parameter NUM_OUTPUTS_PER_STAMP 
// The default is 19, which for 4 resource percentage steps equates to 19 x 4 = 76
// The appropriate pins to be used as outputs are pre-assigned to the HSMC connector J1 
// If one desires more than 19 outputs, appropriate pin assignments will need to be entered
//
// Current (and power) should be linear with frequency and % resources.
// If current measurements are sublinear there may be voltage drop across the current meter.
// If current measurements are superlinear then try taking measurements faster to minimize the
// increasing static leakage with temperature
//

module cycloneIII_3c25_start_power_top (
	i_clk,
	i_nrst,
	i_nfreq_next,
	o_nfreq_state,
	i_nperc_next,
	o_nperc_state,
	i_noutput_ena,
	o_outputs
	);

// Change NUM_STAMPS to < 4 for CIII and SII and 3 for CII 2C35
parameter NUM_STAMPS = 4;
parameter NUM_OUTPUTS_PER_STAMP = 16;

input i_clk;
input i_nrst;
input i_nfreq_next;
output [1:0] o_nfreq_state;
input i_nperc_next;
output [1:0] o_nperc_state;
input i_noutput_ena;
output [NUM_OUTPUTS_PER_STAMP*NUM_STAMPS-1:0] o_outputs;

wire [NUM_OUTPUTS_PER_STAMP*NUM_STAMPS-1:0] int_outputs;
wire var_clk;
wire clk12_5;

wire rst = ~i_nrst;

reg [1:0] freq_state;
reg [1:0] perc_state;
reg [NUM_OUTPUTS_PER_STAMP*NUM_STAMPS-1:0] o_outputs;

wire freq_next_pulse;
wire perc_next_pulse;

wire xor_ena;

wire [3:0] stamp_out;

clk_gen cgen (.i_clk(i_clk),
			  .i_rst(rst),
			  .i_freq_state(freq_state),
			  .o_var_clk(var_clk),
			  .o_clk12_5(clk12_5));

pulse pfreq (.i_clk(clk12_5),
			 .i_rst(rst),
			 .i_in(~i_nfreq_next),
			 .o_out(freq_next_pulse));

always @(posedge clk12_5 or posedge rst)
begin
	if (rst) freq_state <= 0;
	else freq_state <= freq_state + freq_next_pulse;
end

pulse pperc (.i_clk(clk12_5),
			 .i_rst(rst),
			 .i_in(~i_nperc_next),
			 .o_out(perc_next_pulse));

always @(posedge clk12_5 or posedge rst)
begin
	if (rst) perc_state <= 0;
	else perc_state <= perc_state + perc_next_pulse;
end

pulse poe (.i_clk(clk12_5),
		   .i_rst(1'b0),
		   .i_in(rst),
           .o_out(xor_ena));

genvar i;

generate
	for (i=0; i < NUM_STAMPS; i=i+1)
	begin : STAMPGEN
		stamp stamp (.i_clk(var_clk),
					 .i_rst(rst),
					 .i_ena(perc_state >= i),
					 .i_xor_ena(xor_ena),
					 .i_output_ena(~i_noutput_ena),
					 .o_xor_out(stamp_out[i]),
					 .o_out(int_outputs[(i+1)*NUM_OUTPUTS_PER_STAMP-1:i*NUM_OUTPUTS_PER_STAMP]));
		defparam stamp.NUM_OUTPUTS = NUM_OUTPUTS_PER_STAMP;
	end
endgenerate

assign o_nfreq_state = ~(xor_ena ? {1'b0, ^stamp_out} : freq_state);
assign o_nperc_state = ~(xor_ena ? {1'b0, ^stamp_out} : perc_state);

always @(posedge var_clk or posedge rst)
begin
	if (rst) o_outputs <= 0;
	else o_outputs <= int_outputs;
end

endmodule
