// remote_update.v

// This file was auto-generated as part of a generation operation.
// If you edit it your changes will probably be lost.

`timescale 1 ps / 1 ps
module remote_update (
		input  wire        clk,         //       global_signals_clock.clk
		input  wire        reset,       // global_signals_clock_reset.reset
		input  wire [31:0] writedata,   //                         s1.writedata
		output wire [31:0] readdata,    //                           .readdata
		input  wire [5:0]  address,     //                           .address
		input  wire        chipselect,  //                           .chipselect
		input  wire        write,       //                           .write
		input  wire        read,        //                           .read
		output wire        waitrequest  //                           .waitrequest
	);

	altera_avalon_remote_update_cycloneiii remote_update (
		.clk         (clk),         //       global_signals_clock.clk
		.reset       (reset),       // global_signals_clock_reset.reset
		.writedata   (writedata),   //                         s1.writedata
		.readdata    (readdata),    //                           .readdata
		.address     (address),     //                           .address
		.chipselect  (chipselect),  //                           .chipselect
		.write       (write),       //                           .write
		.read        (read),        //                           .read
		.waitrequest (waitrequest)  //                           .waitrequest
	);

endmodule
