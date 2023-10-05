// accelerator_mandelbrot_hw_draw_int_mandelbrot_managed_instance.v

// This file was auto-generated as part of a generation operation.
// If you edit it your changes will probably be lost.

`timescale 1 ps / 1 ps
module accelerator_mandelbrot_hw_draw_int_mandelbrot_managed_instance (
		input  wire        clk,                                                                           //                                                          clock.clk
		input  wire        reset_n,                                                                       //                                                    clock_reset.reset_n
		input  wire        cpu_clk,                                                                       //                                                      cpu_clock.clk
		input  wire        cpu_reset_n,                                                                   //                                                cpu_clock_reset.reset_n
		output wire [31:0] cpu_readdata0,                                                                 //                                    sub_hw_draw_int_mandelbrot0.readdata
		input  wire        hw_draw_int_mandelbrot_select0,                                                //                                                               .chipselect
		input  wire        hw_draw_int_mandelbrot_read0,                                                  //                                                               .read
		output wire        hw_draw_int_mandelbrot_waitrequest_n0,                                         //                                                               .waitrequest_n
		input  wire        hw_draw_int_mandelbrot_begin0,                                                 //                                                               .begintransfer
		output wire [3:0]  accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0,    // accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1.byteenable
		output wire [31:0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0,     //                                                               .writedata
		input  wire        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0, //                                                               .waitrequest_n
		output wire        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0,         //                                                               .write
		output wire [31:0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0,       //                                                               .address
		output wire [31:0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0,       // accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0.address
		output wire        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0,         //                                                               .flush
		input  wire        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0, //                                                               .readdatavalid
		input  wire        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0, //                                                               .waitrequest_n
		input  wire [31:0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0,      //                                                               .readdata
		output wire        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0,          //                                                               .read
		output wire [31:0] cpu_readdata1,                                                                 //                                                 cpu_interface0.readdata
		input  wire [31:0] cpu_writedata0,                                                                //                                                               .writedata
		output wire        cpu_waitrequest_n0,                                                            //                                                               .waitrequest_n
		input  wire [3:0]  cpu_address0,                                                                  //                                                               .address
		input  wire        cpu_write0,                                                                    //                                                               .write
		input  wire        cpu_select0,                                                                   //                                                               .chipselect
		output wire        cpu_irq0,                                                                      //                                        cpu_interface0_cpu_irq0.irq
		input  wire [31:0] slave_readdata0,                                                               //                                               internal_master0.readdata
		output wire [31:0] slave_address0,                                                                //                                                               .address
		output wire        slave_read0,                                                                   //                                                               .read
		input  wire        slave_waitrequest_n0,                                                          //                                                               .waitrequest_n
		output wire        dummy_master_write,                                                            //                                                   dummy_master.write
		output wire [31:0] dummy_master_writedata,                                                        //                                                               .writedata
		output wire [31:0] dummy_master_address,                                                          //                                                               .address
		input  wire        dummy_master_waitrequest,                                                      //                                                               .waitrequest
		input  wire        dummy_slave_chipselect,                                                        //                                                    dummy_slave.chipselect
		input  wire        dummy_slave_address,                                                           //                                                               .address
		output wire [31:0] dummy_slave_readdata                                                           //                                                               .readdata
	);

	accelerator_mandelbrot_hw_draw_int_mandelbrot accelerator_mandelbrot_hw_draw_int_mandelbrot_managed_instance (
		.clk                                                                           (clk),                                                                           //                                                          clock.clk
		.reset_n                                                                       (reset_n),                                                                       //                                                    clock_reset.reset_n
		.cpu_clk                                                                       (cpu_clk),                                                                       //                                                      cpu_clock.clk
		.cpu_reset_n                                                                   (cpu_reset_n),                                                                   //                                                cpu_clock_reset.reset_n
		.cpu_readdata0                                                                 (cpu_readdata0),                                                                 //                                    sub_hw_draw_int_mandelbrot0.readdata
		.hw_draw_int_mandelbrot_select0                                                (hw_draw_int_mandelbrot_select0),                                                //                                                               .chipselect
		.hw_draw_int_mandelbrot_read0                                                  (hw_draw_int_mandelbrot_read0),                                                  //                                                               .read
		.hw_draw_int_mandelbrot_waitrequest_n0                                         (hw_draw_int_mandelbrot_waitrequest_n0),                                         //                                                               .waitrequest_n
		.hw_draw_int_mandelbrot_begin0                                                 (hw_draw_int_mandelbrot_begin0),                                                 //                                                               .begintransfer
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0    (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0),    // accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1.byteenable
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0),     //                                                               .writedata
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0), //                                                               .waitrequest_n
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0),         //                                                               .write
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0       (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0),       //                                                               .address
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0       (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0),       // accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0.address
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0),         //                                                               .flush
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0), //                                                               .readdatavalid
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0), //                                                               .waitrequest_n
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0      (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0),      //                                                               .readdata
		.accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0),          //                                                               .read
		.cpu_readdata1                                                                 (cpu_readdata1),                                                                 //                                                 cpu_interface0.readdata
		.cpu_writedata0                                                                (cpu_writedata0),                                                                //                                                               .writedata
		.cpu_waitrequest_n0                                                            (cpu_waitrequest_n0),                                                            //                                                               .waitrequest_n
		.cpu_address0                                                                  (cpu_address0),                                                                  //                                                               .address
		.cpu_write0                                                                    (cpu_write0),                                                                    //                                                               .write
		.cpu_select0                                                                   (cpu_select0),                                                                   //                                                               .chipselect
		.cpu_irq0                                                                      (cpu_irq0),                                                                      //                                        cpu_interface0_cpu_irq0.irq
		.slave_readdata0                                                               (slave_readdata0),                                                               //                                               internal_master0.readdata
		.slave_address0                                                                (slave_address0),                                                                //                                                               .address
		.slave_read0                                                                   (slave_read0),                                                                   //                                                               .read
		.slave_waitrequest_n0                                                          (slave_waitrequest_n0),                                                          //                                                               .waitrequest_n
		.dummy_master_write                                                            (dummy_master_write),                                                            //                                                   dummy_master.write
		.dummy_master_writedata                                                        (dummy_master_writedata),                                                        //                                                               .writedata
		.dummy_master_address                                                          (dummy_master_address),                                                          //                                                               .address
		.dummy_master_waitrequest                                                      (dummy_master_waitrequest),                                                      //                                                               .waitrequest
		.dummy_slave_chipselect                                                        (dummy_slave_chipselect),                                                        //                                                    dummy_slave.chipselect
		.dummy_slave_address                                                           (dummy_slave_address),                                                           //                                                               .address
		.dummy_slave_readdata                                                          (dummy_slave_readdata)                                                           //                                                               .readdata
	);

endmodule
