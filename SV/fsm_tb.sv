`timescale 1ns / 1ps
module fsm_tb ();

   logic  clk;
   logic  switch1;
   logic  switch2;
   logic  reset;
  
   logic [63:0] seed;
   logic[63:0]  y;
   logic out;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (.seed(seed), .clk(clk), .reset(reset), .switch1(switch1), .switch2(switch2), .shift_seed(y), .out1(out));   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b %b %b || %b", 
		     reset, switch1, switch2, y);
     end 
       
     initial
     begin
          reset = 1;
          seed = 64'h0412_6424_0034_3C28; // Initialize seed with all zeros
          #10; // Assert reset for 5 clock cycles
          reset = 0;
          #10; // Release reset after 5 clock cycles
          handle3 = $fopen("lsfr.out", "w"); // Open output file
     end

   initial 
     begin  
          // left only
     #1   reset = 1'b0;
     #1   switch1= 1'b1;
     #1   switch2= 1'b0;

          // all 
     #41  switch1=1'b1;
     #0   switch2=1'b1;

          // right only
     #41  switch1=1'b0;
     #0   switch2=1'b1;

          // off
     #41  switch1=1'b0;
     #0   switch2=1'b0;

          // all with reset so it can test that everything is reset

	#41 reset= 1'b1;
     #0 switch1= 1'b1;
     #0 switch2= 1'b1;
     
     end

endmodule // FSM_tb