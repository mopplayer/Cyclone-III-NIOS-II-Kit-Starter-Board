
module pulse (
	i_clk,
	i_rst,
	i_in,
	o_out);

input i_clk;
input i_rst;
input i_in;
output o_out;

reg [2:0] rin;

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) rin <= 0;
	else rin <= {rin[1:0], i_in};
end

assign o_out = rin[2] & ~rin[1];

endmodule
