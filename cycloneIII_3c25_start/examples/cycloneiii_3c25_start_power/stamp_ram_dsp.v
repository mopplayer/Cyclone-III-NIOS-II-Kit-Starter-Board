
// Two ROMs with random data feeding a 32x32 multiply

module stamp_ram_dsp (
	i_clk,
	i_rst,
	i_ena,
	o_out);

input i_clk;
input i_rst;
input i_ena;
output [31:0] o_out;

wire [31:0] mult_out;
reg [31:0] o_out;

parameter RAM_INIT_A = "none";
parameter RAM_INIT_B = "none";

reg [13:0] counter;

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) counter <= 0;
	else if (i_ena) counter <= counter + 1'b1;
end

wire [31:0] romaq;
rom512x32 roma (.address(counter[8:0]),
				.clken(i_ena),
				.clock(i_clk),
				.q(romaq));
defparam roma.INIT_FILE = RAM_INIT_A;

reg [31:0] dataa;
always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) dataa <= 0;
	else if (i_ena) dataa <= romaq;
end

wire [31:0] rombq;
rom512x32 romb (.address(counter[13:5]),
				.clken(i_ena),
				.clock(i_clk),
				.q(rombq));
defparam romb.INIT_FILE = RAM_INIT_B;

reg [31:0] datab;
always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) datab <= 0;
	else if (i_ena) datab <= rombq;
end

always @(posedge i_clk or posedge i_rst) 
begin
	if (i_rst) o_out <= 0;
	else o_out <= mult_out;
end

mult32 mult (.aclr(i_rst),
			 .clken(i_ena),
			 .clock(i_clk),
			 .dataa(dataa),
			 .datab(datab),
			 .result(mult_out));

endmodule
