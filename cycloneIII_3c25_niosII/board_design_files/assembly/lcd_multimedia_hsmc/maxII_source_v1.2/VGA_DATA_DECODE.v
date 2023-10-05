////////////////////////////////////////////////////////////////
//
// VGA_DATA_DECODE
//
//   ~~----------------------+   +-----------------------------------------+
//   ..                      |   |                                         |
//   ..    +--------+        |   |        +------+        +--------------+ |
//   ..    |        |        [[H]]        |      |---/--->| R            | |
//   ..    |  FPGA  | B,G,R  [[S]] B,G,R  | MAX  |   10   |              | |
//   ..    |        |----/-->[[M]]---/--->|(incl |---/--->| G   VGA      | |
//   ..    |        |    10  [[C]]   10   | This |   10   |    decoder   | |
//   ..    +--------+        |   |        | Core)|---/--->| B            | |
//   ..                      |   |        +------+   10    +--------------+ |
//   ..                      |   |                                         |
//   ..    Host Board        |   |     Daughtercard                        |
//   ~~----------------------+   +-----------------------------------------+
//

//
//                         INPUT-DATA TIMING
//               Color-phase referened to HS-transitions.
//       
//          
//            ___       ___       ___       ___       ___       __ 
//  clk      /   \     /   \     /   \     /   \     /   \     /       
//         _/     \___/     \___/     \___/     \___/     \___/
//         
//               _______   _______   _______   _______   _______         
//            \ /       \ /       \ /       \ /       \ /       \ /
//  RGB-in     x    B    x    G    x    R    x    B    x    G    x 
//            / \_______/ \_______/ \_______/ \_______/ \_______/ \
//               
//               
//       _____                                _____________________ 
//            \                              /     
//  HS  	   \                            /     
//              \__________________________/     
//
//
//
//
// OUTPUT TIMING
//
//   This circuit generates an outgoing clock (VGA_CLOCK) to the VGA 
//   decoder. This clock runs at 1/3 the frequency of the incoming clk.
//
//  
//            ___       ___       ___       ___       ___       __ 
//  clk      /   \     /   \     /   \     /   \     /   \     /       
//         _/     \___/     \___/     \___/     \___/     \___/  
//                                     
//               ___________________________   ____________________         
//            \ /                           \ /                  
//  VGA data   x           {R:G:B}           x           {R:G:B}  
//            / \___________________________/ \____________________
//
//                                          
//               ___________________________   ____________________         
// VGA_...    \ /                           \ /  
// Sync        x          HS,VS,BLANK        x          HS,VS,BLANK
// Signals    / \___________________________/ \____________________
//
//
//         _____________             _________________             __    
//                      \           /                 \           /  
//    VGA_CLOCK          \         /                   \         /   
//                        \_______/                     \_______/    
//                      
//           


