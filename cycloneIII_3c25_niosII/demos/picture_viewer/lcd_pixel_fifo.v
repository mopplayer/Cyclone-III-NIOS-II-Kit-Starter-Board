//Legal Notice: (C)2012 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_pixel_fifo_dual_clock_fifo (
                                        // inputs:
                                         aclr,
                                         data,
                                         rdclk,
                                         rdreq,
                                         wrclk,
                                         wrreq,

                                        // outputs:
                                         q,
                                         rdempty,
                                         wrfull,
                                         wrusedw
                                      )
;

  output  [ 68: 0] q;
  output           rdempty;
  output           wrfull;
  output  [  6: 0] wrusedw;
  input            aclr;
  input   [ 68: 0] data;
  input            rdclk;
  input            rdreq;
  input            wrclk;
  input            wrreq;

  wire             int_wrfull;
  wire    [ 68: 0] q;
  wire             rdempty;
  wire             wrfull;
  wire    [  6: 0] wrusedw;
  assign wrfull = (wrusedw >= 128-3) | int_wrfull;
  dcfifo dual_clock_fifo
    (
      .aclr (aclr),
      .data (data),
      .q (q),
      .rdclk (rdclk),
      .rdempty (rdempty),
      .rdreq (rdreq),
      .wrclk (wrclk),
      .wrfull (int_wrfull),
      .wrreq (wrreq),
      .wrusedw (wrusedw)
    );

  defparam dual_clock_fifo.intended_device_family = "CYCLONEIII",
           dual_clock_fifo.lpm_numwords = 128,
           dual_clock_fifo.lpm_showahead = "OFF",
           dual_clock_fifo.lpm_type = "dcfifo",
           dual_clock_fifo.lpm_width = 69,
           dual_clock_fifo.lpm_widthu = 7,
           dual_clock_fifo.overflow_checking = "ON",
           dual_clock_fifo.rdsync_delaypipe = 4,
           dual_clock_fifo.underflow_checking = "ON",
           dual_clock_fifo.use_eab = "ON",
           dual_clock_fifo.wrsync_delaypipe = 4;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_pixel_fifo_dcfifo_with_controls (
                                             // inputs:
                                              data,
                                              rdclk,
                                              rdreq,
                                              wrclk,
                                              wrreq,
                                              wrreset_n,

                                             // outputs:
                                              q,
                                              rdempty,
                                              wrfull,
                                              wrlevel
                                           )
;

  output  [ 68: 0] q;
  output           rdempty;
  output           wrfull;
  output  [  7: 0] wrlevel;
  input   [ 68: 0] data;
  input            rdclk;
  input            rdreq;
  input            wrclk;
  input            wrreq;
  input            wrreset_n;

  wire    [ 68: 0] q;
  wire             rdempty;
  wire             wrfull;
  wire    [  7: 0] wrlevel;
  wire             wrreq_valid;
  wire    [  6: 0] wrusedw;
  //the_dcfifo, which is an e_instance
  lcd_pixel_fifo_dual_clock_fifo the_dcfifo
    (
      .aclr    (~wrreset_n),
      .data    (data),
      .q       (q),
      .rdclk   (rdclk),
      .rdempty (rdempty),
      .rdreq   (rdreq),
      .wrclk   (wrclk),
      .wrfull  (wrfull),
      .wrreq   (wrreq_valid),
      .wrusedw (wrusedw)
    );

  assign wrlevel = {1'b0,
    wrusedw};

  assign wrreq_valid = wrreq & ~wrfull;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module lcd_pixel_fifo (
                        // inputs:
                         avalonst_sink_data,
                         avalonst_sink_empty,
                         avalonst_sink_endofpacket,
                         avalonst_sink_startofpacket,
                         avalonst_sink_valid,
                         avalonst_source_ready,
                         rdclock,
                         rdreset_n,
                         wrclock,
                         wrreset_n,

                        // outputs:
                         avalonst_sink_ready,
                         avalonst_source_data,
                         avalonst_source_empty,
                         avalonst_source_endofpacket,
                         avalonst_source_startofpacket,
                         avalonst_source_valid
                      )
;

  output           avalonst_sink_ready;
  output  [ 63: 0] avalonst_source_data;
  output  [  2: 0] avalonst_source_empty;
  output           avalonst_source_endofpacket;
  output           avalonst_source_startofpacket;
  output           avalonst_source_valid;
  input   [ 63: 0] avalonst_sink_data;
  input   [  2: 0] avalonst_sink_empty;
  input            avalonst_sink_endofpacket;
  input            avalonst_sink_startofpacket;
  input            avalonst_sink_valid;
  input            avalonst_source_ready;
  input            rdclock;
  input            rdreset_n;
  input            wrclock;
  input            wrreset_n;

  wire             avalonst_sink_ready;
  wire    [ 68: 0] avalonst_sink_signals;
  wire    [ 63: 0] avalonst_source_data;
  wire    [  2: 0] avalonst_source_empty;
  wire             avalonst_source_endofpacket;
  wire    [ 68: 0] avalonst_source_signals;
  wire             avalonst_source_startofpacket;
  reg              avalonst_source_valid;
  wire    [ 68: 0] data;
  wire             no_stop_write;
  reg              no_stop_write_d1;
  wire    [ 68: 0] q;
  wire             rdclk;
  wire             rdempty;
  wire             rdreq;
  wire             rdreset_to_be_optimized;
  wire             ready_0;
  wire             ready_1;
  wire             ready_selector;
  wire             wrclk;
  wire             wrfull;
  wire    [  7: 0] wrlevel;
  wire             wrreq;
  assign rdreset_to_be_optimized = rdreset_n;
  //the_dcfifo_with_controls, which is an e_instance
  lcd_pixel_fifo_dcfifo_with_controls the_dcfifo_with_controls
    (
      .data      (data),
      .q         (q),
      .rdclk     (rdclk),
      .rdempty   (rdempty),
      .rdreq     (rdreq),
      .wrclk     (wrclk),
      .wrfull    (wrfull),
      .wrlevel   (wrlevel),
      .wrreq     (wrreq),
      .wrreset_n (wrreset_n)
    );

  //in, which is an e_atlantic_slave
  //out, which is an e_atlantic_master
  assign avalonst_sink_signals = {avalonst_sink_startofpacket,
    avalonst_sink_endofpacket,
    avalonst_sink_empty,
    avalonst_sink_data};

  assign {avalonst_source_startofpacket,
avalonst_source_endofpacket,
avalonst_source_empty,
avalonst_source_data} = avalonst_source_signals;
  assign no_stop_write = (ready_selector & ready_1) | (!ready_selector & ready_0);
  assign wrreq = avalonst_sink_valid & no_stop_write_d1;
  assign ready_1 = !wrfull;
  assign ready_0 = !wrfull & !avalonst_sink_valid;
  assign ready_selector = wrlevel < 124;
  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          no_stop_write_d1 <= 0;
      else 
        no_stop_write_d1 <= no_stop_write;
    end


  assign data = avalonst_sink_signals;
  assign avalonst_source_signals = q;
  assign wrclk = wrclock;
  assign rdclk = rdclock;
  assign avalonst_sink_ready = no_stop_write & no_stop_write_d1;
  always @(posedge rdclock or negedge rdreset_n)
    begin
      if (rdreset_n == 0)
          avalonst_source_valid <= 0;
      else 
        avalonst_source_valid <= avalonst_source_ready & !rdempty;
    end


  assign rdreq = avalonst_source_ready & !rdempty;

endmodule

