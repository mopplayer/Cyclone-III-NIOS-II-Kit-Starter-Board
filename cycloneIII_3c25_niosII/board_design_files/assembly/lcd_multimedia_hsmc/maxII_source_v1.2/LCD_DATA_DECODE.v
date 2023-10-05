////////////////////////////////////////////////////////////////
//
// LCD_DATA_DECODE
//
//
// OVERVIEW
//   This core is a simple 8 -> 24 data-demultiplexer, which is the
//   final logic driving the Toppoly TD043MTEA LCD display panel.
//   The display-panel input expects one pixel per clock at 33.3MHz,
//   where each pixel is 24 bits of data (8B + 8G + 8R), presented in
//   parallel.
//
//   This logic resides in a MAX device which sits on a daughtercard
//   next to the panel and presents a reduced-pincount interface to
//   the FPGA, like this:
//
//   ~~----------------------+   +-----------------------------------------+
//   ..                      |   |                                         |
//   ..    +--------+        |   |        +------+        +--------------+ |
//   ..    |        |        [[H]]        |      |---/--->| R            | |
//   ..    |  FPGA  | B,G,R  [[S]] B,G,R  | MAX  |   8    |              | |
//   ..    |        |----/-->[[M]]---/--->|(incl |---/--->| G   LCD      | |
//   ..    |        |    8   [[C]]   8    | This |   8    |    Display   | |
//   ..    +--------+        |   |        | Core)|---/--->| B            | |
//   ..                      |   |        +------+   8    +--------------+ |
//   ..                      |   |                                         |
//   ..    Host Board        |   |     Daughtercard                        |
//   ~~----------------------+   +-----------------------------------------+
//
//
//   Of course, the 8-bit data comes in at 3x the rate (100MHz) of the
//   24-bit samples we drive to the display.  The 8-bit data is also
//   accompanied by the display's sync-signals:
//
//          HD:     Horizontal (line) sync-pulse
//          VD:     Vertical (frame) sync-pulse
//          DEN:    Data-qualification
//
// PRINCIPLES of OPERATION
//
//   All of the BGR-data and sync-signals coming from the FPGA are
//   immediately captured in registers.  The FPGA provides the
//   fundamental capture-clock (inexplicably-named "MUTI_clk",
//   but which I rename to "clk" for the purposes of simplicity and clarity)
//   at 3x the picture-rate. All input- and output-signals are
//   referenced to the rising edge of clk.
//
// SYNC-SIGNAL TIMING (input and output)
//
//   This logic delays the incoming VD, HD, and DEN all by the same
//   fixed number of clock-cycles (which doesn't matter), and presents
//   them, otherwise-unmodified, to the LCD panel.
//
//       (the net-delay for R happens to be four clock-cycles, but
//       that number is implementation-dependent).
//
// INPUT-DATA TIMING
//
//   The 8-bit-wide HC_LCD_DATA signal is presumed to contain a stream
//   of color pixel data, with each pixel represented by three
//   successive clock-cycles of the stream.  The data is presented as
//   "BGR," in that order.
//
//   This circuit uses the HD pulse to determine the position of the
//   BLUE color-sample, and thus the start of each three-clock
//   pixel-period.  State-transitions on HD (0-->1 or 1-->0) coincide
//   with the presentation of BLUE color on the HC_LCD_DATA input.  The
//   GREEN and RED values for that same pixel are presented on the
//   next two clock-cycles.
//
//                         INPUT-DATA TIMING
//               Color-phase referened to HD-transitions.
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
//  HD         \                            /     
//              \__________________________/     
//
//
//   HD is not allowed to change state except at pixel-boundaries.
//   Again: This circuit uses state-transitions on the HD-signal to
//   synchronize its internal counters.
//
//
// OUTPUT TIMING
//
//   This circuit generates an outgoing clock (NCLK) to the LCD
//   panel.  This clock runs at 1/3 the frequency of the incoming clk.
//
//  
//            ___       ___       ___       ___       ___       __ 
//  clk      /   \     /   \     /   \     /   \     /   \     /       
//         _/     \___/     \___/     \___/     \___/     \___/  
//                                     
//               ___________________________   ____________________         
//            \ /                           \ /                  
//  LCD data   x           {R:G:B}           x           {R:G:B}  
//            / \___________________________/ \____________________
//
//                                          
//               ___________________________   ____________________         
// LCD_...    \ /                           \ /  
// Sync        x          HD,VD,DEN          x          HD,VD,DEN
// Signals    / \___________________________/ \____________________
//
//
//         _____________             _________________             __    
//                      \           /                 \           /  
//    NCLK               \         /                   \         /   
//                        \_______/                     \_______/    
//                      
//           
// Notice that NCLK transitions on different edges of clk than the RGB
// Data and sync-signals.  This has the favorable effect that the
// sync- and data-signals to the LCD are stable on *both* the falling
// *and* rising edges of NCLK...so the LCD-panel can capture these signals
// on either edge at no penalty.
//
// This is one of the advantages of generating slow timing waveforms
// off of a faster clock:  You can place the signal-edges anywhere you
// like, with very-well-defined timing-relationships to each other,
// limited only by the granularity of the faster clock.
//
// Any time you find yourself generating timing waveforms, ask
// yourself:  "would my life be simpler if I used a much-faster clock
// to help me place the edges exactly where I want them?"  The answer
// is always "Yes, of course my life would be simpler."  The only
// reason to *not* do this is the inability to use or generate a
// faster cloock.  In this case:  We have a faster clock already
// lying-around, so we'd be nuts to *not* use it.
//