module VGA_DATA_DECODE
  (
   clk,
   reset_n,
   
   RGB_in,
   HS_in,
   VS_in,
   BLANK_in,
   SYNC_in,	
   
   VGA_R,
   VGA_G,
   VGA_B,
   VGA_HS,
   VGA_VS,
   VGA_BLANK,
   VGA_SYNC,
   VGA_CLOCK
   );
   

   input        clk;
   input        reset_n;
   
   input [9:0]  RGB_in;
   input        HS_in;
   input        VS_in;
   input        BLANK_in;
   input		SYNC_in;		

   output [9:0] VGA_R;
   output [9:0] VGA_G;
   output [9:0] VGA_B;
   output 	VGA_HS;
   output 	VGA_VS;
   output 	VGA_BLANK;
   output   VGA_SYNC;
   output 	VGA_CLOCK;

   ////////////////
   // Input-capture & delay.
   //
   //   First: Capture all the inputs into registers.  Doing anything
   //   else would be nuts!  We *swear* to never use the raw versions
   //   of these signals right from the input-pins.  Using those
   //   signals would be nuts!
   //
   //   Also, while we're here clocking input-data values into
   //   registers, it's easy to build a delay-line.  We (obviously)
   //   need to do this for the data, because we need three past
   //   values in our hands to compose the 24-bit output.  And:
   //   Because the sync-signals have to be, um, SYNCHRONIZED with the
   //   data, we have to delay them exactly as many times as we delay
   //   the data.  So the incoming signals are not only captured,
   //   they're also delayed two additional clock-cycles for
   //   coherent presentation on the ouptut.
   //
   //   Note: I could implement the sync-signal delay-chains
   //   multi-bit-wide registers and the Verilog shift-operator.  But
   //   there's nothing like three explicitly-named signals for
   //   explicitness.
   //
   reg [9:0] d1_RGB;
   reg [9:0] d2_RGB;
   reg [9:0] d3_RGB;

   reg 	     d1_HS;
   reg 	     d2_HS;
   reg 	     d3_HS;

   reg 	     d1_VS;
   reg 	     d2_VS;
   reg 	     d3_VS;
   
   reg 	     d1_BLANK;
   reg 	     d2_BLANK;
   reg 	     d3_BLANK;

   reg 	     d1_SYNC;  
   reg 	     d2_SYNC;
   reg 	     d3_SYNC;

   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) begin
	 // Async reset.  In this case, it may seem silly. But trust
	 // me.  It's not.
	 //
	 //   This is one of those rare, rare cases where your
	 //   design-intent is actually made clearer by putting more
	 //   than one statement on a line.
	 //
	 d3_HS  <= 0; d2_HS  <= 0; d1_HS  <= 0;
	 d3_VS  <= 0; d2_VS  <= 0; d1_VS  <= 0;
	 d3_BLANK <= 0; d2_BLANK <= 0; d1_BLANK <= 0;
	 d3_RGB <= 0; d2_RGB <= 0; d1_RGB <= 0; 
	 d3_SYNC <= 0; d2_SYNC <= 0; d1_SYNC <= 0; 
      end
      else begin
	 d3_HS  <= d2_HS;  d2_HS  <= d1_HS;  d1_HS  <=  HS_in;
	 d3_VS  <= d2_VS;  d2_VS  <= d1_VS;  d1_VS  <=  VS_in;
	 d3_BLANK <= d2_BLANK; d2_BLANK <= d1_BLANK; d1_BLANK <= BLANK_in;
	 d3_SYNC <= d2_SYNC; d2_SYNC <= d1_SYNC; d1_SYNC <= SYNC_in;	
	 d3_RGB <= d2_RGB; d2_RGB <= d1_RGB; d1_RGB <= RGB_in;

      end
   end // always @ (posedge clk or negedge reset_n)


   reg [9:0] VGA_R;
   reg [9:0] VGA_G;
   reg [9:0] VGA_B;
   reg       VGA_HS;
   reg       VGA_VS;
   reg       VGA_BLANK;
   reg       VGA_SYNC;
   wire      output_clk_enable;    // Computed later from phase-counter
   
   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) begin
	 VGA_R    <= 0;
	 VGA_G    <= 0;
	 VGA_B    <= 0;
	 VGA_HS   <= 0;
	 VGA_VS   <= 0;
	 VGA_SYNC   <= 0;
	 VGA_BLANK  <= 0;
      end
      else begin
	 if (output_clk_enable) begin
	    VGA_R    <= d1_RGB;
	    VGA_G    <= d2_RGB;
	    VGA_B    <= d3_RGB;
	    VGA_HS   <= d3_HS;
	    VGA_VS   <= d3_VS;
	    VGA_SYNC <= d3_SYNC;
	    VGA_BLANK  <= d3_BLANK;
	 end
      end // else: !if(reset_n == 0)
   end // always @ (posedge clk or negedge reset_n)


   ////////////////
   // Phase-counter.
   //
   // There are only three phases.  And the phase-synchronization
   // event is well-defined.  So.  Here are the easy parts:
   //
   //     * Building a counter that goes: "zero,one,two,zero,one,two..."
   //     * Synchronizing it every time HS changes state.
   //
   // Here are the hard parts:
   //
   //     1) Deciding which of our delayed versions of HS to look at
   //     2) Which counter-value we use to determine CLOCK: 0, 1, or 2.
   //     3) Which counter-value we use to determine out_clk_enable:
   //
   // Fine. So let's start with something easy: Building a little
   // counter.  How perfectly conventional.
   //
   reg [1:0] color_phase_counter;
   wire      color_phase_counter_sync_clear;
   
   always @ (posedge clk or negedge reset_n) begin
      if (reset_n == 0) begin
	 color_phase_counter  <= 0;
      end
      else begin
	 if (color_phase_counter_sync_clear) begin
	    color_phase_counter <= 0;
	 end
	 else begin
	    color_phase_counter = (color_phase_counter == 2) ? 
                                   (0                      ) : 
                                   (color_phase_counter + 1) ;
	 end
      end // else: !if(reset_n == 0)
   end // always @ (posedge clk or negedge reset_n)

   ////////////////
   // Defining the counter-phases.
   //
   //  The phase-counter only drives two things:   It tells us when to
   //  enable the output registers, and it tells us when to drive a
   //  zero onto the CLOCK output.
   //
   //  From looking at the timing diagrams (above), it's pretty clear
   //  that you enable the output-registers *first,* and then drive
   //  CLOCK low on the subsequent clock-cycle.   OK.  That's easy to
   //  do:
   //
   //      Style note:  I generally do not use `define.  I usually
   //      prefer parameters.  But this circuit really is performing a
   //      fixed-function.  In this specific case: I don't think they
   //      will ever invent a fourth primary color, so it's safe to
   //      hard-code-in a bunch of assumptions that this thing will
   //      only ever count to three.
   //
   // Let's just say that the numbering-and-naming of the phases is
   // arbitrary, and that the real relationship between the
   // phase-counter and the Sync+B+G+R data is determined by the
   // timing of the phase-counter synchronization-event, which we
   // compute below.
   //
   // Now that we've said "the phase-numbering is arbitrary," I can
   // defie it arbitrarily, like this:
   //
