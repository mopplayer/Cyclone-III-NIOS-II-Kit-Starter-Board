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

// c_subroutine_block
//hw_mandelbrot.c (65): void hw_draw_int_mandelbrot(long long current_x, long long current_y, long long step_dim, int max_iter, unsigned long * restrict frame_buffer)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_subroutine_0 (
                                                                                                          // inputs:
                                                                                                           clk,
                                                                                                           hw_draw_int_mandelbrot_begin0,
                                                                                                           hw_draw_int_mandelbrot_read0,
                                                                                                           hw_draw_int_mandelbrot_select0,
                                                                                                           inhibit_from_c_do_block0,
                                                                                                           reset_n,

                                                                                                          // outputs:
                                                                                                           advance_to_hw_draw_int_mandelbrot_state0,
                                                                                                           enable_hw_draw_int_mandelbrot_state0,
                                                                                                           hw_draw_int_mandelbrot_state0
                                                                                                        )
;

  output  [  5: 0] advance_to_hw_draw_int_mandelbrot_state0;
  output  [  5: 0] enable_hw_draw_int_mandelbrot_state0;
  output  [  5: 0] hw_draw_int_mandelbrot_state0;
  input            clk;
  input            hw_draw_int_mandelbrot_begin0;
  input            hw_draw_int_mandelbrot_read0;
  input            hw_draw_int_mandelbrot_select0;
  input            inhibit_from_c_do_block0;
  input            reset_n;

  wire    [  5: 0] advance_to_hw_draw_int_mandelbrot_state0;
  wire             block_wide_enable0;
  wire    [  5: 0] enable_hw_draw_int_mandelbrot_state0;
  reg     [  5: 0] hw_draw_int_mandelbrot_state0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          hw_draw_int_mandelbrot_state0[0] <= 0;
      else if (enable_hw_draw_int_mandelbrot_state0[0])
          hw_draw_int_mandelbrot_state0[0] <= advance_to_hw_draw_int_mandelbrot_state0[0];
    end


  assign enable_hw_draw_int_mandelbrot_state0[0] = block_wide_enable0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          hw_draw_int_mandelbrot_state0[1] <= 0;
      else if (enable_hw_draw_int_mandelbrot_state0[1])
          hw_draw_int_mandelbrot_state0[1] <= advance_to_hw_draw_int_mandelbrot_state0[1];
    end


  assign enable_hw_draw_int_mandelbrot_state0[1] = block_wide_enable0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          hw_draw_int_mandelbrot_state0[2] <= 0;
      else if (enable_hw_draw_int_mandelbrot_state0[2])
          hw_draw_int_mandelbrot_state0[2] <= advance_to_hw_draw_int_mandelbrot_state0[2];
    end


  assign enable_hw_draw_int_mandelbrot_state0[2] = block_wide_enable0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          hw_draw_int_mandelbrot_state0[3] <= 0;
      else if (enable_hw_draw_int_mandelbrot_state0[3])
          hw_draw_int_mandelbrot_state0[3] <= advance_to_hw_draw_int_mandelbrot_state0[3];
    end


  assign enable_hw_draw_int_mandelbrot_state0[3] = block_wide_enable0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          hw_draw_int_mandelbrot_state0[4] <= 0;
      else if (enable_hw_draw_int_mandelbrot_state0[4])
          hw_draw_int_mandelbrot_state0[4] <= advance_to_hw_draw_int_mandelbrot_state0[4];
    end


  assign enable_hw_draw_int_mandelbrot_state0[4] = block_wide_enable0;
  assign enable_hw_draw_int_mandelbrot_state0[5] = block_wide_enable0;
  assign advance_to_hw_draw_int_mandelbrot_state0[0] = hw_draw_int_mandelbrot_read0 & hw_draw_int_mandelbrot_select0 & hw_draw_int_mandelbrot_begin0;
  //advance_to_hw_draw_int_mandelbrot_state0[1] assign, which is an e_assign
  assign advance_to_hw_draw_int_mandelbrot_state0[1] = hw_draw_int_mandelbrot_state0[0];

  //advance_to_hw_draw_int_mandelbrot_state0[2] assign, which is an e_assign
  assign advance_to_hw_draw_int_mandelbrot_state0[2] = hw_draw_int_mandelbrot_state0[1];

  //advance_to_hw_draw_int_mandelbrot_state0[3] assign, which is an e_assign
  assign advance_to_hw_draw_int_mandelbrot_state0[3] = hw_draw_int_mandelbrot_state0[2];

  //advance_to_hw_draw_int_mandelbrot_state0[4] assign, which is an e_assign
  assign advance_to_hw_draw_int_mandelbrot_state0[4] = hw_draw_int_mandelbrot_state0[3];

  //advance_to_hw_draw_int_mandelbrot_state0[5] assign, which is an e_assign
  assign advance_to_hw_draw_int_mandelbrot_state0[5] = hw_draw_int_mandelbrot_state0[4];

  //block_wide_enable0 inhibitor mux, which is an e_mux
  assign block_wide_enable0 = !inhibit_from_c_do_block0 &
    1;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

// c_subroutine_block
//hw_mandelbrot.c (128):   {
module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_0 (
                                                                                                  // inputs:
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0,
                                                                                                   accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0,
                                                                                                   advance_to_hw_draw_int_mandelbrot_state0,
                                                                                                   break13,
                                                                                                   break17,
                                                                                                   clk,
                                                                                                   enable_hw_draw_int_mandelbrot_state0,
                                                                                                   go_bit_control_output1,
                                                                                                   inhibit_from_c_do_block1,
                                                                                                   inhibit_from_c_do_block2,
                                                                                                   inhibit_from_c_do_block3,
                                                                                                   inhibit_from_c_do_block4,
                                                                                                   reset_n,

                                                                                                  // outputs:
                                                                                                   advance_to_state_do_4,
                                                                                                   enable_state_do_4,
                                                                                                   inhibit_from_c_do_block0,
                                                                                                   state_do_4
                                                                                                )
;

  output  [ 18: 0] advance_to_state_do_4;
  output  [ 18: 0] enable_state_do_4;
  output           inhibit_from_c_do_block0;
  output  [ 18: 0] state_do_4;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0;
  input   [  5: 0] advance_to_hw_draw_int_mandelbrot_state0;
  input   [ 31: 0] break13;
  input   [ 31: 0] break17;
  input            clk;
  input   [  5: 0] enable_hw_draw_int_mandelbrot_state0;
  input   [ 31: 0] go_bit_control_output1;
  input            inhibit_from_c_do_block1;
  input            inhibit_from_c_do_block2;
  input            inhibit_from_c_do_block3;
  input            inhibit_from_c_do_block4;
  input            reset_n;

  wire    [ 18: 0] advance_to_state_do_4;
  wire             block_wide_enable1;
  wire    [ 18: 0] enable_state_do_4;
  reg              inhibit_from_c_do_block0;
  reg     [ 18: 0] state_do_4;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[0] <= 0;
      else if (enable_state_do_4[0])
          state_do_4[0] <= advance_to_state_do_4[0];
    end


  assign enable_state_do_4[0] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[1] <= 0;
      else if (enable_state_do_4[1])
          state_do_4[1] <= advance_to_state_do_4[1];
    end


  assign enable_state_do_4[1] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[2] <= 0;
      else if (enable_state_do_4[2])
          state_do_4[2] <= advance_to_state_do_4[2];
    end


  assign enable_state_do_4[2] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[3] <= 0;
      else if (enable_state_do_4[3])
          state_do_4[3] <= advance_to_state_do_4[3];
    end


  assign enable_state_do_4[3] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[4] <= 0;
      else if (enable_state_do_4[4])
          state_do_4[4] <= advance_to_state_do_4[4];
    end


  assign enable_state_do_4[4] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[5] <= 0;
      else if (enable_state_do_4[5])
          state_do_4[5] <= advance_to_state_do_4[5];
    end


  assign enable_state_do_4[5] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[6] <= 0;
      else if (enable_state_do_4[6])
          state_do_4[6] <= advance_to_state_do_4[6];
    end


  assign enable_state_do_4[6] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[7] <= 0;
      else if (enable_state_do_4[7])
          state_do_4[7] <= advance_to_state_do_4[7];
    end


  assign enable_state_do_4[7] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[8] <= 0;
      else if (enable_state_do_4[8])
          state_do_4[8] <= advance_to_state_do_4[8];
    end


  assign enable_state_do_4[8] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[9] <= 0;
      else if (enable_state_do_4[9])
          state_do_4[9] <= advance_to_state_do_4[9];
    end


  assign enable_state_do_4[9] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[10] <= 0;
      else if (enable_state_do_4[10])
          state_do_4[10] <= advance_to_state_do_4[10];
    end


  assign enable_state_do_4[10] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[11] <= 0;
      else if (enable_state_do_4[11])
          state_do_4[11] <= advance_to_state_do_4[11];
    end


  assign enable_state_do_4[11] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[12] <= 0;
      else if (enable_state_do_4[12])
          state_do_4[12] <= advance_to_state_do_4[12];
    end


  assign enable_state_do_4[12] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[13] <= 0;
      else if (enable_state_do_4[13])
          state_do_4[13] <= advance_to_state_do_4[13];
    end


  assign enable_state_do_4[13] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[14] <= 0;
      else if (enable_state_do_4[14])
          state_do_4[14] <= advance_to_state_do_4[14];
    end


  assign enable_state_do_4[14] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[15] <= 0;
      else if (enable_state_do_4[15])
          state_do_4[15] <= advance_to_state_do_4[15];
    end


  assign enable_state_do_4[15] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[16] <= 0;
      else if (enable_state_do_4[16])
          state_do_4[16] <= advance_to_state_do_4[16];
    end


  assign enable_state_do_4[16] = block_wide_enable1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_4[17] <= 0;
      else if (enable_state_do_4[17])
          state_do_4[17] <= advance_to_state_do_4[17];
    end


  assign enable_state_do_4[17] = block_wide_enable1;
  assign enable_state_do_4[18] = block_wide_enable1;
  //advance_to_state_do_4[0] assign, which is an e_assign
  assign advance_to_state_do_4[0] = (enable_hw_draw_int_mandelbrot_state0[3] & advance_to_hw_draw_int_mandelbrot_state0[3]) & go_bit_control_output1 & !state_do_4[0];

  //advance_to_state_do_4[1] assign, which is an e_assign
  assign advance_to_state_do_4[1] = (state_do_4[0] | advance_to_state_do_4[5]) & !(|break13);

  //advance_to_state_do_4[2] assign, which is an e_assign
  assign advance_to_state_do_4[2] = (state_do_4[1]) & !(|break13);

  //advance_to_state_do_4[3] assign, which is an e_assign
  assign advance_to_state_do_4[3] = state_do_4[2];

  //advance_to_state_do_4[4] assign, which is an e_assign
  assign advance_to_state_do_4[4] = state_do_4[3];

  //advance_to_state_do_4[5] assign, which is an e_assign
  assign advance_to_state_do_4[5] = state_do_4[4];

  //advance_to_state_do_4[6] assign, which is an e_assign
  assign advance_to_state_do_4[6] = state_do_4[5];

  //advance_to_state_do_4[7] assign, which is an e_assign
  assign advance_to_state_do_4[7] = state_do_4[6];

  //advance_to_state_do_4[8] assign, which is an e_assign
  assign advance_to_state_do_4[8] = state_do_4[7];

  //advance_to_state_do_4[9] assign, which is an e_assign
  assign advance_to_state_do_4[9] = state_do_4[8];

  //advance_to_state_do_4[10] assign, which is an e_assign
  assign advance_to_state_do_4[10] = state_do_4[9];

  //advance_to_state_do_4[11] assign, which is an e_assign
  assign advance_to_state_do_4[11] = state_do_4[10];

  //advance_to_state_do_4[12] assign, which is an e_assign
  assign advance_to_state_do_4[12] = state_do_4[11];

  //advance_to_state_do_4[13] assign, which is an e_assign
  assign advance_to_state_do_4[13] = state_do_4[12];

  //advance_to_state_do_4[14] assign, which is an e_assign
  assign advance_to_state_do_4[14] = state_do_4[13];

  //advance_to_state_do_4[15] assign, which is an e_assign
  assign advance_to_state_do_4[15] = state_do_4[14];

  //advance_to_state_do_4[16] assign, which is an e_assign
  assign advance_to_state_do_4[16] = state_do_4[15];

  //advance_to_state_do_4[17] assign, which is an e_assign
  assign advance_to_state_do_4[17] = state_do_4[16];

  //advance_to_state_do_4[18] assign, which is an e_assign
  assign advance_to_state_do_4[18] = state_do_4[17];

  //on/inhibit register for c_do_block, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          inhibit_from_c_do_block0 <= 0;
      else if (break17 & (enable_state_do_4[18] & advance_to_state_do_4[18]))
          inhibit_from_c_do_block0 <= 0;
      else if (go_bit_control_output1 & (enable_hw_draw_int_mandelbrot_state0[3] & advance_to_hw_draw_int_mandelbrot_state0[3]))
          inhibit_from_c_do_block0 <= -1;
    end


  //block_wide_enable1 inhibitor mux, which is an e_mux
  assign block_wide_enable1 = ((~accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0 | ~(state_do_4[8]))) &
    ((~accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0 | ~(state_do_4[9]))) &
    ((~accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0 | ~(state_do_4[10]))) &
    ((~accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0 | ~(state_do_4[11]))) &
    !inhibit_from_c_do_block1 &
    !inhibit_from_c_do_block2 &
    !inhibit_from_c_do_block3 &
    !inhibit_from_c_do_block4 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0 &
    accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0 &
    1;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1 (
                                                                        // inputs:
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0,
                                                                         advance_to_state_do_4,
                                                                         clk,
                                                                         enable_state_do_4,
                                                                         go_bit_control_output21,
                                                                         go_bit_control_output26,
                                                                         go_bit_control_output27,
                                                                         go_bit_control_output28,
                                                                         reset_n,

                                                                        // outputs:
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0
                                                                      )