module LCD_DATA_DECODE
  (
   clk,
   reset_n,
   
   RGB_in,
   HD_in,
   VD_in,
   DEN_in,
   
   LCD_R,
   LCD_G,
   LCD_B,
   LCD_HD,
   LCD_VD,
   LCD_DEN,
   LCD_NCLK
   );
   

   input        clk;
   input        reset_n;
   
   input [7:0]  RGB_in;
   input        HD_in;
   input        VD_in;
   input        DEN_in;

   output [7:0] LCD_R;
   output [7:0] LCD_G;
   output [7:0] LCD_B;
   output 	LCD_HD;
   output 	LCD_VD;
   output 	LCD_DEN;
   output 	LCD_NCLK;

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
   reg [7:0] d1_RGB;
   reg [7:0] d2_RGB;
   reg [7:0] d3_RGB;

   reg 	     d1_HD;
   reg 	     d2_HD;
   reg 	     d3_HD;

   reg 	     d1_VD;
   reg 	     d2_VD;
   reg 	     d3_VD;
   
   reg 	     d1_DEN;
   reg 	     d2_DEN;
   reg 	     d3_DEN;

   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) begin
	 // Async reset.  In this case, it may seem silly. But trust
	 // me.  It's not.
	 //
	 //   This is one of those rare, rare cases where your
	 //   design-intent is actually made clearer by putting more
	 //   than one statement on a line.
	 //
	 d3_HD  <= 0; d2_HD  <= 0; d1_HD  <= 0;
	 d3_VD  <= 0; d2_VD  <= 0; d1_VD  <= 0;
	 d3_DEN <= 0; d2_DEN <= 0; d1_DEN <= 0;
	 d3_RGB <= 0; d2_RGB <= 0; d1_RGB <= 0; 
      end
      else begin
	 d3_HD  <= d2_HD;  d2_HD  <= d1_HD;  d1_HD  <=  HD_in;
	 d3_VD  <= d2_VD;  d2_VD  <= d1_VD;  d1_VD  <=  VD_in;
	 d3_DEN <= d2_DEN; d2_DEN <= d1_DEN; d1_DEN <= DEN_in;
	 d3_RGB <= d2_RGB; d2_RGB <= d1_RGB; d1_RGB <= RGB_in;
      end
   end // always @ (posedge clk or negedge reset_n)

   ////////////////
   // 24-bit output.
   //
   //   Our outputs, of course, are delivered in a register.
   //
   //   Blue comes first in the sequence, so it will be the most-delayed
   //   version of the 8-bit input-data; green the
   //   second-most-delayed, and red the least-delayed.
   //
   //   Because we're adding another cycle of delay to the output, we
   //   have to add the same delay, with the same enable-signal, to
   //   the sync-signals.  If we just obey the simple rule:  "Do unto
   //   the sync-signals as we do unto the red-byte," then we can't lose.
   //
   reg [7:0] LCD_R;
   reg [7:0] LCD_G;
   reg [7:0] LCD_B;
   reg       LCD_HD;
   reg       LCD_VD;
   reg       LCD_DEN;

   wire      output_clk_enable;    // Computed later from phase-counter
   
   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) begin
	 LCD_R    <= 0;
	 LCD_G    <= 0;
	 LCD_B    <= 0;
	 LCD_HD   <= 0;
	 LCD_VD   <= 0;
	 LCD_DEN  <= 0;
      end
      else begin
	 if (output_clk_enable) begin
	    LCD_R    <= d1_RGB;
	    LCD_G    <= d2_RGB;
	    LCD_B    <= d3_RGB;
	    LCD_HD   <= d3_HD;
	    LCD_VD   <= d3_VD;
	    LCD_DEN  <= d3_DEN;
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
   //     * Synchronizing it every time HD changes state.
   //
   // Here are the hard parts:
   //
   //     1) Deciding which of our delayed versions of HD to look at
   //     2) Which counter-value we use to determine NCLK: 0, 1, or 2.
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
   //  zero onto the NCLK output.
   //
   //  From looking at the timing diagrams (above), it's pretty clear
   //  that you enable the output-registers *first,* and then drive
   //  NCLK low on the subsequent clock-cycle.   OK.  That's easy to
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
`define PHASE_NCLK_LOW 1

   assign output_clk_enable =  (color_phase_counter == `PHASE_OUTPUT_CLK_ENABLE);
   wire   pNCLK             = ~(color_phase_counter == `PHASE_NCLK_LOW         );
   
   ////////////////
   // NCLK output-register.
   //     Totally vanilla.
   //
   reg 	  LCD_NCLK;
   
   always @(posedge clk or negedge reset_n) begin
      if (reset_n == 0) 
	LCD_NCLK <= 0;
      else
	LCD_NCLK <= pNCLK;
   end
   
   ////////////////
   // Phase-counter synchronization event.
   //
   //   We look for a transition (either 1->0 or 0->1) on HD, and use
   //   that to drive the synchronous-clear on the phase counter.
   //
   //   But we have three versions of HD available to us:  HD with
   //   three, two, and one clock of delay (remember: we promised not
   //   to use the RAW input HD for anything in our circuit...that
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
   //   So if the "d2" version of HD has suddenly transitioned "low,"
   //   then you know that the "B" pixel is in the d2-stage as well.
   //   If we assert sync-clear, then (on the next clock-cycle) B will
   //   move into the d3 stage and the color-phase counter will be
   //   zero.  That's happy, because the zero phase-count value will
   //   enable d3-B into the output-registers at the right time.
   //
   //   So: By that English-verbal argument: We're looking for d2_HD
   //   being a different state from what it was on the previous
   //   clock-cycle, like this:
   //
   assign color_phase_counter_sync_clear = (d2_HD != d3_HD);

endmodule // LCD_DATA_DECODE

