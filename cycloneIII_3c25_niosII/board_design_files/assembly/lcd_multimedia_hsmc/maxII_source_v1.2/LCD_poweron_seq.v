module LCD_poweron_seq (

						iCLK,
						iHC_GREST_n,
						iNCLK_decode,
						oGREST_n,
						oNCLK,
						);

//=======================================================
//  PORT declarations
//=======================================================
						
input			iCLK;						
input			iHC_GREST_n;
input			iNCLK_decode;	
output			oGREST_n;
output			oNCLK;
//=======================================================
//  PARAMETER declarations
//=======================================================

parameter RST_VALUE = 17'h18A60;

//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [17:0]	reset_cnt;
reg 		self_rst;
wire		oGREST_n;
reg	[1:0]   clk_cnt;

//=======================================================
//  Structural coding
//=======================================================

always@(posedge iCLK)
	begin
		if (reset_cnt == RST_VALUE)
			reset_cnt <= RST_VALUE;
		else	
			reset_cnt <= reset_cnt + 1;
	end

always@(posedge iCLK)
	begin
		if (reset_cnt == RST_VALUE)
			self_rst <= 1'b1;
		else
			self_rst <= 1'b0;
	end   	

always@(posedge iCLK)
	begin
		clk_cnt <= iCLK + 1;
	end  

assign 	oGREST_n = (reset_cnt == RST_VALUE) ? iHC_GREST_n : self_rst;
assign  oNCLK =  (reset_cnt == RST_VALUE) ? iNCLK_decode : clk_cnt[1];							
						
endmodule						