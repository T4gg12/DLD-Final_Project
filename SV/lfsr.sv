module lfsr(seed, clk, reset, shift_seed);
//inputs and outputs for a smaller implementation
//perhaps 8 or 16 bits
input logic [7:0] seed;
input logic [7:0] clk;
input logic reset;
output logic [7:0] shift_seed;

reg [7:0] shift_seed_reg, shift_seed_next;
wire taps;

always @(posedge clk, negedge reset)
begin
    if(~reset)
        shift_seed_reg <= 'd1;
    else
        shift_seed_reg <= shift_seed_next;
end

always @(taps, shift_seed_reg)
    shift_seed_next = {taps, shift_seed_reg[7:0]};

assign shift_seed = shift_seed_reg;

assign taps = shift_seed_reg[3] ^ shift_seed_reg[2];
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