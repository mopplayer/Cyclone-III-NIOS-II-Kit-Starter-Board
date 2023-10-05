
// A Shift register with toggle-FF stimulus

module stamp_logic (
	i_clk,
	i_rst,
	i_ena,
	o_out);

input i_clk;
input i_rst;
input i_ena;
output o_out;

parameter NUM_REGS = 4096;

reg [NUM_REGS-1:0] cascade_chain;
reg toggle_reg;

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) toggle_reg <= 0;
	else if (i_ena) toggle_reg <= ~toggle_reg;
end

always @(posedge i_clk or posedge i_rst)
begin
	if (i_rst) cascade_chain <= 0;
	else if (i_ena) cascade_chain <= {cascade_chain[NUM_REGS-2:0], toggle_reg};
end

assign o_out = cascade_chain[NUM_REGS-1]; 



endmodule
