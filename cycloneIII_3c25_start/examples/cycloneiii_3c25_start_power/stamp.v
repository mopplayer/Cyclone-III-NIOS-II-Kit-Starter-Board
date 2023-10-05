
module stamp (
	i_clk,
	i_rst,
	i_ena,
	i_xor_ena,
	i_output_ena,
	o_xor_out,
	o_out);

parameter NUM_OUTPUTS;

input i_clk;
input i_rst;
input i_ena;
input i_xor_ena;
input i_output_ena;
output o_xor_out;
output [NUM_OUTPUTS-1:0]o_out;

wire [128:0] outputs;
reg [NUM_OUTPUTS-1:0] outputs_reg;
reg [128:0] outputs_xor_reg;
reg o_xor_out;

reg [7:0]o_xor_out_bus; 
reg delay_bit_128; // delay reg

stamp_logic sl (.i_clk(i_clk),
				.i_rst(i_rst),
				.i_ena(i_ena),
				.o_out(outputs[128]));
defparam sl.NUM_REGS = 5120;

stamp_ram_dsp srd0 (.i_clk(i_clk),
					.i_rst(i_rst),
					.i_ena(i_ena),
					.o_out(outputs[31:0]));
defparam srd0.RAM_INIT_A = "randa.mif",
		 srd0.RAM_INIT_B = "randb.mif";

stamp_ram_dsp srd1 (.i_clk(i_clk),
					.i_rst(i_rst),
					.i_ena(i_ena),
					.o_out(outputs[63:32]));
defparam srd1.RAM_INIT_A = "randc.mif",
		 srd1.RAM_INIT_B = "randd.mif";

stamp_ram_dsp srd2 (.i_clk(i_clk),
					.i_rst(i_rst),
					.i_ena(i_ena),
					.o_out(outputs[95:64]));
defparam srd2.RAM_INIT_A = "rande.mif",
		 srd2.RAM_INIT_B = "randf.mif";

stamp_ram_dsp srd3 (.i_clk(i_clk),
					.i_rst(i_rst),
					.i_ena(i_ena),
					.o_out(outputs[127:96]));
defparam srd3.RAM_INIT_A = "randg.mif",
		 srd3.RAM_INIT_B = "randh.mif";

// Register all outputs using i_xor_ena as the enable
always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) outputs_xor_reg <= 0;
	else if (i_xor_ena) outputs_xor_reg <= outputs;
end

// XOR all the registered outputs so that we have one output
always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[0] <= 0;
	else  o_xor_out_bus[0] <= ^outputs_xor_reg[15:0];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[1] <= 0;
	else  o_xor_out_bus[1] <= ^outputs_xor_reg[31:16];
end
always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[2] <= 0;
	else  o_xor_out_bus[2] <= ^outputs_xor_reg[47:32];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[3] <= 0;
	else  o_xor_out_bus[3] <= ^outputs_xor_reg[63:48];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[4] <= 0;
	else  o_xor_out_bus[4] <= ^outputs_xor_reg[79:64];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[5] <= 0;
	else  o_xor_out_bus[5] <= ^outputs_xor_reg[95:80];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[6] <= 0;
	else  o_xor_out_bus[6] <= ^outputs_xor_reg[111:96];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out_bus[7] <= 0;
	else  o_xor_out_bus[7] <= ^outputs_xor_reg[127:112];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) delay_bit_128 <= 0;
	else delay_bit_128 <= outputs_xor_reg[128];
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) o_xor_out <= 0;
	else  o_xor_out <= (^o_xor_out_bus[7:0]) ^ delay_bit_128;
end


// Register NUM_OUTPUTS outputs using i_output_ena as the enable
always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) outputs_reg <= 0;
	else if (i_output_ena) outputs_reg <= outputs[NUM_OUTPUTS-1:0];
end

assign o_out = outputs_reg; 

endmodule
