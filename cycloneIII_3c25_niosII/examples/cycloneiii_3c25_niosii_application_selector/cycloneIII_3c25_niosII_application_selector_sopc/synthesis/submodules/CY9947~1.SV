// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.



  
`timescale 1 ns / 1 ns

			 
module cycloneIII_3c25_niosII_application_selector_sopc_flash_ssram_tristate_bridge_pinSharer_0_pin_sharer (
 // ** Clock and Reset Connections
    input  logic clk
   ,input  logic reset

 // ** Arbiter Connections

 // *** Arbiter Grant Interface
   ,output logic ack
   ,input  logic [ 2 - 1 : 0 ] next_grant

// *** Arbiter Request Interface

    ,output logic arb_ext_flash_tcm 
    ,output logic arb_ssram_tcm 
		
		     // ** Avalon TC Slave Interfaces




  // Slave Interface tcs1

    ,input  logic tcs1_request 
    ,output logic tcs1_grant   

  //ext_flash.tcm signals
    ,input  logic[ 23 :0 ] tcs1_tcm_address_out
    ,input  logic[ 0 :0 ] tcs1_tcm_read_n_out
    ,input  logic[ 0 :0 ] tcs1_tcm_write_n_out
    ,output logic[ 15 :0 ]  tcs1_tcm_data_in
    ,input  logic[ 15 :0 ]  tcs1_tcm_data_out
    ,input  logic tcs1_tcm_data_outen
    ,input  logic[ 0 :0 ] tcs1_tcm_chipselect_n_out



  // Slave Interface tcs0

    ,input  logic tcs0_request 
    ,output logic tcs0_grant   

  //ssram.tcm signals
    ,input  logic[ 0 :0 ] tcs0_tcm_chipselect_n_out
    ,input  logic[ 3 :0 ] tcs0_tcm_byteenable_n_out
    ,input  logic[ 0 :0 ] tcs0_tcm_outputenable_n_out
    ,input  logic[ 0 :0 ] tcs0_tcm_write_n_out
    ,output logic[ 31 :0 ]  tcs0_tcm_data_in
    ,input  logic[ 31 :0 ]  tcs0_tcm_data_out
    ,input  logic tcs0_tcm_data_outen
    ,input  logic[ 19 :0 ] tcs0_tcm_address_out
    ,input  logic[ 0 :0 ] tcs0_tcm_reset_n_out
    ,input  logic[ 0 :0 ] tcs0_tcm_begintransfer_n_out
		     
		     // ** Avalon TC Master Interface
    ,output logic request
    ,input  logic grant

		     // *** Passthrough Signals
		     
		     
                     // *** Shared Signals
		      	     
    ,output  logic[ 0 :0 ] read_n_to_the_ext_flash
    ,output  logic[ 0 :0 ] select_n_to_the_ext_flash
    ,output  logic[ 23 :0 ] flash_ssram_tristate_bridge_address
    ,output  logic[ 0 :0 ] bwe_n_to_the_ssram
    ,output  logic[ 0 :0 ] reset_n_to_the_ssram
    ,output  logic[ 0 :0 ] chipenable1_n_to_the_ssram
    ,output  logic[ 3 :0 ] bw_n_to_the_ssram
    ,output  logic[ 0 :0 ] outputenable_n_to_the_ssram
    ,input   logic[ 31  :0 ]  flash_ssram_tristate_bridge_data_in
    ,output  logic[ 31  :0 ]  flash_ssram_tristate_bridge_data
    ,output  logic flash_ssram_tristate_bridge_data_outen
    ,output  logic[ 0 :0 ] adsc_n_to_the_ssram
    ,output  logic[ 0 :0 ] write_n_to_the_ext_flash

		     );

   function [2-1:0] getIndex;
      
      input [2-1:0] select;
      
      getIndex = 'h0;
      
      for(int i=0; i < 2; i = i + 1) begin
	 if( select[i] == 1'b1 )
           getIndex = i;
      end
      
   endfunction // getIndex

   logic[ 2 - 1 : 0 ] selected_grant;


   // Request Assignments

    assign arb_ext_flash_tcm = tcs1_request;
    assign arb_ssram_tcm = tcs0_request;
   
   logic [ 2 - 1 : 0 ] concated_incoming_requests;
   
   
   assign 			      concated_incoming_requests = {						    
         tcs1_request 
        ,tcs0_request 
				};
   
				       
   assign 			      request = | concated_incoming_requests;
  assign        tcs0_grant = selected_grant[0];
  assign        tcs1_grant = selected_grant[1];

   
    // Perform Grant Selection						  
   always@(posedge clk, posedge reset) begin
     if(reset) begin
	selected_grant<=0;
	ack <= 0;
     end 
     else begin
       if(grant && (concated_incoming_requests[getIndex(selected_grant)] == 0 || selected_grant == 0 )) begin
	  if(~request)
	    selected_grant <= '0;
	  else
	    selected_grant <= next_grant;
	  
          ack<=1;
       end
       else begin
         ack<=0;
         selected_grant <= selected_grant;
       end
     end
   end // always@ (posedge clk, posedge reset)

// Passthrough Signals

  
// Renamed Signals
    assign read_n_to_the_ext_flash = tcs1_tcm_read_n_out ;
    assign write_n_to_the_ext_flash = tcs1_tcm_write_n_out ;
    assign select_n_to_the_ext_flash = tcs1_tcm_chipselect_n_out ;
    assign chipenable1_n_to_the_ssram = tcs0_tcm_chipselect_n_out ;
    assign bw_n_to_the_ssram = tcs0_tcm_byteenable_n_out ;
    assign outputenable_n_to_the_ssram = tcs0_tcm_outputenable_n_out ;
    assign bwe_n_to_the_ssram = tcs0_tcm_write_n_out ;
    assign reset_n_to_the_ssram = tcs0_tcm_reset_n_out ;
    assign adsc_n_to_the_ssram = tcs0_tcm_begintransfer_n_out ;
  
// Shared Signals
  cycloneIII_3c25_niosII_application_selector_sopc_flash_ssram_tristate_bridge_pinSharer_0_pin_sharer_multiplexor_2 #(.WIDTH(24) )
    flash_ssram_tristate_bridge_address_mux (
                              {
                                tcs1_grant
                               ,tcs0_grant
                              }
                              ,tcs1_tcm_address_out
                              ,{4'h0,tcs0_tcm_address_out}
                              , flash_ssram_tristate_bridge_address
                             );
  assign tcs0_tcm_data_in = flash_ssram_tristate_bridge_data_in[31:0]; 
  assign tcs1_tcm_data_in = flash_ssram_tristate_bridge_data_in[15:0]; 
  cycloneIII_3c25_niosII_application_selector_sopc_flash_ssram_tristate_bridge_pinSharer_0_pin_sharer_multiplexor_2 #(.WIDTH(1) )
    flash_ssram_tristate_bridge_data_outen_mux (
                              {
                                tcs1_grant
                               ,tcs0_grant
                              }
                              ,tcs1_tcm_data_outen
                              ,tcs0_tcm_data_outen
                              , flash_ssram_tristate_bridge_data_outen
                             );
  cycloneIII_3c25_niosII_application_selector_sopc_flash_ssram_tristate_bridge_pinSharer_0_pin_sharer_multiplexor_2 #(.WIDTH(32) )
    flash_ssram_tristate_bridge_data_mux (
                              {
                                tcs1_grant
                               ,tcs0_grant
                              }
                              ,{16'h0,tcs1_tcm_data_out}
                              ,tcs0_tcm_data_out
                              , flash_ssram_tristate_bridge_data
                             );
  
endmodule   
					    

  
module cycloneIII_3c25_niosII_application_selector_sopc_flash_ssram_tristate_bridge_pinSharer_0_pin_sharer_multiplexor_2
  #( parameter WIDTH      = 8
    ) (
    input logic  [ 2 -1 : 0]                       SelectVector,
    input logic  [ WIDTH - 1 : 0 ]                Input_1,
    input logic  [ WIDTH - 1 : 0 ]                Input_0,
    output logic [ WIDTH - 1 : 0 ]                OutputSignal
       );


function [2-1:0] getIndex;
      
    input [2-1:0] select;
   
    getIndex = 'h0;
    
    for(int i=0; i < 2; i = i + 1) begin
      if( select[i] == 1'b1 )
        getIndex = i;
    end
			      				
endfunction
								 
   always @* begin
     case(getIndex(SelectVector))
       default: OutputSignal = Input_0;
       0 : OutputSignal = Input_0;									   
       1 : OutputSignal = Input_1;									   
     endcase
   end
   
endmodule



