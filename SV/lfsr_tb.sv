module stimulus ();

   logic [63:0] seed;
   logic clk;
   logic reset;
   logic [63:0] shift_seed;
   
   integer handle3;
   integer desc3;
   integer iterations = 0;
   logic[63:0] initial_output = 64'hFF; // Assuming maximal sequence starts with all 1's
   
   // Instantiate the DUT (LFSR)
   lfsr dut(.seed(seed), .clk(clk), .reset(reset), .shift_seed(shift_seed));

   // Clock generation
   always     
   begin
       clk = 1'b1;
       #5;
       clk = 1'b0;
       #5;
   end
     
   // Reset assertion and signal initialization
   initial
   begin
       reset = 1;
       seed = 64'h01; // Initialize seed with all zeros
       #10; // Assert reset for 5 clock cycles
       reset = 0;
       #10; // Release reset after 5 clock cycles
       handle3 = $fopen("lsfr.out", "w"); // Open output file
   end

   // Output monitoring
   always @(posedge clk)
   begin
       desc3 = handle3;
       $fdisplay(desc3, "%b %b", reset, shift_seed); // Write reset and LFSR output to file
   end

   // Check for maximal LFSR sequence on falling edge of clk
   always @(negedge clk)
   begin
       if(~reset)
       begin
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
               $finish;
           end
       end
   end
   
endmodule // stimulus