`define PHASE_OUTPUT_CLK_ENABLE 0
`define PHASE_CLOCK_LOW 1

   assign output_clk_enable =  (color_phase_counter == `PHASE_OUTPUT_CLK_ENABLE);
   wire   pCLOCK             = ~(color_phase_counter == `PHASE_CLOCK_LOW         );
   
   ////////////////
   // CLOCK output-register.
   //     Totally vanilla.
   //
   reg 	  VGA_CLOCK;
   
   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) 
	VGA_CLOCK <= 0;
      else
	VGA_CLOCK <= pCLOCK;
   end
   
   ////////////////
   // Phase-counter synchronization event.
   //
   //   We look for a transition (either 1->0 or 0->1) on HS, and use
   //   that to drive the synchronous-clear on the phase counter.
   //
   //   But we have three versions of HS available to us:  HS with
   //   three, two, and one clock of delay (remember: we promised not
   //   to use the RAW input HS for anything in our circuit...that
   //   would be nuts!).
   //
   //   We can think of our circuit as a four-stage pipeline, with the data &
   //   sync signals flowing-through.  The phase-counter determines
   //   what inputs & enables to drive into the output-registers, so
   //   we can think of the phase-counter as sitting in "Stage 3" of
   //   the pipeline, right before the output.
   //
   //   The synchronous-clear is an input to the phase-counter, whose
   //   result won't be seen in the phase-counter output until the
   //   subsequent clock-cycle.  So you can think of the
   //   syncronous-clear being computed in "Stage 2" of the pipeline.
   //
   //   So if the "d2" version of HS has suddenly transitioned "low,"
   //   then you know that the "B" pixel is in the d2-stage as well.
   //   If we assert sync-clear, then (on the next clock-cycle) B will
   //   move into the d3 stage and the color-phase counter will be
   //   zero.  That's happy, because the zero phase-count value will
   //   enable d3-B into the output-registers at the right time.
   //
   //   So: By that English-verbal argument: We're looking for d2_HS
   //   being a different state from what it was on the previous
   //   clock-cycle, like this:
   //
   assign color_phase_counter_sync_clear = (d2_HS != d3_HS);

endmodule // VGA_DATA_DECODE

