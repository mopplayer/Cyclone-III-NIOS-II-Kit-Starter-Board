// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altrea Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL or Verilog source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions: 
//
// --------------------------------------------------------------------
//
// Revision History :A code detector/generator for I2C slaves. This converts the incoming
//					 I2C signal into 1-cycle pulses indicating start condition, stop condition,	
//                   or received bit. Output data is latched on the falling edge of SCL.
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Joe Yang          :| 07/05/20  :|      Initial Revision
// -------------------------------------------------------------------- 
module Terasic_I2CBir_bus (

	input  clk, 
	input  reset,
	input  scl,
	inout  sda,
	inout  sda_o,

	output reg rx_start, 
	output reg rx_stop, 
	output reg rx_data, 
	output reg strobe,
	input tx_data,
	output reg sda_out,
	output reg [7:0] cnt,
	output ack,
	output reg w_r
	
);

	 


	/* Store the previous value of SDA and SCL, for edge detection */
	reg prev_sda, prev_scl;
	always @(posedge clk or posedge reset)
		if (reset) begin
			prev_sda <= 1;
			prev_scl <= 1;
		end
		else begin
			prev_sda <= sda;
			prev_scl <= scl;
		end
	
	/* Latch the SDA output on falling SCL edge */
	always @(posedge clk or posedge reset)
		if (reset)
			sda_out <= 1;
		else if (prev_scl && !scl)
			sda_out <= tx_data;

	/* Detect bus conditions */
	//reg rx_start, rx_stop, strobe, rx_data;
	always @(posedge clk or posedge reset)
		if (reset) begin
			rx_stop <= 0;
			rx_start <= 0;
			rx_data <= 0;
			strobe <= 0;
		end
		else begin
			// Start conditions: SCL is stable, SDA falls
			rx_start <= (scl && prev_scl && prev_sda && !sda);

			// Stop concitions: SCL is stable, SDA rises
			rx_stop <= ( scl && prev_scl && sda && !prev_sda);
			
			// A data bit is valid: SCL rises
			if (scl && !prev_scl) begin
				rx_data <= sda;
				strobe <= 1;
			end
			else begin
				strobe <= 0;
			end
		end
	
	/* I2C sample-counter trigger */
	wire tr = rx_start | rx_stop ;

	/* I2C sample-counter */
	always @(negedge scl or posedge tr)	begin 
		if   ( tr ) 
			cnt <= 0;
		else  if (cnt >=17 ) 
			cnt <= 9 ;
		else 
			cnt <= cnt + 1; 
	end

	/*I2C write-read command bit */
	reg pre_w_r ;
	
	always @(posedge tr or negedge scl )	begin 
		if  ( tr ) begin 
			pre_w_r <= 0;  
			w_r <= 0 ;
		end
		else begin 
			/*Current-sda save to pre_w_r */
			if ( cnt  == 8   ) pre_w_r <= sda;
			
			/*If is Ack    , to decide I2C bus write or read */
			if (( cnt == 9 ) && (sda==0)) w_r <= pre_w_r; 
			
			/*If is Non-Ack , to clear w_r ( I2C will be set to write ) */
			if (( cnt == 9 ) && (sda==1)) w_r  <=  0; 
			
		end
	end
	
	/* ack-interval : When I2C is write , I2C sample-counter count to ack-interval will be inverse(read )*/
	/* ack-interval : When I2C is read  , I2C sample-counter count to ack-interval will be inverse(write)*/
	assign   ack_interval =  (cnt == 9) ? 1 : 0;	

	/* w_r = 0 : I2C bus is write */
	/* w_r = 1 : I2C bus is read  */
	wire     i2c_rw         = ( !w_r )? ack_interval : ~ack_interval ;
	
	/* I2C bus_data write to Device */
	assign   sda_o          = (!i2c_rw )? ( ( sda )?1'b1:0 )  : 1'bz  ;	

	/* I2C bus_data read from Device */
	assign   sda            = ( i2c_rw )? sda_o : 1'bz;		



endmodule
