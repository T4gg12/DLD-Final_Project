/*module lfsr(
    input logic [7:0] seed,
    input logic clk,
    input logic reset,
    output logic [7:0] shift_seed
);

logic [7:0] temp;

always_ff @(posedge clk or posedge reset) begin
    if(reset)
        shift_seed <= seed;
    else begin
        temp = {shift_seed[6:0], shift_seed[7] ^ shift_seed[5] ^ shift_seed[4] ^ shift_seed[3]};
        shift_seed <= temp;
    end
end

//your implementation of the LFSR.  Remember that this 
//implementation has memory so it should be done 
//with some form of a flip-flop based register

endmodule*/

module lfsr(
    input logic [63:0] seed,
    input logic clk,
    input logic reset,
    output logic [63:0] shift_seed
);

logic [63:0] temp;

always_ff @(posedge clk or posedge reset) begin
    if(reset)
        shift_seed <= seed;
    else begin
        temp = {shift_seed[62:0], shift_seed[63] ^ shift_seed[61] ^ shift_seed[59] ^ shift_seed[58]};
        shift_seed <= temp;
    end
end

endmodule

