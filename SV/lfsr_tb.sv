// testbench to prove maximal LFSR
module stimulus ();

   logic [7:0] seed;
   logic clk;
   logic reset;
   logic [7:0] shift_seed;
   
   integer handle3;
   integer desc3;
   
   lfsr dut(.seed(seed), .clk(clk), .reset(reset), .shift_seed(shift_seed));

   always     
     begin
	    clk = 1; #1;
      clk = 0; #1;
     end
   
   initial
     begin
      handle3 = $fopen("lsfr.out");
     end

   always @(posedge clk)
     begin
    desc3 = handle3;
    #5 $fdisplay(desc3, "%b", shift_seed);
     end

   // check results on falling edge of clk
   always @(negedge clk) begin
		if(~reset) begin
		//check if your output equals the initial output 
		//if so, report how many iterations it took to repeat
		//this should be (2^n) - 1
		//if the output never repeats for 2^n iterations, report that
		end
	end
   
endmodule // tb

