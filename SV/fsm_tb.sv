`timescale 1ns / 1ps
module fsm_tb ();

   logic  clk;
   logic  switch1;
   logic  reset;
   logic out;
   
   integer handle3;
   integer desc3;
   
   fsm dut (
     .clk(clk), 
     .reset(reset), 
     .switch1(switch1),
     .out1(out)
   ); // Added semicolon here
   
   always     
   begin
       clk = 1'b1;
       #5;
       clk = 1'b0;
       #5;
   end
   
   initial
   begin
       
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

endmodule // fsm_tb
