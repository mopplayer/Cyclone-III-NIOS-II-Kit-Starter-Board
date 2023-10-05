/* This master does absolutely nothing.  It's used in cases where you need
   a master to connect to unconnected slaves in SOPC Builder.  An example is
   onchip memory used by C2H, if you haven't run the C2H compiler you need
   to connect something to the memory.  Since the outputs are grounded all the
   arbitration logic should be synthesized away during compilation.
*/

module dummy_master
(
  address,
  writedata,
  write,
  waitrequest
); 

  input waitrequest;
  output wire [31:0] address;
  output wire [31:0] writedata;
  output wire write;
  
  assign address = 0;
  assign writedata =0;
  assign write = 0;

  endmodule