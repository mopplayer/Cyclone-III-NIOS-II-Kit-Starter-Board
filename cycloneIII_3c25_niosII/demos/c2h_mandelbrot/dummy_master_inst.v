// dummy_master_inst.v

// This file was auto-generated as part of a generation operation.
// If you edit it your changes will probably be lost.

`timescale 1 ps / 1 ps
module dummy_master_inst (
		output wire [31:0] address,     //         m0.address
		output wire [31:0] writedata,   //           .writedata
		output wire        write,       //           .write
		input  wire        waitrequest  //           .waitrequest
	);

	dummy_master dummy_master_inst (
		.address     (address),     // m0.address
		.writedata   (writedata),   //   .writedata
		.write       (write),       //   .write
		.waitrequest (waitrequest)  //   .waitrequest
	);

endmodule
