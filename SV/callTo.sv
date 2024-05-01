module callTo (input logic [63:0] seed,
input logic clk,
input logic reset,
input logic sw1,
input logic sw2,
output logic [63:0] shift_seed);


logic [63:0] fsm_shift_seed;
logic [63:0] lfsr_shift_seed;
logic [63:0] dp_shift_seed;
logic fsmOut;

FSM dut(.clk(clk), .reset(reset), .switch1(sw1), .switch2(sw2), .seed(seed), .shift_seed(fsm_shift_seed), .out1(fsmOut));

lfsr dut1(.clk(clk), .reset(reset), .seed(seed), .shift_seed(lfsr_shift_seed));

datapath dut2(.grid(fsm_shift_seed), .grid_evolve(dp_shift_seed));

mux2 dut3(.d0(lfsr_shift_seed), .d1(dp_shift_seed), .s(fsmOut), .y(shift_seed)); 

endmodule