`timescale 1ns / 1ps

module callTo_tb ();

   // Inputs
   logic  clk;
   logic  sw1;
   logic  sw2;
   logic  reset;
  
   // Outputs
   logic [63:0] seed;
   logic [63:0] shift_seed;
   logic  fsmOut;

   // Instantiate CallTo module
   callTo dut (
      .clk(clk),
      .reset(reset),
      .seed(seed),
      .sw1(sw1),
      .sw2(sw2),
      .shift_seed(shift_seed),
      .fsmOut(fsmOut)
   );

   // Clock generation
   initial begin	
      clk = 1'b1;
      forever #5 clk = ~clk;
   end

   // Output file setup
   integer handle;
   initial begin
      handle = $fopen("callTo_output.txt", "w");
      #500; // Finish simulation after 500 time units
      $fclose(handle);
      $finish;
   end

   // Output logging
   always @(posedge clk) begin
      $fdisplay(handle, "%b %b %b || %b", reset, sw1, sw2, shift_seed);
   end   

   // Test sequence
   initial begin  
      // Initialize signals
      reset = 1;
      seed = 64'h0412_6424_0034_3C28; // Initialize seed with some value
      #10; // Assert reset for 10 clock cycles
      reset = 0;
      #10; // Release reset after 10 clock cycles

      // Test cases
      #1;   // left only
      sw1 = 1'b1;
      sw2 = 1'b0;
      #41;  // all 
      sw1 = 1'b1;
      sw2 = 1'b1;
      #41;  // right only
      sw1 = 1'b0;
      sw2 = 1'b1;
      #41;  // off
      sw1 = 1'b0;
      sw2 = 1'b0;
      #41;  // all with reset
      reset = 1'b1;
      #41;  
      reset = 0;
      sw1 = 1'b1;
      sw2 = 1'b1;
   end

endmodule // callTo_tb
