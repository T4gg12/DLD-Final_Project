module lfsr(seed, clk, reset, shift_seed);
//inputs and outputs for a smaller implementation
//perhaps 8 or 16 bits
input logic [7:0] seed;
input logic clk;
input logic reset;
output logic [7:0] shift_seed;

logic [7:0] temp;
logic temp1;

always@(posedge clk) begin
    if(reset) shift_seed <= seed;
    else shift_seed <= temp;
end

always_comb begin
    temp <= {shift_seed[6:0], shift_seed[7] ~^ shift_seed[5] ~^ shift_seed[4] ~^ shift_seed[3]};
end
//your implementation of the LFSR.  Remember that this 
//implementation has memory so it should be done 
//with some form of a flip-flop based register

endmodule

/*
module lfsr64 (seed, clk, reset, shift_seed);
//inputs and outputs for the full seed size (64 bits)

//either build a 64 bit version using your smaller implementation above
//or use the same methods from the xilinx document to build a full
//64 bit version

endmodule
*/