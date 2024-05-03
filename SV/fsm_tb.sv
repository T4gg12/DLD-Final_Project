`timescale 1ns / 1ps
module fsm_tb ();

   logic  clk;
   logic  switch1;
   logic  reset;
  
   logic [63:0] seed;
   logic [63:0] y;
   logic out;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   fsm dut (
     .seed(seed), 
     .clk(clk), 
     .reset(reset), 
     .switch1(switch1),
     .shift_seed(y), 
     .out1(out)
   ); // Added semicolon here
   
   // Setup the clock to toggle every 1 time units 
   always #5 clk = ~clk; // Use always block for clock generation
   
   initial
   begin
       // Open output file
       handle3 = $fopen("fsm.out", "w");
       
       // Initialize seed with all zeros
       seed = 64'h0412_6424_0034_3C28; 
       
       // Assert reset for 5 clock cycles
       reset = 1;
       #10; 
       
       // Release reset after 5 clock cycles
       reset = 0;
       #10;
       
       // Close the file at the end of simulation
       $fclose(handle3); 
       
       // Test sequence
       // left only
       #1   reset = 1'b0;
       #1   switch1 = 1'b1;

       // right only
       #41  switch1 = 1'b0;
   end

   always 
   begin
       // Display reset, switch1, and y values to the output file
       desc3 = handle3;
       #5 $fdisplay(desc3, "%b %b || %b", reset, switch1, y);
   end 

endmodule // fsm_tb