;

  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0;
  output  [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output21;
  input   [ 31: 0] go_bit_control_output26;
  input   [ 31: 0] go_bit_control_output27;
  input   [ 31: 0] go_bit_control_output28;
  input            reset_n;

  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address_mux_out0;
  reg     [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0;
  wire    [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable_mux_out0;
  wire    [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable_shifted0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata_mux_out0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address_mux_out0 = ({32 {(((enable_state_do_4[13] & advance_to_state_do_4[13]) & go_bit_control_output21[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2) |
    ({32 {(((enable_state_do_4[14] & advance_to_state_do_4[14]) & go_bit_control_output28[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2) |
    ({32 {(((enable_state_do_4[15] & advance_to_state_do_4[15]) & go_bit_control_output27[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2) |
    ({32 {(((enable_state_do_4[16] & advance_to_state_do_4[16]) & go_bit_control_output26[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2);

  //accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1 address register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0 <= 0;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address_mux_out0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata_mux_out0 = ({32 {(((enable_state_do_4[13] & advance_to_state_do_4[13]) & go_bit_control_output21[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0) |
    ({32 {(((enable_state_do_4[14] & advance_to_state_do_4[14]) & go_bit_control_output28[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0) |
    ({32 {(((enable_state_do_4[15] & advance_to_state_do_4[15]) & go_bit_control_output27[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0) |
    ({32 {(((enable_state_do_4[16] & advance_to_state_do_4[16]) & go_bit_control_output26[0]))}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0);

  //accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1 writedata register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0 <= 0;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata_mux_out0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0 | accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0 | accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0 | accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable_mux_out0 = ({4 {(((enable_state_do_4[13] & advance_to_state_do_4[13]) & go_bit_control_output21[0]))}} & 4'b1111) |
    ({4 {(((enable_state_do_4[14] & advance_to_state_do_4[14]) & go_bit_control_output28[0]))}} & 4'b1111) |
    ({4 {(((enable_state_do_4[15] & advance_to_state_do_4[15]) & go_bit_control_output27[0]))}} & 4'b1111) |
    ({4 {(((enable_state_do_4[16] & advance_to_state_do_4[16]) & go_bit_control_output26[0]))}} & 4'b1111);

  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable_shifted0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable_mux_out0;
  //accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1 byteenable register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0 <= 0;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable_shifted0;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0 (
                                                                        // inputs:
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0,
                                                                         advance_to_state_do_4,
                                                                         clk,
                                                                         enable_state_do_4,
                                                                         reset_n,

                                                                        // outputs:
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0,
                                                                         accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0
                                                                      )
;

  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input            reset_n;

  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address_mux_out0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_aclr0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_full0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_read0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_sclr0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address_mux_out0 = ({32 {(enable_state_do_4[5] & advance_to_state_do_4[5])}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2) |
    ({32 {(enable_state_do_4[6] & advance_to_state_do_4[6])}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2) |
    ({32 {(enable_state_do_4[7] & advance_to_state_do_4[7])}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2) |
    ({32 {(enable_state_do_4[8] & advance_to_state_do_4[8])}} & accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2);

  //accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0 address register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0 <= 0;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address_mux_out0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_sclr0 = enable_state_do_4[0] & advance_to_state_do_4[0];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_aclr0 = ~reset_n;
  scfifo accelerator_mandelbrot_hw_draw_int_mandelbrot_shift_fifo0
    (
      .aclr (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_aclr0),
      .clock (clk),
      .data (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0),
      .empty (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0),
      .full (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_full0),
      .q (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out0),
      .rdreq (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_read0),
      .sclr (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_sclr0),
      .wrreq (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0)
    );

  defparam accelerator_mandelbrot_hw_draw_int_mandelbrot_shift_fifo0.lpm_numwords = 8,
           accelerator_mandelbrot_hw_draw_int_mandelbrot_shift_fifo0.lpm_showahead = "ON",
           accelerator_mandelbrot_hw_draw_int_mandelbrot_shift_fifo0.lpm_width = 32,
           accelerator_mandelbrot_hw_draw_int_mandelbrot_shift_fifo0.lpm_widthu = 3,
           accelerator_mandelbrot_hw_draw_int_mandelbrot_shift_fifo0.use_eab = "OFF";

  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0 = enable_state_do_4[0] & advance_to_state_do_4[0];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0 | accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0 | accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0 | accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_read0 = (enable_state_do_4[9] & advance_to_state_do_4[9]) | (enable_state_do_4[10] & advance_to_state_do_4[10]) | (enable_state_do_4[11] & advance_to_state_do_4[11]) | (enable_state_do_4[12] & advance_to_state_do_4[12]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out0;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

// c_subroutine_block
//hw_mandelbrot.c (130):       { long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_1 (
                                                                                                  // inputs:
                                                                                                   advance_to_state_do_4,
                                                                                                   break2,
                                                                                                   break3,
                                                                                                   clk,
                                                                                                   enable_state_do_4,
                                                                                                   go_bit_control_output3,
                                                                                                   reset_n,

                                                                                                  // outputs:
                                                                                                   advance_to_state_do_0,
                                                                                                   enable_state_do_0,
                                                                                                   inhibit_from_c_do_block1,
                                                                                                   state_do_0
                                                                                                )
;

  output  [  4: 0] advance_to_state_do_0;
  output  [  4: 0] enable_state_do_0;
  output           inhibit_from_c_do_block1;
  output  [  4: 0] state_do_0;
  input   [ 18: 0] advance_to_state_do_4;
  input   [ 31: 0] break2;
  input   [ 31: 0] break3;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output3;
  input            reset_n;

  wire    [  4: 0] advance_to_state_do_0;
  wire             block_wide_enable2;
  wire    [  4: 0] enable_state_do_0;
  reg              inhibit_from_c_do_block1;
  reg     [  4: 0] state_do_0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_0[0] <= 0;
      else if (enable_state_do_0[0])
          state_do_0[0] <= advance_to_state_do_0[0];
    end


  assign enable_state_do_0[0] = block_wide_enable2;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_0[1] <= 0;
      else if (enable_state_do_0[1])
          state_do_0[1] <= advance_to_state_do_0[1];
    end


  assign enable_state_do_0[1] = block_wide_enable2;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_0[2] <= 0;
      else if (enable_state_do_0[2])
          state_do_0[2] <= advance_to_state_do_0[2];
    end


  assign enable_state_do_0[2] = block_wide_enable2;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_0[3] <= 0;
      else if (enable_state_do_0[3])
          state_do_0[3] <= advance_to_state_do_0[3];
    end


  assign enable_state_do_0[3] = block_wide_enable2;
  assign enable_state_do_0[4] = block_wide_enable2;
  //advance_to_state_do_0[0] assign, which is an e_assign
  assign advance_to_state_do_0[0] = (enable_state_do_4[3] & advance_to_state_do_4[3]) & go_bit_control_output3 & !state_do_0[0];

  //advance_to_state_do_0[1] assign, which is an e_assign
  assign advance_to_state_do_0[1] = (state_do_0[0] | advance_to_state_do_0[4]) & !(|break2);

  //advance_to_state_do_0[2] assign, which is an e_assign
  assign advance_to_state_do_0[2] = (state_do_0[1]) & !(|break2);

  //advance_to_state_do_0[3] assign, which is an e_assign
  assign advance_to_state_do_0[3] = (state_do_0[2]) & !(|break2);

  //advance_to_state_do_0[4] assign, which is an e_assign
  assign advance_to_state_do_0[4] = state_do_0[3];

  //on/inhibit register for c_do_block, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          inhibit_from_c_do_block1 <= 0;
      else if (break3 & (enable_state_do_0[4] & advance_to_state_do_0[4]))
          inhibit_from_c_do_block1 <= 0;
      else if (go_bit_control_output3 & (enable_state_do_4[3] & advance_to_state_do_4[3]))
          inhibit_from_c_do_block1 <= -1;
    end


  //block_wide_enable2 inhibitor mux, which is an e_mux
  assign block_wide_enable2 = 1;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply0 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply0


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply1 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply1


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply2 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply2


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

// c_subroutine_block
//hw_mandelbrot.c (133):       { long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_2 (
                                                                                                  // inputs:
                                                                                                   advance_to_state_do_4,
                                                                                                   break5,
                                                                                                   break6,
                                                                                                   clk,
                                                                                                   enable_state_do_4,
                                                                                                   go_bit_control_output5,
                                                                                                   reset_n,

                                                                                                  // outputs:
                                                                                                   advance_to_state_do_1,
                                                                                                   enable_state_do_1,
                                                                                                   inhibit_from_c_do_block2,
                                                                                                   state_do_1
                                                                                                )
;

  output  [  4: 0] advance_to_state_do_1;
  output  [  4: 0] enable_state_do_1;
  output           inhibit_from_c_do_block2;
  output  [  4: 0] state_do_1;
  input   [ 18: 0] advance_to_state_do_4;
  input   [ 31: 0] break5;
  input   [ 31: 0] break6;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output5;
  input            reset_n;

  wire    [  4: 0] advance_to_state_do_1;
  wire             block_wide_enable3;
  wire    [  4: 0] enable_state_do_1;
  reg              inhibit_from_c_do_block2;
  reg     [  4: 0] state_do_1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_1[0] <= 0;
      else if (enable_state_do_1[0])
          state_do_1[0] <= advance_to_state_do_1[0];
    end


  assign enable_state_do_1[0] = block_wide_enable3;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_1[1] <= 0;
      else if (enable_state_do_1[1])
          state_do_1[1] <= advance_to_state_do_1[1];
    end


  assign enable_state_do_1[1] = block_wide_enable3;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_1[2] <= 0;
      else if (enable_state_do_1[2])
          state_do_1[2] <= advance_to_state_do_1[2];
    end


  assign enable_state_do_1[2] = block_wide_enable3;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_1[3] <= 0;
      else if (enable_state_do_1[3])
          state_do_1[3] <= advance_to_state_do_1[3];
    end


  assign enable_state_do_1[3] = block_wide_enable3;
  assign enable_state_do_1[4] = block_wide_enable3;
  //advance_to_state_do_1[0] assign, which is an e_assign
  assign advance_to_state_do_1[0] = (enable_state_do_4[3] & advance_to_state_do_4[3]) & go_bit_control_output5 & !state_do_1[0];

  //advance_to_state_do_1[1] assign, which is an e_assign
  assign advance_to_state_do_1[1] = (state_do_1[0] | advance_to_state_do_1[4]) & !(|break5);

  //advance_to_state_do_1[2] assign, which is an e_assign
  assign advance_to_state_do_1[2] = (state_do_1[1]) & !(|break5);

  //advance_to_state_do_1[3] assign, which is an e_assign
  assign advance_to_state_do_1[3] = (state_do_1[2]) & !(|break5);

  //advance_to_state_do_1[4] assign, which is an e_assign
  assign advance_to_state_do_1[4] = state_do_1[3];

  //on/inhibit register for c_do_block, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          inhibit_from_c_do_block2 <= 0;
      else if (break6 & (enable_state_do_1[4] & advance_to_state_do_1[4]))
          inhibit_from_c_do_block2 <= 0;
      else if (go_bit_control_output5 & (enable_state_do_4[3] & advance_to_state_do_4[3]))
          inhibit_from_c_do_block2 <= -1;
    end


  //block_wide_enable3 inhibitor mux, which is an e_mux
  assign block_wide_enable3 = 1;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply3 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply3


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply4 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply4


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply5 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply5


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

// c_subroutine_block
//hw_mandelbrot.c (136):       { long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_3 (
                                                                                                  // inputs:
                                                                                                   advance_to_state_do_4,
                                                                                                   break8,
                                                                                                   break9,
                                                                                                   clk,
                                                                                                   enable_state_do_4,
                                                                                                   go_bit_control_output7,
                                                                                                   reset_n,

                                                                                                  // outputs:
                                                                                                   advance_to_state_do_2,
                                                                                                   enable_state_do_2,
                                                                                                   inhibit_from_c_do_block3,
                                                                                                   state_do_2
                                                                                                )
;

  output  [  4: 0] advance_to_state_do_2;
  output  [  4: 0] enable_state_do_2;
  output           inhibit_from_c_do_block3;
  output  [  4: 0] state_do_2;
  input   [ 18: 0] advance_to_state_do_4;
  input   [ 31: 0] break8;
  input   [ 31: 0] break9;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output7;
  input            reset_n;

  wire    [  4: 0] advance_to_state_do_2;
  wire             block_wide_enable4;
  wire    [  4: 0] enable_state_do_2;
  reg              inhibit_from_c_do_block3;
  reg     [  4: 0] state_do_2;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_2[0] <= 0;
      else if (enable_state_do_2[0])
          state_do_2[0] <= advance_to_state_do_2[0];
    end


  assign enable_state_do_2[0] = block_wide_enable4;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_2[1] <= 0;
      else if (enable_state_do_2[1])
          state_do_2[1] <= advance_to_state_do_2[1];
    end


  assign enable_state_do_2[1] = block_wide_enable4;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_2[2] <= 0;
      else if (enable_state_do_2[2])
          state_do_2[2] <= advance_to_state_do_2[2];
    end


  assign enable_state_do_2[2] = block_wide_enable4;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_2[3] <= 0;
      else if (enable_state_do_2[3])
          state_do_2[3] <= advance_to_state_do_2[3];
    end


  assign enable_state_do_2[3] = block_wide_enable4;
  assign enable_state_do_2[4] = block_wide_enable4;
  //advance_to_state_do_2[0] assign, which is an e_assign
  assign advance_to_state_do_2[0] = (enable_state_do_4[3] & advance_to_state_do_4[3]) & go_bit_control_output7 & !state_do_2[0];

  //advance_to_state_do_2[1] assign, which is an e_assign
  assign advance_to_state_do_2[1] = (state_do_2[0] | advance_to_state_do_2[4]) & !(|break8);

  //advance_to_state_do_2[2] assign, which is an e_assign
  assign advance_to_state_do_2[2] = (state_do_2[1]) & !(|break8);

  //advance_to_state_do_2[3] assign, which is an e_assign
  assign advance_to_state_do_2[3] = (state_do_2[2]) & !(|break8);

  //advance_to_state_do_2[4] assign, which is an e_assign
  assign advance_to_state_do_2[4] = state_do_2[3];

  //on/inhibit register for c_do_block, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          inhibit_from_c_do_block3 <= 0;
      else if (break9 & (enable_state_do_2[4] & advance_to_state_do_2[4]))
          inhibit_from_c_do_block3 <= 0;
      else if (go_bit_control_output7 & (enable_state_do_4[3] & advance_to_state_do_4[3]))
          inhibit_from_c_do_block3 <= -1;
    end


  //block_wide_enable4 inhibitor mux, which is an e_mux
  assign block_wide_enable4 = 1;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply6 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply6


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply7 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply7


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply8 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply8


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

// c_subroutine_block
//hw_mandelbrot.c (137):       { long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_4 (
                                                                                                  // inputs:
                                                                                                   advance_to_state_do_4,
                                                                                                   break11,
                                                                                                   break12,
                                                                                                   clk,
                                                                                                   enable_state_do_4,
                                                                                                   go_bit_control_output9,
                                                                                                   reset_n,

                                                                                                  // outputs:
                                                                                                   advance_to_state_do_3,
                                                                                                   enable_state_do_3,
                                                                                                   inhibit_from_c_do_block4,
                                                                                                   state_do_3
                                                                                                )
;

  output  [  4: 0] advance_to_state_do_3;
  output  [  4: 0] enable_state_do_3;
  output           inhibit_from_c_do_block4;
  output  [  4: 0] state_do_3;
  input   [ 18: 0] advance_to_state_do_4;
  input   [ 31: 0] break11;
  input   [ 31: 0] break12;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output9;
  input            reset_n;

  wire    [  4: 0] advance_to_state_do_3;
  wire             block_wide_enable5;
  wire    [  4: 0] enable_state_do_3;
  reg              inhibit_from_c_do_block4;
  reg     [  4: 0] state_do_3;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_3[0] <= 0;
      else if (enable_state_do_3[0])
          state_do_3[0] <= advance_to_state_do_3[0];
    end


  assign enable_state_do_3[0] = block_wide_enable5;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_3[1] <= 0;
      else if (enable_state_do_3[1])
          state_do_3[1] <= advance_to_state_do_3[1];
    end


  assign enable_state_do_3[1] = block_wide_enable5;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_3[2] <= 0;
      else if (enable_state_do_3[2])
          state_do_3[2] <= advance_to_state_do_3[2];
    end


  assign enable_state_do_3[2] = block_wide_enable5;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state_do_3[3] <= 0;
      else if (enable_state_do_3[3])
          state_do_3[3] <= advance_to_state_do_3[3];
    end


  assign enable_state_do_3[3] = block_wide_enable5;
  assign enable_state_do_3[4] = block_wide_enable5;
  //advance_to_state_do_3[0] assign, which is an e_assign
  assign advance_to_state_do_3[0] = (enable_state_do_4[3] & advance_to_state_do_4[3]) & go_bit_control_output9 & !state_do_3[0];

  //advance_to_state_do_3[1] assign, which is an e_assign
  assign advance_to_state_do_3[1] = (state_do_3[0] | advance_to_state_do_3[4]) & !(|break11);

  //advance_to_state_do_3[2] assign, which is an e_assign
  assign advance_to_state_do_3[2] = (state_do_3[1]) & !(|break11);

  //advance_to_state_do_3[3] assign, which is an e_assign
  assign advance_to_state_do_3[3] = (state_do_3[2]) & !(|break11);

  //advance_to_state_do_3[4] assign, which is an e_assign
  assign advance_to_state_do_3[4] = state_do_3[3];

  //on/inhibit register for c_do_block, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          inhibit_from_c_do_block4 <= 0;
      else if (break12 & (enable_state_do_3[4] & advance_to_state_do_3[4]))
          inhibit_from_c_do_block4 <= 0;
      else if (go_bit_control_output9 & (enable_state_do_4[3] & advance_to_state_do_4[3]))
          inhibit_from_c_do_block4 <= -1;
    end


  //block_wide_enable5 inhibitor mux, which is an e_mux
  assign block_wide_enable5 = 1;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply9 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply9


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply10 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply10


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 


module accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply11 
       (
          // inputs:
          a,
          b,
          clk,
          enable,
          reset_n,

          // outputs:
          product
       );

   output [ 127 : 0 ] product;
   input  [ 63 : 0 ] a;
   input  [ 63 : 0 ] b;
   input             clk;
   input             enable;
   input             reset_n;

   wire  [ 127 : 0 ] product;
   reg  [ 63 : 0 ] a_reg;
   reg  [ 63 : 0 ] b_reg;

   assign product = $signed(a_reg) * $signed(b_reg);

   always @(posedge clk or negedge reset_n)
     begin
        if (reset_n == 0)
        begin
          a_reg <= 0;
          b_reg <= 0;
        end
        else if (enable)
        begin
          a_reg <= a;
          b_reg <= b;
       end
     end

endmodule // accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply11


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters0 == max_iter)? 0 : colour_lookup_table[iters0 & 0xFF];
//Connections: colour_lookup_table/s2(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_module0 (
                                                                                                                      // inputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0,
                                                                                                                       advance_to_state_do_4,
                                                                                                                       clk,
                                                                                                                       enable_state_do_4,
                                                                                                                       reset_n,

                                                                                                                      // outputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0
                                                                                                                    )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1;
  //read is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0 <= 0;
      else if (enable_state_do_4[5] & advance_to_state_do_4[5])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0 <= 0;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters1 == max_iter)? 0 : colour_lookup_table[iters1 & 0xFF];
//Connections: colour_lookup_table/s2(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_module0 (
                                                                                                                      // inputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0,
                                                                                                                       advance_to_state_do_4,
                                                                                                                       clk,
                                                                                                                       enable_state_do_4,
                                                                                                                       reset_n,

                                                                                                                      // outputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0
                                                                                                                    )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3;
  //read is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0 <= 0;
      else if (enable_state_do_4[6] & advance_to_state_do_4[6])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0 <= 0;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters2 == max_iter)? 0 : colour_lookup_table[iters2 & 0xFF];
//Connections: colour_lookup_table/s2(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_module0 (
                                                                                                                      // inputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0,
                                                                                                                       advance_to_state_do_4,
                                                                                                                       clk,
                                                                                                                       enable_state_do_4,
                                                                                                                       reset_n,

                                                                                                                      // outputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0
                                                                                                                    )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3;
  //read is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0 <= 0;
      else if (enable_state_do_4[7] & advance_to_state_do_4[7])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0 <= 0;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters3 == max_iter)? 0 : colour_lookup_table[iters3 & 0xFF];
//Connections: colour_lookup_table/s2(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_module0 (
                                                                                                                      // inputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0,
                                                                                                                       advance_to_state_do_4,
                                                                                                                       clk,
                                                                                                                       enable_state_do_4,
                                                                                                                       reset_n,

                                                                                                                      // outputs:
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2,
                                                                                                                       accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0
                                                                                                                    )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 18: 0] enable_state_do_4;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3;
  //read is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0 <= 0;
      else if (enable_state_do_4[8] & advance_to_state_do_4[8])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0 <= 0;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters2 == max_iter)? 0 : colour_lookup_table[iters2 & 0xFF];
//Connections: frame_buffer_pipeline_bridge/s1(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_module0 (
                                                                                                 // inputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0,
                                                                                                  advance_to_state_do_4,
                                                                                                  clk,
                                                                                                  dereferenced_frame_buffer6,
                                                                                                  enable_state_do_4,
                                                                                                  go_bit_control_output21,
                                                                                                  reset_n,

                                                                                                 // outputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0
                                                                                               )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 31: 0] dereferenced_frame_buffer6;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output21;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1;
  //write is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0 <= 0;
      else if ((enable_state_do_4[13] & advance_to_state_do_4[13]) & go_bit_control_output21[0])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0 <= 0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0 = dereferenced_frame_buffer6;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters3 == max_iter)? 0 : colour_lookup_table[iters3 & 0xFF];
//Connections: frame_buffer_pipeline_bridge/s1(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_module0 (
                                                                                                 // inputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0,
                                                                                                  advance_to_state_do_4,
                                                                                                  clk,
                                                                                                  dereferenced_frame_buffer8,
                                                                                                  enable_state_do_4,
                                                                                                  go_bit_control_output28,
                                                                                                  reset_n,

                                                                                                 // outputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0
                                                                                               )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 31: 0] dereferenced_frame_buffer8;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output28;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3;
  //write is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0 <= 0;
      else if ((enable_state_do_4[14] & advance_to_state_do_4[14]) & go_bit_control_output28[0])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0 <= 0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0 = dereferenced_frame_buffer8;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters1 == max_iter)? 0 : colour_lookup_table[iters1 & 0xFF];
//Connections: frame_buffer_pipeline_bridge/s1(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_module0 (
                                                                                                 // inputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0,
                                                                                                  advance_to_state_do_4,
                                                                                                  clk,
                                                                                                  dereferenced_frame_buffer4,
                                                                                                  enable_state_do_4,
                                                                                                  go_bit_control_output27,
                                                                                                  reset_n,

                                                                                                 // outputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0
                                                                                               )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 31: 0] dereferenced_frame_buffer4;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output27;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3;
  //write is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0 <= 0;
      else if ((enable_state_do_4[15] & advance_to_state_do_4[15]) & go_bit_control_output27[0])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0 <= 0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0 = dereferenced_frame_buffer4;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//c_pointer_dereference module for hw_mandelbrot.c:
//*frame_buffer++ = (iters0 == max_iter)? 0 : colour_lookup_table[iters0 & 0xFF];
//Connections: frame_buffer_pipeline_bridge/s1(1)
module accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_module0 (
                                                                                                 // inputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0,
                                                                                                  advance_to_state_do_4,
                                                                                                  clk,
                                                                                                  dereferenced_frame_buffer9,
                                                                                                  enable_state_do_4,
                                                                                                  go_bit_control_output26,
                                                                                                  reset_n,

                                                                                                 // outputs:
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0,
                                                                                                  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0
                                                                                               )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0;
  input   [ 18: 0] advance_to_state_do_4;
  input            clk;
  input   [ 31: 0] dereferenced_frame_buffer9;
  input   [ 18: 0] enable_state_do_4;
  input   [ 31: 0] go_bit_control_output26;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2;
  reg              accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2 = accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3;
  //write is set by the previous state enable
  //and reset by no ~accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0 <= 0;
      else if ((enable_state_do_4[16] & advance_to_state_do_4[16]) & go_bit_control_output26[0])
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0 <= -1;
      else if (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0)
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0 <= 0;
    end


  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0 = dereferenced_frame_buffer9;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0 (
                                                                               // inputs:
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0,
                                                                                clk,
                                                                                hw_draw_int_mandelbrot_begin0,
                                                                                hw_draw_int_mandelbrot_functiondata0,
                                                                                hw_draw_int_mandelbrot_read0,
                                                                                hw_draw_int_mandelbrot_select0,
                                                                                reset_n,

                                                                               // outputs:
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0,
                                                                                accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0,
                                                                                cpu_readdata0,
                                                                                hw_draw_int_mandelbrot_waitrequest_n0
                                                                             )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0;
  output  [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0;
  output  [ 31: 0] cpu_readdata0;
  output           hw_draw_int_mandelbrot_waitrequest_n0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  input            clk;
  input            hw_draw_int_mandelbrot_begin0;
  input   [255: 0] hw_draw_int_mandelbrot_functiondata0;
  input            hw_draw_int_mandelbrot_read0;
  input            hw_draw_int_mandelbrot_select0;
  input            reset_n;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address1;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2;
  reg     [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0;
  wire    [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_res0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_op_a0;
  wire    [ 63: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_op_b0;
  wire    [127: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_res0;
  wire    [  5: 0] advance_to_hw_draw_int_mandelbrot_state0;
  wire    [  4: 0] advance_to_state_do_0;
  wire    [  4: 0] advance_to_state_do_1;
  wire    [  4: 0] advance_to_state_do_2;
  wire    [  4: 0] advance_to_state_do_3;
  wire    [ 18: 0] advance_to_state_do_4;
  wire    [ 31: 0] break0;
  wire    [ 31: 0] break1;
  wire    [ 31: 0] break10;
  reg     [ 31: 0] break11;
  wire    [ 31: 0] break12;
  reg     [ 31: 0] break13;
  reg     [ 31: 0] break14;
  reg     [ 31: 0] break15;
  reg     [ 31: 0] break16;
  wire    [ 31: 0] break17;
  reg     [ 31: 0] break2;
  wire    [ 31: 0] break3;
  wire    [ 31: 0] break4;
  reg     [ 31: 0] break5;
  wire    [ 31: 0] break6;
  wire    [ 31: 0] break7;
  reg     [ 31: 0] break8;
  wire    [ 31: 0] break9;
  wire    [ 31: 0] colour_lookup_table0;
  wire    [ 31: 0] column0;
  wire    [ 31: 0] column1;
  wire    [ 31: 0] column10;
  reg     [ 31: 0] column11;
  wire    [ 31: 0] column13;
  wire    [ 31: 0] column14;
  reg     [ 31: 0] column2;
  wire    [ 31: 0] column4;
  wire    [ 31: 0] column5;
  wire    [ 31: 0] column7;
  wire    [ 31: 0] column8;
  wire    [ 31: 0] column9;
  wire    [ 31: 0] column_init1;
  wire    [ 31: 0] continue0;
  wire    [ 31: 0] continue1;
  wire    [ 31: 0] continue2;
  wire    [ 31: 0] continue3;
  wire    [ 31: 0] continue4;
  wire    [ 31: 0] control_output_break1;
  wire    [ 31: 0] control_output_break3;
  wire    [ 31: 0] control_output_break5;
  wire    [ 31: 0] control_output_break7;
  wire    [ 31: 0] control_output_break9;
  wire    [ 31: 0] control_output_if1;
  wire    [ 31: 0] control_output_if11;
  wire    [ 31: 0] control_output_if3;
  wire    [ 31: 0] control_output_if5;
  wire    [ 31: 0] control_output_if7;
  wire    [ 31: 0] control_output_if9;
  wire    [ 31: 0] cpu_readdata0;
  wire    [ 63: 0] current_x0;
  wire    [ 63: 0] current_x0_copy0;
  wire    [ 63: 0] current_x0_copy1;
  wire    [ 63: 0] current_x0_copy10;
  reg     [ 63: 0] current_x0_copy11;
  reg     [ 63: 0] current_x0_copy12;
  wire    [ 63: 0] current_x0_copy14;
  wire    [ 63: 0] current_x0_copy15;
  reg     [ 63: 0] current_x0_copy2;
  wire    [ 63: 0] current_x0_copy4;
  wire    [ 63: 0] current_x0_copy5;
  wire    [ 63: 0] current_x0_copy7;
  wire    [ 63: 0] current_x0_copy8;
  wire    [ 63: 0] current_x0_copy9;
  wire    [ 63: 0] current_x0_copy_init1;
  wire    [ 63: 0] current_x1_copy0;
  reg     [ 63: 0] current_x1_copy1;
  wire    [ 63: 0] current_x1_copy10;
  reg     [ 63: 0] current_x1_copy11;
  reg     [ 63: 0] current_x1_copy12;
  wire    [ 63: 0] current_x1_copy14;
  wire    [ 63: 0] current_x1_copy15;
  reg     [ 63: 0] current_x1_copy2;
  wire    [ 63: 0] current_x1_copy4;
  reg     [ 63: 0] current_x1_copy5;
  wire    [ 63: 0] current_x1_copy7;
  wire    [ 63: 0] current_x1_copy8;
  wire    [ 63: 0] current_x1_copy9;
  wire    [ 63: 0] current_x1_copy_init1;
  wire    [ 63: 0] current_x2_copy0;
  reg     [ 63: 0] current_x2_copy1;
  wire    [ 63: 0] current_x2_copy10;
  reg     [ 63: 0] current_x2_copy11;
  reg     [ 63: 0] current_x2_copy12;
  wire    [ 63: 0] current_x2_copy14;
  wire    [ 63: 0] current_x2_copy15;
  reg     [ 63: 0] current_x2_copy2;
  wire    [ 63: 0] current_x2_copy4;
  reg     [ 63: 0] current_x2_copy5;
  wire    [ 63: 0] current_x2_copy7;
  wire    [ 63: 0] current_x2_copy8;
  wire    [ 63: 0] current_x2_copy9;
  wire    [ 63: 0] current_x2_copy_init1;
  wire    [ 63: 0] current_x3_copy0;
  reg     [ 63: 0] current_x3_copy1;
  wire    [ 63: 0] current_x3_copy10;
  reg     [ 63: 0] current_x3_copy11;
  reg     [ 63: 0] current_x3_copy12;
  wire    [ 63: 0] current_x3_copy14;
  wire    [ 63: 0] current_x3_copy15;
  reg     [ 63: 0] current_x3_copy2;
  wire    [ 63: 0] current_x3_copy4;
  reg     [ 63: 0] current_x3_copy5;
  wire    [ 63: 0] current_x3_copy7;
  wire    [ 63: 0] current_x3_copy8;
  wire    [ 63: 0] current_x3_copy9;
  wire    [ 63: 0] current_x3_copy_init1;
  wire    [ 63: 0] current_y0;
  wire    [ 63: 0] current_y_copy0;
  wire    [ 63: 0] current_y_copy1;
  wire    [ 63: 0] current_y_copy11;
  wire    [ 63: 0] current_y_copy12;
  reg     [ 63: 0] current_y_copy2;
  wire    [ 63: 0] current_y_copy4;
  wire    [ 63: 0] current_y_copy5;
  wire    [ 63: 0] current_y_copy6;
  wire    [ 63: 0] current_y_copy7;
  reg     [ 63: 0] current_y_copy8;
  reg     [ 63: 0] current_y_copy9;
  wire    [ 63: 0] current_y_copy_init1;
  reg     [ 31: 0] dereferenced_colour_lookup_table_iters0_p0xFF_p3;
  reg     [ 31: 0] dereferenced_colour_lookup_table_iters1_p0xFF_p3;
  reg     [ 31: 0] dereferenced_colour_lookup_table_iters2_p0xFF_p3;
  reg     [ 31: 0] dereferenced_colour_lookup_table_iters3_p0xFF_p3;
  reg     [ 31: 0] dereferenced_frame_buffer2;
  reg     [ 31: 0] dereferenced_frame_buffer4;
  reg     [ 31: 0] dereferenced_frame_buffer6;
  reg     [ 31: 0] dereferenced_frame_buffer8;
  reg     [ 31: 0] dereferenced_frame_buffer9;
  wire    [ 31: 0] dummy_if_signal1;
  wire    [ 31: 0] dummy_if_signal11;
  wire    [ 31: 0] dummy_if_signal3;
  wire    [ 31: 0] dummy_if_signal5;
  wire    [ 31: 0] dummy_if_signal7;
  wire    [ 31: 0] dummy_if_signal9;
  wire    [  5: 0] enable_hw_draw_int_mandelbrot_state0;
  wire    [  4: 0] enable_state_do_0;
  wire    [  4: 0] enable_state_do_1;
  wire    [  4: 0] enable_state_do_2;
  wire    [  4: 0] enable_state_do_3;
  wire    [ 18: 0] enable_state_do_4;
  reg     [ 31: 0] first_time_at_clock_13_state_do_5;
  reg     [ 31: 0] first_time_at_clock_2_state_do_1;
  reg     [ 31: 0] first_time_at_clock_2_state_do_10;
  reg     [ 31: 0] first_time_at_clock_2_state_do_4;
  reg     [ 31: 0] first_time_at_clock_2_state_do_7;
  reg     [ 31: 0] first_time_at_clock_3_state_do_5;
  wire    [ 31: 0] frame_buffer0;
  wire    [ 31: 0] frame_buffer10;
  reg     [ 31: 0] frame_buffer11;
  reg     [ 31: 0] frame_buffer12;
  reg     [ 31: 0] frame_buffer13;
  reg     [ 31: 0] frame_buffer14;
  reg     [ 31: 0] frame_buffer15;
  reg     [ 31: 0] frame_buffer16;
  reg     [ 31: 0] frame_buffer17;
  reg     [ 31: 0] frame_buffer18;
  reg     [ 31: 0] frame_buffer19;
  reg     [ 31: 0] frame_buffer2;
  wire    [ 31: 0] frame_buffer21;
  wire    [ 31: 0] frame_buffer22;
  reg     [ 31: 0] frame_buffer4;
  reg     [ 31: 0] frame_buffer6;
  reg     [ 31: 0] frame_buffer8;
  wire    [ 31: 0] frame_buffer9;
  wire    [ 31: 0] frame_buffer_init1;
  wire    [ 31: 0] go_bit_control_output1;
  wire    [ 31: 0] go_bit_control_output13;
  wire    [ 31: 0] go_bit_control_output17;
  wire    [ 31: 0] go_bit_control_output21;
  wire    [ 31: 0] go_bit_control_output25;
  reg     [ 31: 0] go_bit_control_output26;
  reg     [ 31: 0] go_bit_control_output27;
  reg     [ 31: 0] go_bit_control_output28;
  wire    [ 31: 0] go_bit_control_output3;
  wire    [ 31: 0] go_bit_control_output5;
  wire    [ 31: 0] go_bit_control_output7;
  wire    [ 31: 0] go_bit_control_output9;
  wire    [  5: 0] hw_draw_int_mandelbrot_state0;
  wire             hw_draw_int_mandelbrot_waitrequest_n0;
  wire    [ 31: 0] if0;
  reg     [ 31: 0] if1;
  reg     [ 31: 0] if10;
  reg     [ 31: 0] if11;
  wire    [ 31: 0] if12;
  reg     [ 31: 0] if13;
  reg     [ 31: 0] if14;
  wire    [ 31: 0] if15;
  reg     [ 31: 0] if16;
  reg     [ 31: 0] if17;
  reg     [ 31: 0] if18;
  reg     [ 31: 0] if19;
  reg     [ 31: 0] if2;
  reg     [ 31: 0] if20;
  reg     [ 31: 0] if21;
  wire    [ 31: 0] if3;
  reg     [ 31: 0] if4;
  reg     [ 31: 0] if5;
  wire    [ 31: 0] if6;
  reg     [ 31: 0] if7;
  reg     [ 31: 0] if8;
  wire    [ 31: 0] if9;
  wire             inhibit_from_c_do_block0;
  wire             inhibit_from_c_do_block1;
  wire             inhibit_from_c_do_block2;
  wire             inhibit_from_c_do_block3;
  wire             inhibit_from_c_do_block4;
  wire    [ 31: 0] iters0_init1;
  wire    [ 31: 0] iters1;
  reg     [ 31: 0] iters10;
  wire    [ 31: 0] iters12;
  wire    [ 31: 0] iters13;
  wire    [ 31: 0] iters14;
  reg     [ 31: 0] iters15;
  wire    [ 31: 0] iters16;
  wire    [ 31: 0] iters17;
  reg     [ 31: 0] iters18;
  wire    [ 31: 0] iters1_init1;
  wire    [ 31: 0] iters2;
  wire    [ 31: 0] iters20;
  wire    [ 31: 0] iters21;
  wire    [ 31: 0] iters22;
  reg     [ 31: 0] iters23;
  wire    [ 31: 0] iters24;
  wire    [ 31: 0] iters25;
  reg     [ 31: 0] iters26;
  wire    [ 31: 0] iters28;
  wire    [ 31: 0] iters29;
  wire    [ 31: 0] iters2_init1;
  wire    [ 31: 0] iters30;
  reg     [ 31: 0] iters31;
  wire    [ 31: 0] iters32;
  wire    [ 31: 0] iters33;
  reg     [ 31: 0] iters34;
  wire    [ 31: 0] iters36;
  wire    [ 31: 0] iters37;
  reg     [ 31: 0] iters38;
  reg     [ 31: 0] iters39;
  wire    [ 31: 0] iters3_init1;
  wire    [ 31: 0] iters4;
  reg     [ 31: 0] iters40;
  reg     [ 31: 0] iters41;
  reg     [ 31: 0] iters42;
  reg     [ 31: 0] iters43;
  reg     [ 31: 0] iters44;
  reg     [ 31: 0] iters45;
  reg     [ 31: 0] iters46;
  reg     [ 31: 0] iters47;
  reg     [ 31: 0] iters48;
  reg     [ 31: 0] iters49;
  wire    [ 31: 0] iters5;
  reg     [ 31: 0] iters50;
  reg     [ 31: 0] iters51;
  reg     [ 31: 0] iters52;
  reg     [ 31: 0] iters53;
  wire    [ 31: 0] iters55;
  wire    [ 31: 0] iters57;
  wire    [ 31: 0] iters59;
  wire    [ 31: 0] iters6;
  wire    [ 31: 0] iters61;
  wire    [ 31: 0] iters62;
  wire    [ 31: 0] iters63;
  wire    [ 31: 0] iters64;
  wire    [ 31: 0] iters65;
  reg     [ 31: 0] iters7;
  wire    [ 31: 0] iters8;
  wire    [ 31: 0] iters9;
  wire             lpm_mult_clken0;
  wire             lpm_mult_clken1;
  wire             lpm_mult_clken10;
  wire             lpm_mult_clken11;
  wire             lpm_mult_clken2;
  wire             lpm_mult_clken3;
  wire             lpm_mult_clken4;
  wire             lpm_mult_clken5;
  wire             lpm_mult_clken6;
  wire             lpm_mult_clken7;
  wire             lpm_mult_clken8;
  wire             lpm_mult_clken9;
  wire    [127: 0] lpm_multiply_result0;
  wire    [127: 0] lpm_multiply_result1;
  wire    [127: 0] lpm_multiply_result10;
  wire    [127: 0] lpm_multiply_result11;
  wire    [127: 0] lpm_multiply_result2;
  wire    [127: 0] lpm_multiply_result3;
  wire    [127: 0] lpm_multiply_result4;
  wire    [127: 0] lpm_multiply_result5;
  wire    [127: 0] lpm_multiply_result6;
  wire    [127: 0] lpm_multiply_result7;
  wire    [127: 0] lpm_multiply_result8;
  wire    [127: 0] lpm_multiply_result9;
  wire    [ 31: 0] max_iter0;
  reg     [ 63: 0] multiply1;
  reg     [ 63: 0] multiply11;
  reg     [ 63: 0] multiply13;
  reg     [ 63: 0] multiply15;
  reg     [ 63: 0] multiply17;
  reg     [ 63: 0] multiply19;
  reg     [ 63: 0] multiply21;
  reg     [ 63: 0] multiply23;
  reg     [ 63: 0] multiply3;
  reg     [ 63: 0] multiply5;
  reg     [ 63: 0] multiply7;
  reg     [ 63: 0] multiply9;
  wire    [ 63: 0] multiply_assignment0_op_a1;
  wire    [ 63: 0] multiply_assignment0_op_a2;
  wire    [ 63: 0] multiply_assignment0_op_b1;
  wire    [ 63: 0] multiply_assignment0_op_b2;
  wire    [127: 0] multiply_assignment0_prod0;
  wire    [ 63: 0] multiply_assignment10_op_a1;
  wire    [ 63: 0] multiply_assignment10_op_a2;
  wire    [ 63: 0] multiply_assignment10_op_b1;
  wire    [ 63: 0] multiply_assignment10_op_b2;
  wire    [127: 0] multiply_assignment10_prod0;
  wire    [ 63: 0] multiply_assignment11_op_a1;
  wire    [ 63: 0] multiply_assignment11_op_a2;
  wire    [ 63: 0] multiply_assignment11_op_b1;
  wire    [ 63: 0] multiply_assignment11_op_b2;
  wire    [127: 0] multiply_assignment11_prod0;
  wire    [ 63: 0] multiply_assignment1_op_a1;
  wire    [ 63: 0] multiply_assignment1_op_a2;
  wire    [ 63: 0] multiply_assignment1_op_b1;
  wire    [ 63: 0] multiply_assignment1_op_b2;
  wire    [127: 0] multiply_assignment1_prod0;
  wire    [ 63: 0] multiply_assignment2_op_a1;
  wire    [ 63: 0] multiply_assignment2_op_a2;
  wire    [ 63: 0] multiply_assignment2_op_b1;
  wire    [ 63: 0] multiply_assignment2_op_b2;
  wire    [127: 0] multiply_assignment2_prod0;
  wire    [ 63: 0] multiply_assignment3_op_a1;
  wire    [ 63: 0] multiply_assignment3_op_a2;
  wire    [ 63: 0] multiply_assignment3_op_b1;
  wire    [ 63: 0] multiply_assignment3_op_b2;
  wire    [127: 0] multiply_assignment3_prod0;
  wire    [ 63: 0] multiply_assignment4_op_a1;
  wire    [ 63: 0] multiply_assignment4_op_a2;
  wire    [ 63: 0] multiply_assignment4_op_b1;
  wire    [ 63: 0] multiply_assignment4_op_b2;
  wire    [127: 0] multiply_assignment4_prod0;
  wire    [ 63: 0] multiply_assignment5_op_a1;
  wire    [ 63: 0] multiply_assignment5_op_a2;
  wire    [ 63: 0] multiply_assignment5_op_b1;
  wire    [ 63: 0] multiply_assignment5_op_b2;
  wire    [127: 0] multiply_assignment5_prod0;
  wire    [ 63: 0] multiply_assignment6_op_a1;
  wire    [ 63: 0] multiply_assignment6_op_a2;
  wire    [ 63: 0] multiply_assignment6_op_b1;
  wire    [ 63: 0] multiply_assignment6_op_b2;
  wire    [127: 0] multiply_assignment6_prod0;
  wire    [ 63: 0] multiply_assignment7_op_a1;
  wire    [ 63: 0] multiply_assignment7_op_a2;
  wire    [ 63: 0] multiply_assignment7_op_b1;
  wire    [ 63: 0] multiply_assignment7_op_b2;
  wire    [127: 0] multiply_assignment7_prod0;
  wire    [ 63: 0] multiply_assignment8_op_a1;
  wire    [ 63: 0] multiply_assignment8_op_a2;
  wire    [ 63: 0] multiply_assignment8_op_b1;
  wire    [ 63: 0] multiply_assignment8_op_b2;
  wire    [127: 0] multiply_assignment8_prod0;
  wire    [ 63: 0] multiply_assignment9_op_a1;
  wire    [ 63: 0] multiply_assignment9_op_a2;
  wire    [ 63: 0] multiply_assignment9_op_b1;
  wire    [ 63: 0] multiply_assignment9_op_b2;
  wire    [127: 0] multiply_assignment9_prod0;
  wire    [ 31: 0] pixel0;
  wire    [ 31: 0] pixel1;
  reg     [ 31: 0] pixel2;
  wire    [ 31: 0] pixel3;
  wire    [ 31: 0] pixel4;
  reg     [ 31: 0] pixel5;
  wire    [ 31: 0] pixel7;
  wire    [ 31: 0] pixel8;
  wire    [ 31: 0] pixel_init1;
  wire    [ 31: 0] return0;
  wire    [ 31: 0] signal0;
  wire    [ 31: 0] signal1;
  wire    [ 63: 0] signal10;
  wire    [ 63: 0] signal11;
  wire    [ 31: 0] signal12;
  wire    [ 31: 0] signal13;
  wire    [ 63: 0] signal14;
  wire    [ 63: 0] signal15;
  wire    [ 31: 0] signal16;
  wire    [ 31: 0] signal17;
  wire    [ 63: 0] signal18;
  wire    [ 63: 0] signal19;
  wire    [ 31: 0] signal2;
  wire    [ 31: 0] signal20;
  wire    [ 31: 0] signal21;
  wire    [ 31: 0] signal22;
  wire    [ 31: 0] signal23;
  wire    [ 31: 0] signal24;
  wire    [ 31: 0] signal25;
  wire    [ 31: 0] signal26;
  wire    [ 31: 0] signal27;
  wire    [ 31: 0] signal28;
  wire    [ 31: 0] signal29;
  wire    [ 31: 0] signal3;
  wire    [ 31: 0] signal30;
  wire    [ 63: 0] signal31;
  wire    [ 63: 0] signal32;
  wire    [ 63: 0] signal33;
  wire    [ 31: 0] signal34;
  wire    [ 31: 0] signal35;
  wire    [ 63: 0] signal36;
  wire    [ 63: 0] signal37;
  wire    [ 63: 0] signal38;
  wire    [ 63: 0] signal39;
  wire    [ 31: 0] signal4;
  wire    [ 63: 0] signal40;
  wire    [ 31: 0] signal41;
  wire    [ 31: 0] signal42;
  wire    [ 63: 0] signal43;
  wire    [ 63: 0] signal44;
  wire    [ 63: 0] signal45;
  wire    [ 63: 0] signal46;
  wire    [ 63: 0] signal47;
  wire    [ 31: 0] signal48;
  wire    [ 31: 0] signal49;
  wire    [ 31: 0] signal5;
  wire    [ 63: 0] signal50;
  wire    [ 63: 0] signal51;
  wire    [ 63: 0] signal52;
  wire    [ 63: 0] signal53;
  wire    [ 63: 0] signal54;
  wire    [ 31: 0] signal55;
  wire    [ 31: 0] signal56;
  wire    [ 63: 0] signal57;
  wire    [ 63: 0] signal58;
  wire    [ 31: 0] signal59;
  wire    [ 63: 0] signal6;
  wire    [ 31: 0] signal60;
  wire    [ 31: 0] signal61;
  wire    [ 31: 0] signal62;
  wire    [ 63: 0] signal7;
  wire    [ 31: 0] signal8;
  wire    [ 31: 0] signal9;
  wire    [  4: 0] state_do_0;
  wire    [  4: 0] state_do_1;
  wire    [  4: 0] state_do_2;
  wire    [  4: 0] state_do_3;
  wire    [ 18: 0] state_do_4;
  wire    [ 63: 0] step_dim0;
  wire    [ 31: 0] subexp0;
  wire    [ 31: 0] subexp1;
  wire    [ 31: 0] subexp10;
  wire    [ 31: 0] subexp100;
  wire    [ 31: 0] subexp101;
  wire    [ 31: 0] subexp102;
  wire    [ 31: 0] subexp103;
  wire    [ 31: 0] subexp104;
  wire    [ 31: 0] subexp105;
  wire    [ 31: 0] subexp106;
  wire    [ 31: 0] subexp107;
  wire    [ 31: 0] subexp108;
  wire    [ 31: 0] subexp109;
  wire    [ 31: 0] subexp11;
  wire    [ 31: 0] subexp110;
  wire    [ 31: 0] subexp111;
  wire    [ 31: 0] subexp112;
  wire    [ 31: 0] subexp113;
  wire    [ 63: 0] subexp114;
  wire    [ 63: 0] subexp115;
  wire    [ 31: 0] subexp116;
  wire    [ 63: 0] subexp117;
  wire    [ 63: 0] subexp118;
  wire    [ 31: 0] subexp119;
  wire    [ 31: 0] subexp12;
  wire    [ 63: 0] subexp120;
  wire    [ 63: 0] subexp121;
  wire    [ 63: 0] subexp122;
  wire    [ 31: 0] subexp123;
  wire    [ 63: 0] subexp124;
  wire    [ 63: 0] subexp125;
  wire    [ 31: 0] subexp126;
  wire    [ 63: 0] subexp127;
  wire    [ 63: 0] subexp128;
  wire    [ 31: 0] subexp129;
  wire    [ 31: 0] subexp13;
  wire    [ 63: 0] subexp130;
  wire    [ 63: 0] subexp131;
  wire    [ 63: 0] subexp132;
  wire    [ 31: 0] subexp133;
  wire    [ 63: 0] subexp134;
  wire    [ 63: 0] subexp135;
  wire    [ 31: 0] subexp136;
  wire    [ 63: 0] subexp137;
  wire    [ 63: 0] subexp138;
  wire    [ 31: 0] subexp139;
  wire    [ 63: 0] subexp14;
  wire    [ 63: 0] subexp140;
  wire    [ 63: 0] subexp141;
  wire    [ 63: 0] subexp142;
  wire    [ 31: 0] subexp143;
  wire    [ 63: 0] subexp144;
  wire    [ 63: 0] subexp145;
  wire    [ 31: 0] subexp146;
  wire    [ 63: 0] subexp147;
  wire    [ 63: 0] subexp148;
  wire    [ 31: 0] subexp149;
  wire    [ 63: 0] subexp15;
  wire    [ 63: 0] subexp150;
  wire    [ 63: 0] subexp151;
  wire    [ 63: 0] subexp152;
  wire    [ 31: 0] subexp153;
  wire    [ 31: 0] subexp154;
  wire    [ 31: 0] subexp155;
  wire    [ 31: 0] subexp156;
  wire    [ 31: 0] subexp157;
  wire    [ 31: 0] subexp158;
  wire    [ 31: 0] subexp159;
  wire    [ 31: 0] subexp16;
  wire    [ 31: 0] subexp160;
  wire    [ 31: 0] subexp161;
  wire    [ 31: 0] subexp162;
  wire    [ 31: 0] subexp163;
  wire    [ 31: 0] subexp164;
  wire    [ 31: 0] subexp165;
  wire    [ 31: 0] subexp166;
  wire    [ 31: 0] subexp167;
  wire    [ 31: 0] subexp168;
  wire    [ 31: 0] subexp169;
  wire    [ 63: 0] subexp17;
  wire    [ 31: 0] subexp170;
  wire    [ 31: 0] subexp171;
  wire    [ 31: 0] subexp172;
  wire    [ 31: 0] subexp173;
  wire    [ 31: 0] subexp174;
  wire    [ 31: 0] subexp175;
  wire    [ 31: 0] subexp176;
  wire    [ 31: 0] subexp177;
  wire    [ 31: 0] subexp178;
  wire    [ 31: 0] subexp179;
  wire    [ 63: 0] subexp18;
  wire    [ 31: 0] subexp180;
  wire    [ 31: 0] subexp181;
  wire    [ 31: 0] subexp182;
  wire    [ 31: 0] subexp183;
  wire    [ 31: 0] subexp184;
  wire    [ 63: 0] subexp19;
  wire    [ 63: 0] subexp2;
  wire    [ 63: 0] subexp20;
  wire    [ 31: 0] subexp21;
  wire    [ 63: 0] subexp22;
  wire    [ 63: 0] subexp23;
  wire    [ 63: 0] subexp24;
  wire    [ 63: 0] subexp25;
  wire    [ 31: 0] subexp26;
  wire    [ 63: 0] subexp27;
  wire    [ 63: 0] subexp28;
  wire    [ 63: 0] subexp29;
  wire    [ 63: 0] subexp3;
  wire    [ 63: 0] subexp30;
  wire    [ 31: 0] subexp31;
  wire    [ 63: 0] subexp32;
  wire    [ 63: 0] subexp33;
  wire    [ 31: 0] subexp34;
  wire    [ 63: 0] subexp35;
  wire    [ 63: 0] subexp36;
  wire    [ 63: 0] subexp37;
  wire    [ 63: 0] subexp38;
  wire    [ 63: 0] subexp39;
  wire    [ 63: 0] subexp4;
  wire    [ 63: 0] subexp40;
  wire    [ 63: 0] subexp41;
  wire    [ 63: 0] subexp42;
  wire    [ 63: 0] subexp43;
  wire    [ 31: 0] subexp44;
  wire    [ 31: 0] subexp45;
  wire    [ 31: 0] subexp46;
  wire    [ 31: 0] subexp47;
  wire    [ 31: 0] subexp48;
  wire    [ 31: 0] subexp49;
  wire    [ 63: 0] subexp5;
  wire    [ 31: 0] subexp50;
  wire    [ 31: 0] subexp51;
  wire    [ 31: 0] subexp52;
  wire    [ 31: 0] subexp53;
  wire    [ 31: 0] subexp54;
  wire    [ 31: 0] subexp55;
  wire    [ 31: 0] subexp56;
  wire    [ 31: 0] subexp57;
  wire    [ 31: 0] subexp58;
  wire    [ 31: 0] subexp59;
  wire    [ 31: 0] subexp6;
  wire    [ 31: 0] subexp60;
  wire    [ 31: 0] subexp61;
  wire    [ 31: 0] subexp62;
  wire    [ 31: 0] subexp63;
  wire    [ 31: 0] subexp64;
  wire    [ 31: 0] subexp65;
  wire    [ 31: 0] subexp66;
  wire    [ 31: 0] subexp67;
  wire    [ 31: 0] subexp68;
  wire    [ 31: 0] subexp69;
  wire    [ 31: 0] subexp7;
  wire    [ 31: 0] subexp70;
  wire    [ 31: 0] subexp71;
  wire    [ 31: 0] subexp72;
  wire    [ 31: 0] subexp73;
  wire    [ 31: 0] subexp74;
  wire    [ 31: 0] subexp75;
  wire    [ 31: 0] subexp76;
  wire    [ 31: 0] subexp77;
  wire    [ 31: 0] subexp78;
  wire    [ 31: 0] subexp79;
  wire    [ 31: 0] subexp8;
  wire    [ 31: 0] subexp80;
  wire    [ 31: 0] subexp81;
  wire    [ 31: 0] subexp82;
  wire    [ 31: 0] subexp83;
  wire    [ 31: 0] subexp84;
  wire    [ 31: 0] subexp85;
  wire    [ 31: 0] subexp86;
  wire    [ 31: 0] subexp87;
  wire    [ 31: 0] subexp88;
  wire    [ 31: 0] subexp89;
  wire    [ 31: 0] subexp9;
  wire    [ 31: 0] subexp90;
  wire    [ 31: 0] subexp91;
  wire    [ 31: 0] subexp92;
  wire    [ 31: 0] subexp93;
  wire    [ 31: 0] subexp94;
  wire    [ 31: 0] subexp95;
  wire    [ 31: 0] subexp96;
  wire    [ 31: 0] subexp97;
  wire    [ 31: 0] subexp98;
  wire    [ 31: 0] subexp99;
  wire    [ 31: 0] x0;
  reg     [ 31: 0] x1;
  wire    [ 31: 0] x10;
  wire    [ 31: 0] x11;
  reg     [ 31: 0] x12;
  wire    [ 31: 0] x14;
  wire    [ 31: 0] x15;
  wire    [ 31: 0] x16;
  reg     [ 31: 0] x17;
  wire    [ 31: 0] x18;
  wire    [ 31: 0] x19;
  wire    [ 31: 0] x2;
  reg     [ 31: 0] x20;
  wire    [ 31: 0] x22;
  wire    [ 31: 0] x23;
  wire    [ 31: 0] x24;
  reg     [ 31: 0] x25;
  wire    [ 31: 0] x26;
  wire    [ 31: 0] x27;
  reg     [ 31: 0] x28;
  wire    [ 31: 0] x3;
  wire    [ 31: 0] x30;
  wire    [ 31: 0] x31;
  reg     [ 31: 0] x4;
  wire    [ 31: 0] x6;
  wire    [ 31: 0] x7;
  wire    [ 31: 0] x8;
  reg     [ 31: 0] x9;
  wire    [ 31: 0] x_init1;
  wire    [ 31: 0] x_init3;
  wire    [ 31: 0] x_init5;
  wire    [ 31: 0] x_init7;
  wire    [ 63: 0] xsqr0;
  wire    [ 63: 0] xsqr1;
  wire    [ 63: 0] xsqr10;
  wire    [ 63: 0] xsqr11;
  wire    [ 63: 0] xsqr12;
  wire    [ 63: 0] xsqr13;
  reg     [ 63: 0] xsqr14;
  wire    [ 63: 0] xsqr16;
  wire    [ 63: 0] xsqr17;
  wire    [ 63: 0] xsqr18;
  wire    [ 63: 0] xsqr19;
  reg     [ 63: 0] xsqr2;
  reg     [ 63: 0] xsqr20;
  wire    [ 63: 0] xsqr22;
  wire    [ 63: 0] xsqr23;
  reg     [ 63: 0] xsqr24;
  reg     [ 63: 0] xsqr25;
  reg     [ 63: 0] xsqr26;
  reg     [ 63: 0] xsqr27;
  wire    [ 63: 0] xsqr4;
  wire    [ 63: 0] xsqr5;
  wire    [ 63: 0] xsqr6;
  wire    [ 63: 0] xsqr7;
  reg     [ 63: 0] xsqr8;
  wire    [ 31: 0] y0;
  reg     [ 31: 0] y1;
  wire    [ 31: 0] y10;
  wire    [ 31: 0] y11;
  reg     [ 31: 0] y12;
  wire    [ 31: 0] y14;
  wire    [ 31: 0] y15;
  wire    [ 31: 0] y16;
  reg     [ 31: 0] y17;
  wire    [ 31: 0] y18;
  wire    [ 31: 0] y19;
  wire    [ 31: 0] y2;
  reg     [ 31: 0] y20;
  wire    [ 31: 0] y22;
  wire    [ 31: 0] y23;
  wire    [ 31: 0] y24;
  reg     [ 31: 0] y25;
  wire    [ 31: 0] y26;
  wire    [ 31: 0] y27;
  reg     [ 31: 0] y28;
  wire    [ 31: 0] y3;
  wire    [ 31: 0] y30;
  wire    [ 31: 0] y31;
  reg     [ 31: 0] y4;
  wire    [ 31: 0] y6;
  wire    [ 31: 0] y7;
  wire    [ 31: 0] y8;
  reg     [ 31: 0] y9;
  wire    [ 31: 0] y_init1;
  wire    [ 31: 0] y_init3;
  wire    [ 31: 0] y_init5;
  wire    [ 31: 0] y_init7;
  wire    [ 63: 0] ysqr0;
  wire    [ 63: 0] ysqr1;
  wire    [ 63: 0] ysqr10;
  wire    [ 63: 0] ysqr11;
  wire    [ 63: 0] ysqr12;
  wire    [ 63: 0] ysqr13;
  reg     [ 63: 0] ysqr14;
  wire    [ 63: 0] ysqr16;
  wire    [ 63: 0] ysqr17;
  wire    [ 63: 0] ysqr18;
  wire    [ 63: 0] ysqr19;
  reg     [ 63: 0] ysqr2;
  reg     [ 63: 0] ysqr20;
  wire    [ 63: 0] ysqr22;
  wire    [ 63: 0] ysqr23;
  reg     [ 63: 0] ysqr24;
  reg     [ 63: 0] ysqr25;
  reg     [ 63: 0] ysqr26;
  reg     [ 63: 0] ysqr27;
  wire    [ 63: 0] ysqr4;
  wire    [ 63: 0] ysqr5;
  wire    [ 63: 0] ysqr6;
  wire    [ 63: 0] ysqr7;
  reg     [ 63: 0] ysqr8;
  assign hw_draw_int_mandelbrot_waitrequest_n0 = enable_hw_draw_int_mandelbrot_state0[5] & advance_to_hw_draw_int_mandelbrot_state0[5];
  //c_subroutine_block
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_subroutine_0 accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_the_state_machine_subroutine_0
    (
      .advance_to_hw_draw_int_mandelbrot_state0 (advance_to_hw_draw_int_mandelbrot_state0),
      .clk                                      (clk),
      .enable_hw_draw_int_mandelbrot_state0     (enable_hw_draw_int_mandelbrot_state0),
      .hw_draw_int_mandelbrot_begin0            (hw_draw_int_mandelbrot_begin0),
      .hw_draw_int_mandelbrot_read0             (hw_draw_int_mandelbrot_read0),
      .hw_draw_int_mandelbrot_select0           (hw_draw_int_mandelbrot_select0),
      .hw_draw_int_mandelbrot_state0            (hw_draw_int_mandelbrot_state0),
      .inhibit_from_c_do_block0                 (inhibit_from_c_do_block0),
      .reset_n                                  (reset_n)
    );

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //long * restrict colour_lookup_table = (long *)0x4401c00;
  assign colour_lookup_table0 = 32'h4401c00;

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //column = 0;
  assign column1 = 32'd0;

  assign column0 = 32'd0;
  assign signal0 = 32'd384000;
  assign subexp0 = {~pixel1[31], pixel1[30 : 0]} < {~signal0[31], signal0[30 : 0]};
  assign subexp1 = subexp0 != 32'd0;
  assign control_output_if1 = subexp1;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //current_x0_copy = current_x;
  assign current_x0_copy1 = current_x0;

  assign signal1 = 32'd0;
  assign current_x0_copy0 = {{32{signal1[31]}}, signal1};
  assign signal2 = 32'd0;
  assign current_x1_copy0 = {{32{signal2[31]}}, signal2};
  assign signal3 = 32'd0;
  assign current_x2_copy0 = {{32{signal3[31]}}, signal3};
  assign signal4 = 32'd0;
  assign current_x3_copy0 = {{32{signal4[31]}}, signal4};
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //current_y_copy = current_y;
  assign current_y_copy1 = current_y0;

  assign signal5 = 32'd0;
  assign current_y_copy0 = {{32{signal5[31]}}, signal5};
  assign dummy_if_signal1 = if0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //void hw_draw_int_mandelbrot(long long current_x, long long current_y, long long step_dim, int max_iter, unsigned long * restrict frame_buffer)
  assign if0 = 32'd1;

  assign iters1 = 32'd0;
  assign iters2 = 32'd0;
  assign iters4 = 32'd0;
  assign iters5 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //for(pixel = 0; pixel < 384000; pixel = (pixel + 4))
  assign pixel1 = 32'd0;

  assign pixel0 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //void hw_draw_int_mandelbrot(long long current_x, long long current_y, long long step_dim, int max_iter, unsigned long * restrict frame_buffer)
  assign return0 = 32'd0;

  assign {current_x0,
current_y0,
step_dim0,
max_iter0,
frame_buffer0} = hw_draw_int_mandelbrot_functiondata0;
  assign subexp2 = current_x0 + step_dim0;
  assign subexp3 = current_x0 + {step_dim0[62 : 0], 1'h0};
  assign subexp4 = current_x0 + {step_dim0[62 : 0], 1'h0};
  assign subexp5 = subexp4 + step_dim0;
  assign subexp6 =  ! return0;
  assign subexp7 = control_output_if1 && subexp6;
  assign subexp8 = if1 && dummy_if_signal1;
  assign subexp9 =  ! return0;
  assign subexp10 = subexp9 && if2;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{
  assign go_bit_control_output1 = subexp10;

  //c_do_block
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_0 accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_the_state_machine_do_0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0                      (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0                      (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0                      (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0                      (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0                                          (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0),
      .advance_to_hw_draw_int_mandelbrot_state0                                                                            (advance_to_hw_draw_int_mandelbrot_state0),
      .advance_to_state_do_4                                                                                               (advance_to_state_do_4),
      .break13                                                                                                             (break13),
      .break17                                                                                                             (break17),
      .clk                                                                                                                 (clk),
      .enable_hw_draw_int_mandelbrot_state0                                                                                (enable_hw_draw_int_mandelbrot_state0),
      .enable_state_do_4                                                                                                   (enable_state_do_4),
      .go_bit_control_output1                                                                                              (go_bit_control_output1),
      .inhibit_from_c_do_block0                                                                                            (inhibit_from_c_do_block0),
      .inhibit_from_c_do_block1                                                                                            (inhibit_from_c_do_block1),
      .inhibit_from_c_do_block2                                                                                            (inhibit_from_c_do_block2),
      .inhibit_from_c_do_block3                                                                                            (inhibit_from_c_do_block3),
      .inhibit_from_c_do_block4                                                                                            (inhibit_from_c_do_block4),
      .reset_n                                                                                                             (reset_n),
      .state_do_4                                                                                                          (state_do_4)
    );

  assign column_init1 = column1;
  assign current_x0_copy_init1 = current_x0_copy1;
  assign current_x1_copy_init1 = current_x1_copy1;
  assign current_x2_copy_init1 = current_x2_copy1;
  assign current_x3_copy_init1 = current_x3_copy1;
  assign current_y_copy_init1 = current_y_copy1;
  assign frame_buffer_init1 = frame_buffer0;
  assign pixel_init1 = pixel1;
  accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0                        (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0                     (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0                  (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0                          (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0                      (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0),
      .advance_to_state_do_4                                                                          (advance_to_state_do_4),
      .clk                                                                                            (clk),
      .enable_state_do_4                                                                              (enable_state_do_4),
      .go_bit_control_output21                                                                        (go_bit_control_output21),
      .go_bit_control_output26                                                                        (go_bit_control_output26),
      .go_bit_control_output27                                                                        (go_bit_control_output27),
      .go_bit_control_output28                                                                        (go_bit_control_output28),
      .reset_n                                                                                        (reset_n)
    );

  accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0                                             (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0                                          (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_empty0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0                                    (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0                                               (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0                                                (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0                                            (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0                                       (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0                                       (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0),
      .advance_to_state_do_4                                                                                               (advance_to_state_do_4),
      .clk                                                                                                                 (clk),
      .enable_state_do_4                                                                                                   (enable_state_do_4),
      .reset_n                                                                                                             (reset_n)
    );

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{
  assign break0 = 32'd0;

  assign column10 = column9;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{
  assign continue0 = 32'd0;

  assign subexp11 = 32'd800 - 32'd4;
  assign subexp12 = column10 == subexp11;
  assign subexp13 = subexp12 != 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign control_output_if11 = subexp13;

  assign subexp14 = xsqr0 + ysqr0;
  assign signal6 = subexp14;
  assign signal7 = 64'h0400000000000000;
  assign subexp15 = {~signal6[63], signal6[62 : 0]} < {~signal7[63], signal7[62 : 0]};
  assign subexp16 = {~iters6[31], iters6[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal8 = subexp16;
  assign subexp17 = subexp15 && {{32{signal8[31]}}, signal8};
  assign signal9 = 32'd0;
  assign subexp18 = subexp17 != {{32{signal9[31]}}, signal9};
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign control_output_if3 = subexp18;

  assign subexp19 = xsqr6 + ysqr6;
  assign signal10 = subexp19;
  assign signal11 = 64'h0400000000000000;
  assign subexp20 = {~signal10[63], signal10[62 : 0]} < {~signal11[63], signal11[62 : 0]};
  assign subexp21 = {~iters14[31], iters14[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal12 = subexp21;
  assign subexp22 = subexp20 && {{32{signal12[31]}}, signal12};
  assign signal13 = 32'd0;
  assign subexp23 = subexp22 != {{32{signal13[31]}}, signal13};
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign control_output_if5 = subexp23;

  assign subexp24 = xsqr12 + ysqr12;
  assign signal14 = subexp24;
  assign signal15 = 64'h0400000000000000;
  assign subexp25 = {~signal14[63], signal14[62 : 0]} < {~signal15[63], signal15[62 : 0]};
  assign subexp26 = {~iters22[31], iters22[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal16 = subexp26;
  assign subexp27 = subexp25 && {{32{signal16[31]}}, signal16};
  assign signal17 = 32'd0;
  assign subexp28 = subexp27 != {{32{signal17[31]}}, signal17};
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign control_output_if7 = subexp28;

  assign subexp29 = xsqr18 + ysqr18;
  assign signal18 = subexp29;
  assign signal19 = 64'h0400000000000000;
  assign subexp30 = {~signal18[63], signal18[62 : 0]} < {~signal19[63], signal19[62 : 0]};
  assign subexp31 = {~iters30[31], iters30[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal20 = subexp31;
  assign subexp32 = subexp30 && {{32{signal20[31]}}, signal20};
  assign signal21 = 32'd0;
  assign subexp33 = subexp32 != {{32{signal21[31]}}, signal21};
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign control_output_if9 = subexp33;

  assign current_x0_copy10 = current_x0_copy9;
  assign current_x1_copy10 = current_x1_copy9;
  assign current_x2_copy10 = current_x2_copy9;
  assign current_x3_copy10 = current_x3_copy9;
  assign current_y_copy7 = current_y_copy6;
  assign frame_buffer10 = frame_buffer9;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign iters6 = 32'd0;

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign iters14 = 32'd0;

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign iters22 = 32'd0;

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign iters30 = 32'd0;

  assign pixel4 = pixel3;
  assign signal22 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign xsqr0 = {{32{signal22[31]}}, signal22};

  assign signal23 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign xsqr6 = {{32{signal23[31]}}, signal23};

  assign signal24 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign xsqr12 = {{32{signal24[31]}}, signal24};

  assign signal25 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign xsqr18 = {{32{signal25[31]}}, signal25};

  assign signal26 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign ysqr0 = {{32{signal26[31]}}, signal26};

  assign signal27 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign ysqr6 = {{32{signal27[31]}}, signal27};

  assign signal28 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign ysqr12 = {{32{signal28[31]}}, signal28};

  assign signal29 = 32'd0;
  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign ysqr18 = {{32{signal29[31]}}, signal29};

  assign subexp34 = column10 + 32'd4;
  assign subexp35 = current_x0_copy10 + {step_dim0[61 : 0], 2'h0};
  assign subexp36 = current_x1_copy10 + {step_dim0[61 : 0], 2'h0};
  assign subexp37 = current_x0 + step_dim0;
  assign subexp38 = current_x2_copy10 + {step_dim0[61 : 0], 2'h0};
  assign subexp39 = current_x0 + {step_dim0[62 : 0], 1'h0};
  assign subexp40 = current_x3_copy10 + {step_dim0[61 : 0], 2'h0};
  assign subexp41 = current_x0 + {step_dim0[62 : 0], 1'h0};
  assign subexp42 = subexp41 + step_dim0;
  assign subexp43 = current_y_copy7 - step_dim0;
  assign subexp44 = frame_buffer10 + 32'd4;
  assign subexp45 =  ! return0;
  assign subexp46 =  ! continue0;
  assign subexp47 =  ! break0;
  assign subexp48 = subexp46 && subexp47;
  assign subexp49 = subexp45 && subexp48;
  assign subexp50 = control_output_if3 && subexp49;
  assign subexp51 =  ! return0;
  assign subexp52 =  ! continue0;
  assign subexp53 =  ! break0;
  assign subexp54 = subexp52 && subexp53;
  assign subexp55 = subexp51 && subexp54;
  assign subexp56 = control_output_if5 && subexp55;
  assign subexp57 =  ! return0;
  assign subexp58 =  ! continue0;
  assign subexp59 =  ! break0;
  assign subexp60 = subexp58 && subexp59;
  assign subexp61 = subexp57 && subexp60;
  assign subexp62 = control_output_if7 && subexp61;
  assign subexp63 =  ! return0;
  assign subexp64 =  ! continue0;
  assign subexp65 =  ! break0;
  assign subexp66 = subexp64 && subexp65;
  assign subexp67 = subexp63 && subexp66;
  assign subexp68 = control_output_if11 && subexp67;
  assign subexp69 =  ! return0;
  assign subexp70 =  ! continue0;
  assign subexp71 =  ! break0;
  assign subexp72 = subexp70 && subexp71;
  assign subexp73 = subexp69 && subexp72;
  assign subexp74 = control_output_if9 && subexp73;
  assign subexp75 = pixel4 + 32'd4;
  // e_assignment on clock 1 for hw_mandelbrot.c:
  //column = 0;
  assign column5 = 32'd0;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign column8 = if16 ? column7 : column4;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign column4 = column2;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign column7 = column5;

  assign signal30 = 32'd384000;
  assign subexp76 = {~pixel2[31], pixel2[30 : 0]} < {~signal30[31], signal30[30 : 0]};
  assign subexp77 = subexp76 == 32'd0;
  // e_assignment on clock 1 for hw_mandelbrot.c:
  //{
  assign control_output_break9 = subexp77;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //current_x0_copy = current_x;
  assign current_x0_copy5 = current_x0;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x0_copy8 = if16 ? current_x0_copy7 : current_x0_copy4;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x0_copy4 = current_x0_copy2;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x0_copy7 = current_x0_copy5;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x1_copy8 = if16 ? current_x1_copy7 : current_x1_copy4;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x1_copy4 = current_x1_copy2;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x1_copy7 = current_x1_copy5;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x2_copy8 = if16 ? current_x2_copy7 : current_x2_copy4;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x2_copy4 = current_x2_copy2;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x2_copy7 = current_x2_copy5;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x3_copy8 = if16 ? current_x3_copy7 : current_x3_copy4;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x3_copy4 = current_x3_copy2;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_x3_copy7 = current_x3_copy5;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_y_copy5 = if16 ? current_y_copy4 : current_y_copy7;

  // e_assignment on clock 1 for hw_mandelbrot.c:
  //if(column == (800 - 4))
  assign current_y_copy4 = current_y_copy2;

  assign dummy_if_signal11 = if3;
  assign dummy_if_signal3 = if3;
  assign dummy_if_signal5 = if3;
  assign dummy_if_signal7 = if3;
  assign dummy_if_signal9 = if3;
  // e_assignment on clock 1 for hw_mandelbrot.c:
  //{
  assign if3 = 32'd1;

  assign subexp78 = control_output_break9 && if3;
  assign subexp79 = frame_buffer2 + 32'd4;
  assign subexp80 = if4 && dummy_if_signal3;
  assign subexp81 = if7 && dummy_if_signal5;
  assign subexp82 = if10 && dummy_if_signal7;
  assign subexp83 = if13 && dummy_if_signal9;
  assign subexp84 =  ! if16;
  assign subexp85 = subexp84 && dummy_if_signal11;
  assign subexp86 = if16 && dummy_if_signal11;
  assign subexp87 = frame_buffer4 + 32'd4;
  assign subexp88 =  ! return0;
  assign subexp89 =  ! continue0;
  assign subexp90 =  ! break0;
  assign subexp91 = subexp89 && subexp90;
  assign subexp92 = if5 && subexp91;
  assign subexp93 = subexp88 && subexp92;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign go_bit_control_output3 = subexp93;

  assign subexp94 =  ! return0;
  assign subexp95 =  ! continue0;
  assign subexp96 =  ! break0;
  assign subexp97 = subexp95 && subexp96;
  assign subexp98 = if8 && subexp97;
  assign subexp99 = subexp94 && subexp98;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign go_bit_control_output5 = subexp99;

  assign subexp100 =  ! return0;
  assign subexp101 =  ! continue0;
  assign subexp102 =  ! break0;
  assign subexp103 = subexp101 && subexp102;
  assign subexp104 = if11 && subexp103;
  assign subexp105 = subexp100 && subexp104;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign go_bit_control_output7 = subexp105;

  assign subexp106 =  ! return0;
  assign subexp107 =  ! continue0;
  assign subexp108 =  ! break0;
  assign subexp109 = subexp107 && subexp108;
  assign subexp110 = if14 && subexp109;
  assign subexp111 = subexp106 && subexp110;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign go_bit_control_output9 = subexp111;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign x8 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign x0 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign x16 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign x24 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign y8 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign y0 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign y16 = 32'd0;

  // e_assignment on clock 3 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign y24 = 32'd0;

  assign subexp112 = frame_buffer6 + 32'd4;
  //c_do_block
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_1 accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_the_state_machine_do_1
    (
      .advance_to_state_do_0    (advance_to_state_do_0),
      .advance_to_state_do_4    (advance_to_state_do_4),
      .break2                   (break2),
      .break3                   (break3),
      .clk                      (clk),
      .enable_state_do_0        (enable_state_do_0),
      .enable_state_do_4        (enable_state_do_4),
      .go_bit_control_output3   (go_bit_control_output3),
      .inhibit_from_c_do_block1 (inhibit_from_c_do_block1),
      .reset_n                  (reset_n),
      .state_do_0               (state_do_0)
    );

  assign iters0_init1 = iters6;
  assign x_init1 = x0;
  assign y_init1 = y0;
  assign multiply_assignment0_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_op_a0 = {64 {(((enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[4] & advance_to_state_do_0[4])))}} & multiply_assignment0_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_op_b0 = {64 {(((enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[4] & advance_to_state_do_0[4])))}} & multiply_assignment0_op_b2;
  assign lpm_mult_clken0 = (enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[2] & advance_to_state_do_0[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_res0 = lpm_multiply_result0[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply0, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply0
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource0_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken0),
      .product (lpm_multiply_result0),
      .reset_n (reset_n)
    );

  assign multiply_assignment2_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_op_a0 = {64 {(((enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[4] & advance_to_state_do_0[4])))}} & multiply_assignment2_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_op_b0 = {64 {(((enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[4] & advance_to_state_do_0[4])))}} & multiply_assignment2_op_b2;
  assign lpm_mult_clken1 = (enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[2] & advance_to_state_do_0[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_res0 = lpm_multiply_result1[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply1, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply1 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply1
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource2_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken1),
      .product (lpm_multiply_result1),
      .reset_n (reset_n)
    );

  assign multiply_assignment1_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_op_a0 = {64 {(((enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[4] & advance_to_state_do_0[4])))}} & multiply_assignment1_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_op_b0 = {64 {(((enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[4] & advance_to_state_do_0[4])))}} & multiply_assignment1_op_b2;
  assign lpm_mult_clken2 = (enable_state_do_0[1] & advance_to_state_do_0[1]) | (enable_state_do_0[2] & advance_to_state_do_0[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_res0 = lpm_multiply_result2[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply2, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply2 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply2
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource1_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken2),
      .product (lpm_multiply_result2),
      .reset_n (reset_n)
    );

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign continue1 = 32'd0;

  assign iters9 = iters8;
  assign multiply_assignment0_op_a1 = {{32{x3[31]}}, x3};
  assign multiply_assignment0_op_b1 = {{32{x3[31]}}, x3};
  assign multiply_assignment1_op_a1 = {{32{y3[31]}}, y3};
  assign multiply_assignment1_op_b1 = {{32{y3[31]}}, y3};
  assign signal31 = {{32{x3[31]}}, x3};
  assign multiply_assignment2_op_a1 = {signal31[62 : 0], 1'h0};
  assign multiply_assignment2_op_b1 = {{32{y3[31]}}, y3};
  assign x3 = x2;
  assign y3 = y2;
  assign subexp113 = iters9 + 32'd1;
  assign multiply_assignment0_op_a2 = multiply_assignment0_op_a1;
  assign multiply_assignment0_op_b2 = multiply_assignment0_op_b1;
  assign multiply_assignment1_op_a2 = multiply_assignment1_op_a1;
  assign multiply_assignment1_op_b2 = multiply_assignment1_op_b1;
  assign multiply_assignment2_op_a2 = multiply_assignment2_op_a1;
  assign multiply_assignment2_op_b2 = multiply_assignment2_op_b1;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign break1 = 32'd0;

  assign subexp114 = xsqr1 + ysqr1;
  assign signal32 = subexp114;
  assign signal33 = 64'h0400000000000000;
  assign subexp115 = {~signal32[63], signal32[62 : 0]} < {~signal33[63], signal33[62 : 0]};
  assign subexp116 = {~iters7[31], iters7[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal34 = subexp116;
  assign subexp117 = subexp115 && {{32{signal34[31]}}, signal34};
  assign signal35 = 32'd0;
  assign subexp118 = subexp117 == {{32{signal35[31]}}, signal35};
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign control_output_break1 = subexp118;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign if6 = 32'd1;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign xsqr1 = multiply1;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign ysqr1 = multiply3;

  assign subexp119 = control_output_break1 && if6;
  assign subexp120 = xsqr1 - ysqr1;
  assign subexp121 = subexp120 + {current_x0_copy11[35 : 0], 28'h0};
  assign signal36 = subexp121;
  assign subexp122 = multiply5 + {current_y_copy7[35 : 0], 28'h0};
  assign signal37 = subexp122;
  assign break3 = first_time_at_clock_2_state_do_1 ? 32'd0 : break2;
  assign iters8 = first_time_at_clock_2_state_do_1 ? iters0_init1 : iters7;
  assign x2 = first_time_at_clock_2_state_do_1 ? x_init1 : x1;
  assign y2 = first_time_at_clock_2_state_do_1 ? y_init1 : y1;
  //c_do_block longest path 3
  //due to x
  //starts at (enable_state_do_4[3] & advance_to_state_do_4[3])
  //hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  always @(posedge clk)
    begin
      if (enable_state_do_0[0] & advance_to_state_do_0[0])
        begin
          first_time_at_clock_2_state_do_1 <= 32'd1;
          break2 <= 0;
        end
      if (enable_state_do_0[1] & advance_to_state_do_0[1])
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
          iters7 <= subexp113;

      if (enable_state_do_0[2] & advance_to_state_do_0[2])
        begin
          multiply1 <= multiply_assignment0_prod0;
          multiply3 <= multiply_assignment1_prod0;
          multiply5 <= multiply_assignment2_prod0;
        end
      if (enable_state_do_0[3] & advance_to_state_do_0[3])
        begin
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
          break2 <= ((subexp119 || break1) || return0) || return0;

          first_time_at_clock_2_state_do_1 <= 32'd0;
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
          x1 <= {{28{signal36[63]}}, signal36[63 : 28]};

          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
          y1 <= {{28{signal37[63]}}, signal37[63 : 28]};

        end
    end


  //c_do_block
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_2 accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_the_state_machine_do_2
    (
      .advance_to_state_do_1    (advance_to_state_do_1),
      .advance_to_state_do_4    (advance_to_state_do_4),
      .break5                   (break5),
      .break6                   (break6),
      .clk                      (clk),
      .enable_state_do_1        (enable_state_do_1),
      .enable_state_do_4        (enable_state_do_4),
      .go_bit_control_output5   (go_bit_control_output5),
      .inhibit_from_c_do_block2 (inhibit_from_c_do_block2),
      .reset_n                  (reset_n),
      .state_do_1               (state_do_1)
    );

  assign iters1_init1 = iters14;
  assign x_init3 = x8;
  assign y_init3 = y8;
  assign multiply_assignment4_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_op_a0 = {64 {(((enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[4] & advance_to_state_do_1[4])))}} & multiply_assignment4_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_op_b0 = {64 {(((enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[4] & advance_to_state_do_1[4])))}} & multiply_assignment4_op_b2;
  assign lpm_mult_clken3 = (enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[2] & advance_to_state_do_1[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_res0 = lpm_multiply_result3[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply3, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply3 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply3
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource4_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken3),
      .product (lpm_multiply_result3),
      .reset_n (reset_n)
    );

  assign multiply_assignment3_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_op_a0 = {64 {(((enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[4] & advance_to_state_do_1[4])))}} & multiply_assignment3_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_op_b0 = {64 {(((enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[4] & advance_to_state_do_1[4])))}} & multiply_assignment3_op_b2;
  assign lpm_mult_clken4 = (enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[2] & advance_to_state_do_1[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_res0 = lpm_multiply_result4[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply4, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply4 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply4
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource3_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken4),
      .product (lpm_multiply_result4),
      .reset_n (reset_n)
    );

  assign multiply_assignment5_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_op_a0 = {64 {(((enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[4] & advance_to_state_do_1[4])))}} & multiply_assignment5_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_op_b0 = {64 {(((enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[4] & advance_to_state_do_1[4])))}} & multiply_assignment5_op_b2;
  assign lpm_mult_clken5 = (enable_state_do_1[1] & advance_to_state_do_1[1]) | (enable_state_do_1[2] & advance_to_state_do_1[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_res0 = lpm_multiply_result5[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply5, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply5 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply5
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource5_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken5),
      .product (lpm_multiply_result5),
      .reset_n (reset_n)
    );

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign continue2 = 32'd0;

  assign iters17 = iters16;
  assign multiply_assignment3_op_a1 = {{32{x11[31]}}, x11};
  assign multiply_assignment3_op_b1 = {{32{x11[31]}}, x11};
  assign multiply_assignment4_op_a1 = {{32{y11[31]}}, y11};
  assign multiply_assignment4_op_b1 = {{32{y11[31]}}, y11};
  assign signal38 = {{32{x11[31]}}, x11};
  assign multiply_assignment5_op_a1 = {signal38[62 : 0], 1'h0};
  assign multiply_assignment5_op_b1 = {{32{y11[31]}}, y11};
  assign x11 = x10;
  assign y11 = y10;
  assign subexp123 = iters17 + 32'd1;
  assign multiply_assignment5_op_a2 = multiply_assignment5_op_a1;
  assign multiply_assignment5_op_b2 = multiply_assignment5_op_b1;
  assign multiply_assignment3_op_a2 = multiply_assignment3_op_a1;
  assign multiply_assignment3_op_b2 = multiply_assignment3_op_b1;
  assign multiply_assignment4_op_a2 = multiply_assignment4_op_a1;
  assign multiply_assignment4_op_b2 = multiply_assignment4_op_b1;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign break4 = 32'd0;

  assign subexp124 = xsqr7 + ysqr7;
  assign signal39 = subexp124;
  assign signal40 = 64'h0400000000000000;
  assign subexp125 = {~signal39[63], signal39[62 : 0]} < {~signal40[63], signal40[62 : 0]};
  assign subexp126 = {~iters15[31], iters15[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal41 = subexp126;
  assign subexp127 = subexp125 && {{32{signal41[31]}}, signal41};
  assign signal42 = 32'd0;
  assign subexp128 = subexp127 == {{32{signal42[31]}}, signal42};
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign control_output_break3 = subexp128;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign if9 = 32'd1;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign xsqr7 = multiply7;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign ysqr7 = multiply9;

  assign subexp129 = control_output_break3 && if9;
  assign subexp130 = xsqr7 - ysqr7;
  assign subexp131 = subexp130 + {current_x1_copy11[35 : 0], 28'h0};
  assign signal43 = subexp131;
  assign subexp132 = multiply11 + {current_y_copy7[35 : 0], 28'h0};
  assign signal44 = subexp132;
  assign break6 = first_time_at_clock_2_state_do_4 ? 32'd0 : break5;
  assign iters16 = first_time_at_clock_2_state_do_4 ? iters1_init1 : iters15;
  assign x10 = first_time_at_clock_2_state_do_4 ? x_init3 : x9;
  assign y10 = first_time_at_clock_2_state_do_4 ? y_init3 : y9;
  //c_do_block longest path 3
  //due to x
  //starts at (enable_state_do_4[3] & advance_to_state_do_4[3])
  //hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  always @(posedge clk)
    begin
      if (enable_state_do_1[0] & advance_to_state_do_1[0])
        begin
          first_time_at_clock_2_state_do_4 <= 32'd1;
          break5 <= 0;
        end
      if (enable_state_do_1[1] & advance_to_state_do_1[1])
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
          iters15 <= subexp123;

      if (enable_state_do_1[2] & advance_to_state_do_1[2])
        begin
          multiply11 <= multiply_assignment5_prod0;
          multiply7 <= multiply_assignment3_prod0;
          multiply9 <= multiply_assignment4_prod0;
        end
      if (enable_state_do_1[3] & advance_to_state_do_1[3])
        begin
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
          break5 <= ((subexp129 || break4) || return0) || return0;

          first_time_at_clock_2_state_do_4 <= 32'd0;
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
          x9 <= {{28{signal43[63]}}, signal43[63 : 28]};

          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
          y9 <= {{28{signal44[63]}}, signal44[63 : 28]};

        end
    end


  //c_do_block
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_3 accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_the_state_machine_do_3
    (
      .advance_to_state_do_2    (advance_to_state_do_2),
      .advance_to_state_do_4    (advance_to_state_do_4),
      .break8                   (break8),
      .break9                   (break9),
      .clk                      (clk),
      .enable_state_do_2        (enable_state_do_2),
      .enable_state_do_4        (enable_state_do_4),
      .go_bit_control_output7   (go_bit_control_output7),
      .inhibit_from_c_do_block3 (inhibit_from_c_do_block3),
      .reset_n                  (reset_n),
      .state_do_2               (state_do_2)
    );

  assign iters2_init1 = iters22;
  assign x_init5 = x16;
  assign y_init5 = y16;
  assign multiply_assignment6_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_op_a0 = {64 {(((enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[4] & advance_to_state_do_2[4])))}} & multiply_assignment6_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_op_b0 = {64 {(((enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[4] & advance_to_state_do_2[4])))}} & multiply_assignment6_op_b2;
  assign lpm_mult_clken6 = (enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[2] & advance_to_state_do_2[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_res0 = lpm_multiply_result6[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply6, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply6 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply6
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource6_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken6),
      .product (lpm_multiply_result6),
      .reset_n (reset_n)
    );

  assign multiply_assignment7_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_op_a0 = {64 {(((enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[4] & advance_to_state_do_2[4])))}} & multiply_assignment7_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_op_b0 = {64 {(((enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[4] & advance_to_state_do_2[4])))}} & multiply_assignment7_op_b2;
  assign lpm_mult_clken7 = (enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[2] & advance_to_state_do_2[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_res0 = lpm_multiply_result7[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply7, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply7 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply7
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource7_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken7),
      .product (lpm_multiply_result7),
      .reset_n (reset_n)
    );

  assign multiply_assignment8_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_op_a0 = {64 {(((enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[4] & advance_to_state_do_2[4])))}} & multiply_assignment8_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_op_b0 = {64 {(((enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[4] & advance_to_state_do_2[4])))}} & multiply_assignment8_op_b2;
  assign lpm_mult_clken8 = (enable_state_do_2[1] & advance_to_state_do_2[1]) | (enable_state_do_2[2] & advance_to_state_do_2[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_res0 = lpm_multiply_result8[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply8, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply8 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply8
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource8_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken8),
      .product (lpm_multiply_result8),
      .reset_n (reset_n)
    );

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign continue3 = 32'd0;

  assign iters25 = iters24;
  assign multiply_assignment6_op_a1 = {{32{x19[31]}}, x19};
  assign multiply_assignment6_op_b1 = {{32{x19[31]}}, x19};
  assign multiply_assignment7_op_a1 = {{32{y19[31]}}, y19};
  assign multiply_assignment7_op_b1 = {{32{y19[31]}}, y19};
  assign signal45 = {{32{x19[31]}}, x19};
  assign multiply_assignment8_op_a1 = {signal45[62 : 0], 1'h0};
  assign multiply_assignment8_op_b1 = {{32{y19[31]}}, y19};
  assign x19 = x18;
  assign y19 = y18;
  assign subexp133 = iters25 + 32'd1;
  assign multiply_assignment6_op_a2 = multiply_assignment6_op_a1;
  assign multiply_assignment6_op_b2 = multiply_assignment6_op_b1;
  assign multiply_assignment7_op_a2 = multiply_assignment7_op_a1;
  assign multiply_assignment7_op_b2 = multiply_assignment7_op_b1;
  assign multiply_assignment8_op_a2 = multiply_assignment8_op_a1;
  assign multiply_assignment8_op_b2 = multiply_assignment8_op_b1;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign break7 = 32'd0;

  assign subexp134 = xsqr13 + ysqr13;
  assign signal46 = subexp134;
  assign signal47 = 64'h0400000000000000;
  assign subexp135 = {~signal46[63], signal46[62 : 0]} < {~signal47[63], signal47[62 : 0]};
  assign subexp136 = {~iters23[31], iters23[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal48 = subexp136;
  assign subexp137 = subexp135 && {{32{signal48[31]}}, signal48};
  assign signal49 = 32'd0;
  assign subexp138 = subexp137 == {{32{signal49[31]}}, signal49};
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign control_output_break5 = subexp138;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign if12 = 32'd1;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign xsqr13 = multiply13;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign ysqr13 = multiply15;

  assign subexp139 = control_output_break5 && if12;
  assign subexp140 = xsqr13 - ysqr13;
  assign subexp141 = subexp140 + {current_x2_copy11[35 : 0], 28'h0};
  assign signal50 = subexp141;
  assign subexp142 = multiply17 + {current_y_copy7[35 : 0], 28'h0};
  assign signal51 = subexp142;
  assign break9 = first_time_at_clock_2_state_do_7 ? 32'd0 : break8;
  assign iters24 = first_time_at_clock_2_state_do_7 ? iters2_init1 : iters23;
  assign x18 = first_time_at_clock_2_state_do_7 ? x_init5 : x17;
  assign y18 = first_time_at_clock_2_state_do_7 ? y_init5 : y17;
  //c_do_block longest path 3
  //due to x
  //starts at (enable_state_do_4[3] & advance_to_state_do_4[3])
  //hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  always @(posedge clk)
    begin
      if (enable_state_do_2[0] & advance_to_state_do_2[0])
        begin
          first_time_at_clock_2_state_do_7 <= 32'd1;
          break8 <= 0;
        end
      if (enable_state_do_2[1] & advance_to_state_do_2[1])
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
          iters23 <= subexp133;

      if (enable_state_do_2[2] & advance_to_state_do_2[2])
        begin
          multiply13 <= multiply_assignment6_prod0;
          multiply15 <= multiply_assignment7_prod0;
          multiply17 <= multiply_assignment8_prod0;
        end
      if (enable_state_do_2[3] & advance_to_state_do_2[3])
        begin
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
          break8 <= ((subexp139 || break7) || return0) || return0;

          first_time_at_clock_2_state_do_7 <= 32'd0;
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
          x17 <= {{28{signal50[63]}}, signal50[63 : 28]};

          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
          y17 <= {{28{signal51[63]}}, signal51[63 : 28]};

        end
    end


  //c_do_block
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_state_machine_do_4 accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0_the_state_machine_do_4
    (
      .advance_to_state_do_3    (advance_to_state_do_3),
      .advance_to_state_do_4    (advance_to_state_do_4),
      .break11                  (break11),
      .break12                  (break12),
      .clk                      (clk),
      .enable_state_do_3        (enable_state_do_3),
      .enable_state_do_4        (enable_state_do_4),
      .go_bit_control_output9   (go_bit_control_output9),
      .inhibit_from_c_do_block4 (inhibit_from_c_do_block4),
      .reset_n                  (reset_n),
      .state_do_3               (state_do_3)
    );

  assign iters3_init1 = iters30;
  assign x_init7 = x24;
  assign y_init7 = y24;
  assign multiply_assignment9_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_op_a0 = {64 {(((enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[4] & advance_to_state_do_3[4])))}} & multiply_assignment9_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_op_b0 = {64 {(((enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[4] & advance_to_state_do_3[4])))}} & multiply_assignment9_op_b2;
  assign lpm_mult_clken9 = (enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[2] & advance_to_state_do_3[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_res0 = lpm_multiply_result9[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply9, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply9 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply9
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource9_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken9),
      .product (lpm_multiply_result9),
      .reset_n (reset_n)
    );

  assign multiply_assignment11_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_op_a0 = {64 {(((enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[4] & advance_to_state_do_3[4])))}} & multiply_assignment11_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_op_b0 = {64 {(((enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[4] & advance_to_state_do_3[4])))}} & multiply_assignment11_op_b2;
  assign lpm_mult_clken10 = (enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[2] & advance_to_state_do_3[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_res0 = lpm_multiply_result10[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply10, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply10 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply10
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource11_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken10),
      .product (lpm_multiply_result10),
      .reset_n (reset_n)
    );

  assign multiply_assignment10_prod0 = accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_res0;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_op_a0 = {64 {(((enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[4] & advance_to_state_do_3[4])))}} & multiply_assignment10_op_a2;
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_op_b0 = {64 {(((enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[4] & advance_to_state_do_3[4])))}} & multiply_assignment10_op_b2;
  assign lpm_mult_clken11 = (enable_state_do_3[1] & advance_to_state_do_3[1]) | (enable_state_do_3[2] & advance_to_state_do_3[2]);
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_res0 = lpm_multiply_result11[63 : 0];
  //the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply11, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply11 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_registered_multiply11
    (
      .a       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_op_a0),
      .b       (accelerator_mandelbrot_hw_draw_int_mandelbrot_multiplier_resource10_op_b0),
      .clk     (clk),
      .enable  (lpm_mult_clken11),
      .product (lpm_multiply_result11),
      .reset_n (reset_n)
    );

  // e_assignment on clock 0 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign continue4 = 32'd0;

  assign iters33 = iters32;
  assign multiply_assignment10_op_a1 = {{32{y27[31]}}, y27};
  assign multiply_assignment10_op_b1 = {{32{y27[31]}}, y27};
  assign signal52 = {{32{x27[31]}}, x27};
  assign multiply_assignment11_op_a1 = {signal52[62 : 0], 1'h0};
  assign multiply_assignment11_op_b1 = {{32{y27[31]}}, y27};
  assign multiply_assignment9_op_a1 = {{32{x27[31]}}, x27};
  assign multiply_assignment9_op_b1 = {{32{x27[31]}}, x27};
  assign x27 = x26;
  assign y27 = y26;
  assign subexp143 = iters33 + 32'd1;
  assign multiply_assignment9_op_a2 = multiply_assignment9_op_a1;
  assign multiply_assignment9_op_b2 = multiply_assignment9_op_b1;
  assign multiply_assignment10_op_a2 = multiply_assignment10_op_a1;
  assign multiply_assignment10_op_b2 = multiply_assignment10_op_b1;
  assign multiply_assignment11_op_a2 = multiply_assignment11_op_a1;
  assign multiply_assignment11_op_b2 = multiply_assignment11_op_b1;
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign break10 = 32'd0;

  assign subexp144 = xsqr19 + ysqr19;
  assign signal53 = subexp144;
  assign signal54 = 64'h0400000000000000;
  assign subexp145 = {~signal53[63], signal53[62 : 0]} < {~signal54[63], signal54[62 : 0]};
  assign subexp146 = {~iters31[31], iters31[30 : 0]} < {~max_iter0[31], max_iter0[30 : 0]};
  assign signal55 = subexp146;
  assign subexp147 = subexp145 && {{32{signal55[31]}}, signal55};
  assign signal56 = 32'd0;
  assign subexp148 = subexp147 == {{32{signal56[31]}}, signal56};
  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign control_output_break7 = subexp148;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign if15 = 32'd1;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign xsqr19 = multiply19;

  // e_assignment on clock 2 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign ysqr19 = multiply21;

  assign subexp149 = control_output_break7 && if15;
  assign subexp150 = xsqr19 - ysqr19;
  assign subexp151 = subexp150 + {current_x3_copy11[35 : 0], 28'h0};
  assign signal57 = subexp151;
  assign subexp152 = multiply23 + {current_y_copy7[35 : 0], 28'h0};
  assign signal58 = subexp152;
  assign break12 = first_time_at_clock_2_state_do_10 ? 32'd0 : break11;
  assign iters32 = first_time_at_clock_2_state_do_10 ? iters3_init1 : iters31;
  assign x26 = first_time_at_clock_2_state_do_10 ? x_init7 : x25;
  assign y26 = first_time_at_clock_2_state_do_10 ? y_init7 : y25;
  //c_do_block longest path 3
  //due to x
  //starts at (enable_state_do_4[3] & advance_to_state_do_4[3])
  //hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  always @(posedge clk)
    begin
      if (enable_state_do_3[0] & advance_to_state_do_3[0])
        begin
          first_time_at_clock_2_state_do_10 <= 32'd1;
          break11 <= 0;
        end
      if (enable_state_do_3[1] & advance_to_state_do_3[1])
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
          iters31 <= subexp143;

      if (enable_state_do_3[2] & advance_to_state_do_3[2])
        begin
          multiply19 <= multiply_assignment9_prod0;
          multiply21 <= multiply_assignment10_prod0;
          multiply23 <= multiply_assignment11_prod0;
        end
      if (enable_state_do_3[3] & advance_to_state_do_3[3])
        begin
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
          break11 <= ((subexp149 || break10) || return0) || return0;

          first_time_at_clock_2_state_do_10 <= 32'd0;
          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
          x25 <= {{28{signal57[63]}}, signal57[63 : 28]};

          // e_assignment on clock 2 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
          y25 <= {{28{signal58[63]}}, signal58[63 : 28]};

        end
    end


  assign signal59 = iters13 & 32'hFF;
  assign subexp153 = colour_lookup_table0 + {signal59[29 : 0], 2'h0};
  // e_assignment on clock 4 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters0 == max_iter)? 0 : colour_lookup_table[iters0 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1 = subexp153;

  assign signal60 = iters21 & 32'hFF;
  assign subexp154 = colour_lookup_table0 + {signal60[29 : 0], 2'h0};
  // e_assignment on clock 4 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters1 == max_iter)? 0 : colour_lookup_table[iters1 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address1 = subexp154;

  assign signal61 = iters29 & 32'hFF;
  assign subexp155 = colour_lookup_table0 + {signal61[29 : 0], 2'h0};
  // e_assignment on clock 4 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters2 == max_iter)? 0 : colour_lookup_table[iters2 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address1 = subexp155;

  assign signal62 = iters37 & 32'hFF;
  assign subexp156 = colour_lookup_table0 + {signal62[29 : 0], 2'h0};
  // e_assignment on clock 4 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters3 == max_iter)? 0 : colour_lookup_table[iters3 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address1 = subexp156;

  assign column9 = first_time_at_clock_3_state_do_5 ? column_init1 : column8;
  assign current_x0_copy9 = first_time_at_clock_3_state_do_5 ? current_x0_copy_init1 : current_x0_copy8;
  assign current_x1_copy9 = first_time_at_clock_3_state_do_5 ? current_x1_copy_init1 : current_x1_copy8;
  assign current_x2_copy9 = first_time_at_clock_3_state_do_5 ? current_x2_copy_init1 : current_x2_copy8;
  assign current_x3_copy9 = first_time_at_clock_3_state_do_5 ? current_x3_copy_init1 : current_x3_copy8;
  assign current_y_copy6 = first_time_at_clock_3_state_do_5 ? current_y_copy_init1 : current_y_copy8;
  assign frame_buffer9 = first_time_at_clock_3_state_do_5 ? frame_buffer_init1 : frame_buffer8;
  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign iters13 = if4 ? iters12 : iters38;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign iters21 = if7 ? iters20 : iters41;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign iters12 = iters10;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign iters20 = iters18;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign iters29 = if10 ? iters28 : iters40;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign iters28 = iters26;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign iters37 = if13 ? iters36 : iters39;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign iters36 = iters34;

  assign pixel3 = first_time_at_clock_3_state_do_5 ? pixel_init1 : pixel2;
  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign x7 = if4 ? x6 : x0;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign x15 = if7 ? x14 : x8;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign x23 = if10 ? x22 : x16;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign x31 = if13 ? x30 : x24;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign x14 = x12;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign x22 = x20;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign x30 = x28;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign x6 = x4;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign xsqr5 = if4 ? xsqr4 : xsqr24;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign xsqr11 = if7 ? xsqr10 : xsqr25;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign xsqr17 = if10 ? xsqr16 : xsqr26;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign xsqr23 = if13 ? xsqr22 : xsqr27;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign xsqr16 = xsqr14;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign xsqr22 = xsqr20;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign xsqr4 = xsqr2;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign xsqr10 = xsqr8;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign y7 = if4 ? y6 : y0;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign y15 = if7 ? y14 : y8;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign y23 = if10 ? y22 : y16;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign y31 = if13 ? y30 : y24;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign y14 = y12;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign y22 = y20;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign y30 = y28;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign y6 = y4;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign ysqr5 = if4 ? ysqr4 : ysqr24;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign ysqr11 = if7 ? ysqr10 : ysqr25;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign ysqr17 = if10 ? ysqr16 : ysqr26;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign ysqr23 = if13 ? ysqr22 : ysqr27;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
  assign ysqr16 = ysqr14;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
  assign ysqr22 = ysqr20;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
  assign ysqr4 = ysqr2;

  // e_assignment on clock 4 for hw_mandelbrot.c:
  //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
  assign ysqr10 = ysqr8;

  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address1),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters0_p0xFF_p2_read0_waitrequest_n0),
      .advance_to_state_do_4                                                                                               (advance_to_state_do_4),
      .clk                                                                                                                 (clk),
      .enable_state_do_4                                                                                                   (enable_state_do_4),
      .reset_n                                                                                                             (reset_n)
    );

  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_waitrequest_n0),
      .advance_to_state_do_4                                                                                               (advance_to_state_do_4),
      .clk                                                                                                                 (clk),
      .enable_state_do_4                                                                                                   (enable_state_do_4),
      .reset_n                                                                                                             (reset_n)
    );

  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_waitrequest_n0),
      .advance_to_state_do_4                                                                                               (advance_to_state_do_4),
      .clk                                                                                                                 (clk),
      .enable_state_do_4                                                                                                   (enable_state_do_4),
      .reset_n                                                                                                             (reset_n)
    );

  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_waitrequest_n0),
      .advance_to_state_do_4                                                                                               (advance_to_state_do_4),
      .clk                                                                                                                 (clk),
      .enable_state_do_4                                                                                                   (enable_state_do_4),
      .reset_n                                                                                                             (reset_n)
    );

  assign subexp157 = iters46 == max_iter0;
  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters0 == max_iter)? 0 : colour_lookup_table[iters0 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address1 = frame_buffer15;

  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters1 == max_iter)? 0 : colour_lookup_table[iters1 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address1 = frame_buffer16;

  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters2 == max_iter)? 0 : colour_lookup_table[iters2 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1 = frame_buffer17;

  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters3 == max_iter)? 0 : colour_lookup_table[iters3 & 0xFF];
  assign accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address1 = frame_buffer14;

  assign subexp158 =  ! return0;
  assign subexp159 =  ! continue0;
  assign subexp160 =  ! break0;
  assign subexp161 = subexp159 && subexp160;
  assign subexp162 = if20 && subexp161;
  assign subexp163 = subexp158 && subexp162;
  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters0 == max_iter)? 0 : colour_lookup_table[iters0 & 0xFF];
  assign go_bit_control_output13 = subexp163;

  assign subexp164 =  ! return0;
  assign subexp165 =  ! continue0;
  assign subexp166 =  ! break0;
  assign subexp167 = subexp165 && subexp166;
  assign subexp168 = if20 && subexp167;
  assign subexp169 = subexp164 && subexp168;
  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters1 == max_iter)? 0 : colour_lookup_table[iters1 & 0xFF];
  assign go_bit_control_output17 = subexp169;

  assign subexp170 =  ! return0;
  assign subexp171 =  ! continue0;
  assign subexp172 =  ! break0;
  assign subexp173 = subexp171 && subexp172;
  assign subexp174 = if20 && subexp173;
  assign subexp175 = subexp170 && subexp174;
  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters2 == max_iter)? 0 : colour_lookup_table[iters2 & 0xFF];
  assign go_bit_control_output21 = subexp175;

  assign subexp176 =  ! return0;
  assign subexp177 =  ! continue0;
  assign subexp178 =  ! break0;
  assign subexp179 = subexp177 && subexp178;
  assign subexp180 = if20 && subexp179;
  assign subexp181 = subexp176 && subexp180;
  // e_assignment on clock 10 for hw_mandelbrot.c:
  //*frame_buffer++ = (iters3 == max_iter)? 0 : colour_lookup_table[iters3 & 0xFF];
  assign go_bit_control_output25 = subexp181;

  assign subexp182 = iters49 == max_iter0;
  assign subexp183 = iters48 == max_iter0;
  assign subexp184 = iters47 == max_iter0;
  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address1),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer5_write0_writedata0),
      .advance_to_state_do_4                                                                          (advance_to_state_do_4),
      .clk                                                                                            (clk),
      .dereferenced_frame_buffer6                                                                     (dereferenced_frame_buffer6),
      .enable_state_do_4                                                                              (enable_state_do_4),
      .go_bit_control_output21                                                                        (go_bit_control_output21),
      .reset_n                                                                                        (reset_n)
    );

  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_writedata0),
      .advance_to_state_do_4                                                                          (advance_to_state_do_4),
      .clk                                                                                            (clk),
      .dereferenced_frame_buffer8                                                                     (dereferenced_frame_buffer8),
      .enable_state_do_4                                                                              (enable_state_do_4),
      .go_bit_control_output28                                                                        (go_bit_control_output28),
      .reset_n                                                                                        (reset_n)
    );

  assign break17 = first_time_at_clock_13_state_do_5 ? 32'd0 : break16;
  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_writedata0),
      .advance_to_state_do_4                                                                          (advance_to_state_do_4),
      .clk                                                                                            (clk),
      .dereferenced_frame_buffer4                                                                     (dereferenced_frame_buffer4),
      .enable_state_do_4                                                                              (enable_state_do_4),
      .go_bit_control_output27                                                                        (go_bit_control_output27),
      .reset_n                                                                                        (reset_n)
    );

  accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_module0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_module0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address2),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3       (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_writedata0),
      .advance_to_state_do_4                                                                          (advance_to_state_do_4),
      .clk                                                                                            (clk),
      .dereferenced_frame_buffer9                                                                     (dereferenced_frame_buffer9),
      .enable_state_do_4                                                                              (enable_state_do_4),
      .go_bit_control_output26                                                                        (go_bit_control_output26),
      .reset_n                                                                                        (reset_n)
    );

  //c_do_block longest path 4
  //due to frame_buffer
  //starts at (enable_hw_draw_int_mandelbrot_state0[3] & advance_to_hw_draw_int_mandelbrot_state0[3])
  //hw_mandelbrot.c:
  //{
  always @(posedge clk)
    begin
      if (enable_state_do_4[0] & advance_to_state_do_4[0])
        begin
          first_time_at_clock_13_state_do_5 <= 32'd1;
          first_time_at_clock_3_state_do_5 <= 32'd1;
          break13 <= 0;
        end
      if (enable_state_do_4[1] & advance_to_state_do_4[1])
        begin
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //column = column + 4;
          column2 <= subexp34;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x0_copy = (current_x0_copy + (step_dim * 4));
          current_x0_copy2 <= subexp35;

          current_x0_copy11 <= current_x0_copy10;
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x1_copy = (current_x1_copy + (step_dim * 4));
          current_x1_copy2 <= subexp36;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x1_copy = current_x + step_dim;
          current_x1_copy5 <= subexp37;

          current_x1_copy11 <= current_x1_copy10;
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x2_copy = (current_x2_copy + (step_dim * 4));
          current_x2_copy2 <= subexp38;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x2_copy = current_x + (step_dim << 1);
          current_x2_copy5 <= subexp39;

          current_x2_copy11 <= current_x2_copy10;
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x3_copy = (current_x3_copy + (step_dim * 4));
          current_x3_copy2 <= subexp40;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x3_copy = current_x + (step_dim << 1) + step_dim;
          current_x3_copy5 <= subexp42;

          current_x3_copy11 <= current_x3_copy10;
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_y_copy = current_y_copy - step_dim;
          current_y_copy2 <= subexp43;

          frame_buffer2 <= subexp44;
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters0) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters0) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x0_copy) << 28)) >> 28); (iters0) = (iters0) + 1; } };
          if4 <= subexp50;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters1) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters1) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x1_copy) << 28)) >> 28); (iters1) = (iters1) + 1; } };
          if7 <= subexp56;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters2) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters2) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x2_copy) << 28)) >> 28); (iters2) = (iters2) + 1; } };
          if10 <= subexp62;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //if(column == (800 - 4))
          if16 <= subexp68;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{ long x = 0; long y = 0; long long xsqr = 0; long long ysqr = 0; (iters3) = 0; while( ((xsqr + ysqr) < 0x0400000000000000LL) && ((iters3) < (max_iter)) ) { xsqr = ((long long)x) * ((long long)x); ysqr = ((long long)y) * ((long long)y); y = (long)(((2 * ((long long)x) * ((long long)y)) + ((current_y_copy) << 28)) >> 28); x = (long)(((xsqr - ysqr) + ((current_x3_copy) << 28)) >> 28); (iters3) = (iters3) + 1; } };
          if13 <= subexp74;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //{
          pixel2 <= subexp75;

        end
      if (enable_state_do_4[2] & advance_to_state_do_4[2])
        begin
          // e_assignment on clock 1 for hw_mandelbrot.c:
          //{
          break13 <= ((subexp78 || break0) || return0) || return0;

          frame_buffer4 <= subexp79;
          if5 <= subexp80;
          if8 <= subexp81;
          if11 <= subexp82;
          if14 <= subexp83;
          if17 <= subexp85;
          if18 <= subexp86;
        end
      if (enable_state_do_4[3] & advance_to_state_do_4[3])
          frame_buffer6 <= subexp87;
      if (enable_state_do_4[4] & advance_to_state_do_4[4])
        begin
          current_y_copy8 <= current_y_copy5;
          first_time_at_clock_3_state_do_5 <= 32'd0;
          frame_buffer8 <= subexp112;
          frame_buffer11 <= frame_buffer10;
          iters38 <= iters6;
          iters41 <= iters14;
          iters40 <= iters22;
          iters39 <= iters30;
          xsqr24 <= xsqr0;
          xsqr25 <= xsqr6;
          xsqr26 <= xsqr12;
          xsqr27 <= xsqr18;
          ysqr24 <= ysqr0;
          ysqr25 <= ysqr6;
          ysqr26 <= ysqr12;
          ysqr27 <= ysqr18;
          iters10 <= iters9;
          x4 <= x3;
          xsqr2 <= xsqr1;
          y4 <= y3;
          ysqr2 <= ysqr1;
          iters18 <= iters17;
          x12 <= x11;
          xsqr8 <= xsqr7;
          y12 <= y11;
          ysqr8 <= ysqr7;
          iters26 <= iters25;
          x20 <= x19;
          xsqr14 <= xsqr13;
          y20 <= y19;
          ysqr14 <= ysqr13;
          iters34 <= iters33;
          x28 <= x27;
          xsqr20 <= xsqr19;
          y28 <= y27;
          ysqr20 <= ysqr19;
        end
      if (enable_state_do_4[5] & advance_to_state_do_4[5])
        begin
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters1_p0xFF_p2_read0_address1;
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters2_p0xFF_p2_read0_address1;
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_colour_lookup_table_iters3_p0xFF_p2_read0_address1;
          frame_buffer12 <= frame_buffer2;
          if19 <= if3;
          iters42 <= iters13;
          iters45 <= iters21;
          iters44 <= iters29;
          iters43 <= iters37;
        end
      if (enable_state_do_4[6] & advance_to_state_do_4[6])
        begin
          break14 <= break13;
          frame_buffer13 <= frame_buffer4;
        end
      if (enable_state_do_4[7] & advance_to_state_do_4[7])
          frame_buffer14 <= frame_buffer6;
      if (enable_state_do_4[8] & advance_to_state_do_4[8])
          frame_buffer15 <= frame_buffer11;
      if (enable_state_do_4[9] & advance_to_state_do_4[9])
        begin
          dereferenced_colour_lookup_table_iters0_p0xFF_p3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
          frame_buffer16 <= frame_buffer12;
          if20 <= if19;
          iters46 <= iters42;
          iters49 <= iters45;
          iters48 <= iters44;
          iters47 <= iters43;
        end
      if (enable_state_do_4[10] & advance_to_state_do_4[10])
        begin
          dereferenced_colour_lookup_table_iters1_p0xFF_p3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
          break15 <= break14;
          // e_assignment on clock 9 for hw_mandelbrot.c:
          //*frame_buffer++ = (iters0 == max_iter)? 0 : colour_lookup_table[iters0 & 0xFF];
          dereferenced_frame_buffer2 <= subexp157 ? 32'd0 : dereferenced_colour_lookup_table_iters0_p0xFF_p3;

          frame_buffer17 <= frame_buffer13;
        end
      if (enable_state_do_4[11] & advance_to_state_do_4[11])
        begin
          dereferenced_colour_lookup_table_iters2_p0xFF_p3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer7_write0_address1;
          // e_assignment on clock 10 for hw_mandelbrot.c:
          //*frame_buffer++ = (iters1 == max_iter)? 0 : colour_lookup_table[iters1 & 0xFF];
          dereferenced_frame_buffer4 <= subexp182 ? 32'd0 : dereferenced_colour_lookup_table_iters1_p0xFF_p3;

          frame_buffer18 <= frame_buffer14;
        end
      if (enable_state_do_4[12] & advance_to_state_do_4[12])
        begin
          dereferenced_colour_lookup_table_iters3_p0xFF_p3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_fifo_out_aligned0;
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer1_write0_address1;
          // e_assignment on clock 11 for hw_mandelbrot.c:
          //*frame_buffer++ = (iters2 == max_iter)? 0 : colour_lookup_table[iters2 & 0xFF];
          dereferenced_frame_buffer6 <= subexp183 ? 32'd0 : dereferenced_colour_lookup_table_iters2_p0xFF_p3;

        end
      if (enable_state_do_4[13] & advance_to_state_do_4[13])
        begin
          accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address3 <= accelerator_mandelbrot_hw_draw_int_mandelbrot_dereferenced_frame_buffer3_write0_address1;
          // e_assignment on clock 12 for hw_mandelbrot.c:
          //*frame_buffer++ = (iters3 == max_iter)? 0 : colour_lookup_table[iters3 & 0xFF];
          dereferenced_frame_buffer8 <= subexp184 ? 32'd0 : dereferenced_colour_lookup_table_iters3_p0xFF_p3;

          go_bit_control_output26 <= go_bit_control_output13;
          go_bit_control_output27 <= go_bit_control_output17;
          go_bit_control_output28 <= go_bit_control_output25;
          if21 <= if20;
        end
      if (enable_state_do_4[14] & advance_to_state_do_4[14])
        begin
          break16 <= break15;
          dereferenced_frame_buffer9 <= dereferenced_frame_buffer2;
          first_time_at_clock_13_state_do_5 <= 32'd0;
        end
    end


  assign column14 = if1 ? column13 : column1;
  assign column13 = column11;
  assign current_x0_copy15 = if1 ? current_x0_copy14 : current_x0_copy1;
  assign current_x0_copy14 = current_x0_copy12;
  assign current_x1_copy15 = if1 ? current_x1_copy14 : current_x1_copy1;
  assign current_x1_copy14 = current_x1_copy12;
  assign current_x2_copy15 = if1 ? current_x2_copy14 : current_x2_copy1;
  assign current_x2_copy14 = current_x2_copy12;
  assign current_x3_copy15 = if1 ? current_x3_copy14 : current_x3_copy1;
  assign current_x3_copy14 = current_x3_copy12;
  assign current_y_copy12 = if1 ? current_y_copy11 : current_y_copy1;
  assign current_y_copy11 = current_y_copy9;
  assign frame_buffer22 = if1 ? frame_buffer21 : frame_buffer0;
  assign frame_buffer21 = frame_buffer19;
  assign iters62 = if1 ? iters55 : iters1;
  assign iters63 = if1 ? iters57 : iters2;
  assign iters64 = if1 ? iters59 : iters4;
  assign iters65 = if1 ? iters61 : iters5;
  assign iters55 = iters50;
  assign iters57 = iters51;
  assign iters59 = iters52;
  assign iters61 = iters53;
  assign pixel8 = if1 ? pixel7 : pixel1;
  assign pixel7 = pixel5;
  //c_subroutine_block process, accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0
  always @(posedge clk)
    begin
      if (enable_hw_draw_int_mandelbrot_state0[1] & advance_to_hw_draw_int_mandelbrot_state0[1])
        begin
          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x1_copy = current_x + step_dim;
          current_x1_copy1 <= subexp2;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x2_copy = current_x + (step_dim << 1);
          current_x2_copy1 <= subexp3;

          // e_assignment on clock 0 for hw_mandelbrot.c:
          //current_x3_copy = current_x + (step_dim << 1) + step_dim;
          current_x3_copy1 <= subexp5;

          if1 <= subexp7;
        end
      if (enable_hw_draw_int_mandelbrot_state0[2] & advance_to_hw_draw_int_mandelbrot_state0[2])
          if2 <= subexp8;
      if (enable_hw_draw_int_mandelbrot_state0[4] & advance_to_hw_draw_int_mandelbrot_state0[4])
        begin
          column11 <= column10;
          current_x0_copy12 <= current_x0_copy10;
          current_x1_copy12 <= current_x1_copy10;
          current_x2_copy12 <= current_x2_copy10;
          current_x3_copy12 <= current_x3_copy10;
          current_y_copy9 <= current_y_copy7;
          frame_buffer19 <= frame_buffer10;
          iters50 <= iters46;
          iters51 <= iters49;
          iters52 <= iters48;
          iters53 <= iters47;
          pixel5 <= pixel4;
        end
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module accelerator_mandelbrot_hw_draw_int_mandelbrot_cpu_registers0 (
                                                                      // inputs:
                                                                       cpu_address0,
                                                                       cpu_clk,
                                                                       cpu_reset_n,
                                                                       cpu_select0,
                                                                       cpu_write0,
                                                                       cpu_writedata0,
                                                                       hw_draw_int_mandelbrot0,
                                                                       reset_n,
                                                                       slave_readdata0,
                                                                       slave_waitrequest_n0,

                                                                      // outputs:
                                                                       cpu_irq0,
                                                                       cpu_readdata1,
                                                                       cpu_waitrequest_n0,
                                                                       slave_address0,
                                                                       slave_functiondata0,
                                                                       slave_read0
                                                                    )
;

  output           cpu_irq0;
  output  [ 31: 0] cpu_readdata1;
  output           cpu_waitrequest_n0;
  output  [ 31: 0] slave_address0;
  output  [255: 0] slave_functiondata0;
  output           slave_read0;
  input   [  3: 0] cpu_address0;
  input            cpu_clk;
  input            cpu_reset_n;
  input            cpu_select0;
  input            cpu_write0;
  input   [ 31: 0] cpu_writedata0;
  input   [ 31: 0] hw_draw_int_mandelbrot0;
  input            reset_n;
  input   [ 31: 0] slave_readdata0;
  input            slave_waitrequest_n0;

  wire    [  3: 0] cpu_address_c2hplus0;
  reg              cpu_irq0;
  wire    [ 31: 0] cpu_readdata1;
  wire             cpu_waitrequest_n0;
  reg     [ 63: 0] current_x1;
  reg     [ 63: 0] current_y1;
  reg              delayed_slave_waitrequest_n0;
  reg     [ 31: 0] frame_buffer23;
  reg     [ 31: 0] max_iter1;
  reg              polled_data_ready0;
  wire    [  3: 0] port_monitor0;
  wire    [ 31: 0] slave_address0;
  wire    [255: 0] slave_functiondata0;
  reg              slave_read0;
  reg     [ 63: 0] step_dim1;
  reg     [ 31: 0] tmp_cpu_readdata1;
  //cpu interface register for current_x1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          current_x1[31 : 0] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 1))
          current_x1[31 : 0] <= cpu_writedata0;
    end


  //cpu interface register for current_x1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          current_x1[63 : 32] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 2))
          current_x1[63 : 32] <= cpu_writedata0;
    end


  //cpu interface register for current_y1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          current_y1[31 : 0] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 3))
          current_y1[31 : 0] <= cpu_writedata0;
    end


  //cpu interface register for current_y1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          current_y1[63 : 32] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 4))
          current_y1[63 : 32] <= cpu_writedata0;
    end


  //cpu interface register for step_dim1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          step_dim1[31 : 0] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 5))
          step_dim1[31 : 0] <= cpu_writedata0;
    end


  //cpu interface register for step_dim1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          step_dim1[63 : 32] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 6))
          step_dim1[63 : 32] <= cpu_writedata0;
    end


  //cpu interface register for max_iter1, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          max_iter1[31 : 0] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 7))
          max_iter1[31 : 0] <= cpu_writedata0;
    end


  //cpu interface register for frame_buffer23, which is an e_register
  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          frame_buffer23[31 : 0] <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 8))
          frame_buffer23[31 : 0] <= cpu_writedata0;
    end


  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          tmp_cpu_readdata1 <= 0;
      else if (slave_waitrequest_n0 & slave_read0)
          tmp_cpu_readdata1 <= slave_readdata0;
    end


  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          polled_data_ready0 <= 0;
      else if (cpu_select0 & cpu_write0 & (cpu_address_c2hplus0 == 0))
          polled_data_ready0 <= 0;
      else if (slave_waitrequest_n0)
          polled_data_ready0 <= -1;
    end


  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          slave_read0 <= 0;
      else if (cpu_write0 & cpu_select0 & (cpu_address_c2hplus0 == 0) & cpu_writedata0[0])
          slave_read0 <= -1;
      else if (slave_waitrequest_n0)
          slave_read0 <= 0;
    end


  assign cpu_readdata1 = (cpu_address_c2hplus0 == 0)? polled_data_ready0 :
    tmp_cpu_readdata1;

  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          delayed_slave_waitrequest_n0 <= 1;
      else 
        delayed_slave_waitrequest_n0 <= slave_waitrequest_n0;
    end


  always @(posedge cpu_clk or negedge cpu_reset_n)
    begin
      if (cpu_reset_n == 0)
          cpu_irq0 <= 0;
      else if (cpu_select0 & cpu_write0)
          cpu_irq0 <= 0;
      else if (!(polled_data_ready0) & slave_waitrequest_n0 & !(delayed_slave_waitrequest_n0))
          cpu_irq0 <= -1;
    end


  assign cpu_waitrequest_n0 = 1;
  assign slave_address0 = hw_draw_int_mandelbrot0;
  assign slave_functiondata0 = {current_x1,
    current_y1,
    step_dim1,
    max_iter1,
    frame_buffer23};


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  assign cpu_address_c2hplus0 = cpu_address0;

//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  assign port_monitor0 = 0;
//  c2h_port_byte_refine the_c2h_port_byte_refine
//    (
//      .port_a (cpu_address0),
//      .port_b (port_monitor0),
//      .port_c (reset_n),
//      .port_d (cpu_address_c2hplus0)
//    );
//
//  defparam the_c2h_port_byte_refine.c2h_param1 = 4,
//           the_c2h_port_byte_refine.c2h_param2 = 2,
//           the_c2h_port_byte_refine.c2h_param3 = 2,
//           the_c2h_port_byte_refine.c2h_param4 = 0;
//
//synthesis read_comments_as_HDL off

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module accelerator_mandelbrot_hw_draw_int_mandelbrot (
                                                       // inputs:
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0,
                                                        clk,
                                                        cpu_address0,
                                                        cpu_clk,
                                                        cpu_reset_n,
                                                        cpu_select0,
                                                        cpu_write0,
                                                        cpu_writedata0,
                                                        dummy_master_waitrequest,
                                                        dummy_slave_address,
                                                        dummy_slave_chipselect,
                                                        hw_draw_int_mandelbrot_begin0,
                                                        hw_draw_int_mandelbrot_read0,
                                                        hw_draw_int_mandelbrot_select0,
                                                        reset_n,
                                                        slave_readdata0,
                                                        slave_waitrequest_n0,

                                                       // outputs:
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0,
                                                        accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0,
                                                        cpu_irq0,
                                                        cpu_readdata0,
                                                        cpu_readdata1,
                                                        cpu_waitrequest_n0,
                                                        dummy_master_address,
                                                        dummy_master_write,
                                                        dummy_master_writedata,
                                                        dummy_slave_readdata,
                                                        hw_draw_int_mandelbrot_waitrequest_n0,
                                                        slave_address0,
                                                        slave_read0
                                                     )
;

  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0;
  output  [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0;
  output           accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0;
  output  [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0;
  output           cpu_irq0;
  output  [ 31: 0] cpu_readdata0;
  output  [ 31: 0] cpu_readdata1;
  output           cpu_waitrequest_n0;
  output  [ 31: 0] dummy_master_address;
  output           dummy_master_write;
  output  [ 31: 0] dummy_master_writedata;
  output  [ 31: 0] dummy_slave_readdata;
  output           hw_draw_int_mandelbrot_waitrequest_n0;
  output  [ 31: 0] slave_address0;
  output           slave_read0;
  input   [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0;
  input            accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0;
  input            clk;
  input   [  3: 0] cpu_address0;
  input            cpu_clk;
  input            cpu_reset_n;
  input            cpu_select0;
  input            cpu_write0;
  input   [ 31: 0] cpu_writedata0;
  input            dummy_master_waitrequest;
  input            dummy_slave_address;
  input            dummy_slave_chipselect;
  input            hw_draw_int_mandelbrot_begin0;
  input            hw_draw_int_mandelbrot_read0;
  input            hw_draw_int_mandelbrot_select0;
  input            reset_n;
  input   [ 31: 0] slave_readdata0;
  input            slave_waitrequest_n0;

  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0;
  wire    [  3: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0;
  wire             accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0;
  wire    [ 31: 0] accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0;
  wire             cpu_irq0;
  wire    [ 31: 0] cpu_readdata0;
  wire    [ 31: 0] cpu_readdata1;
  wire             cpu_waitrequest_n0;
  wire             dummy_address_sink;
  wire             dummy_chipselect_sink;
  wire    [ 31: 0] dummy_master_address;
  wire             dummy_master_write;
  wire    [ 31: 0] dummy_master_writedata;
  wire    [ 31: 0] dummy_slave_readdata;
  wire             dummy_waitrequest_sink;
  wire    [ 31: 0] hw_draw_int_mandelbrot0;
  wire    [255: 0] hw_draw_int_mandelbrot_functiondata0;
  wire             hw_draw_int_mandelbrot_waitrequest_n0;
  wire    [ 31: 0] slave_address0;
  wire    [255: 0] slave_functiondata0;
  wire             slave_read0;
  accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0 the_accelerator_mandelbrot_hw_draw_int_mandelbrot_hw_draw_int_mandelbrot0
    (
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0       (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_address0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_flush0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0          (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_read0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0      (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdata0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_readdatavalid0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0       (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_address0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0    (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_byteenable0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0 (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_waitrequest_n0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0         (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_write0),
      .accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0     (accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1_writedata0),
      .clk                                                                           (clk),
      .cpu_readdata0                                                                 (cpu_readdata0),
      .hw_draw_int_mandelbrot_begin0                                                 (hw_draw_int_mandelbrot_begin0),
      .hw_draw_int_mandelbrot_functiondata0                                          (hw_draw_int_mandelbrot_functiondata0),
      .hw_draw_int_mandelbrot_read0                                                  (hw_draw_int_mandelbrot_read0),
      .hw_draw_int_mandelbrot_select0                                                (hw_draw_int_mandelbrot_select0),
      .hw_draw_int_mandelbrot_waitrequest_n0                                         (hw_draw_int_mandelbrot_waitrequest_n0),
      .reset_n                                                                       (reset_n)
    );

  //sub_hw_draw_int_mandelbrot0, which is an e_avalon_slave
  //accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource1, which is an e_avalon_master
  //accelerator_mandelbrot_hw_draw_int_mandelbrot_master_resource0, which is an e_avalon_master
  //the_cpu_registers0, which is an e_instance
  accelerator_mandelbrot_hw_draw_int_mandelbrot_cpu_registers0 the_cpu_registers0
    (
      .cpu_address0            (cpu_address0),
      .cpu_clk                 (cpu_clk),
      .cpu_irq0                (cpu_irq0),
      .cpu_readdata1           (cpu_readdata1),
      .cpu_reset_n             (cpu_reset_n),
      .cpu_select0             (cpu_select0),
      .cpu_waitrequest_n0      (cpu_waitrequest_n0),
      .cpu_write0              (cpu_write0),
      .cpu_writedata0          (cpu_writedata0),
      .hw_draw_int_mandelbrot0 (hw_draw_int_mandelbrot0),
      .reset_n                 (reset_n),
      .slave_address0          (slave_address0),
      .slave_functiondata0     (slave_functiondata0),
      .slave_read0             (slave_read0),
      .slave_readdata0         (slave_readdata0),
      .slave_waitrequest_n0    (slave_waitrequest_n0)
    );

  assign hw_draw_int_mandelbrot_functiondata0 = slave_functiondata0;
  //cpu_interface0, which is an e_avalon_slave
  //internal_master0, which is an e_avalon_master
  assign dummy_master_write = 0;
  assign dummy_master_writedata = 0;
  assign dummy_waitrequest_sink = dummy_master_waitrequest;
  assign dummy_master_address = 0;
  assign dummy_chipselect_sink = dummy_slave_chipselect;
  assign dummy_address_sink = dummy_slave_address;
  assign dummy_slave_readdata = 0;
  //dummy_master, which is an e_avalon_master
  //dummy_slave, which is an e_avalon_slave
  assign hw_draw_int_mandelbrot0 = 0;

endmodule



