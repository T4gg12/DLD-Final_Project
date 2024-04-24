// testbench to prove maximal LFSR
module stimulus ();

   logic [7:0] seed;
   logic clk;
   logic reset;
   logic [7:0] shift_seed;
   
   integer handle3;
   integer desc3;
   integer iterations = 0;
   logic[7:0] initial_output;
   
   lfsr dut(.seed(seed), .clk(clk), .reset(reset), .shift_seed(shift_seed));

   always     
     begin
	    clk = 1; #1;
      clk = 0; #1;
     end
   
   initial
     begin
      handle3 = $fopen("lsfr.out");
      initial_output = shift_seed;
     end

   always @(posedge clk)
     begin
    desc3 = handle3;
    #5 $fdisplay(desc3, "%b", shift_seed);
     end

   // check results on falling edge of clk
   always @(negedge clk) begin
		if(~reset) begin
      iterations = iterations + 1;
      if(shift_seed == initial_output)
      begin
        if(iterations == (1<<8)-1)
        begin
          $display("Maximal LFSR sequence detected. Repeated after %d iterations.", iterations);
		    end
        else
        begin
          $display("LFSR sequence did not repeat after (2^n)-1 iterations.");
        end
        $finsih;
	    end
    end
   end
   
endmodule // tb

