module callTo (
    input logic [63:0] seed,
    input logic clk,
    input logic reset,
    input logic sw1,
    output logic [63:0] shift_seed
);
    logic [63:0] dp_shift_seed;
    logic [63:0] lfsr_shift_seed;
    logic [63:0] flopr_shift_seed;
    logic [63:0] mux_shift_seed;
    logic fsmOut;

    fsm dut_fsm (
        .clk(clk),
        .reset(reset),
        .switch1(sw1),
        .out1(fsmOut)
    );

    lfsr dut_lfsr (
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .shift_seed(lfsr_shift_seed)
    );

    mux2 #(64) dut_mux (
        .d0(lfsr_shift_seed),
        .d1(flopr_shift_seed),
        .s(fsmOut),
        .y(mux_shift_seed)
    );

    datapath dut_dp (
        .grid(mux_shift_seed),
        .grid_evolve(dp_shift_seed)
    );
    flopr dut_flop(
        .reset(reset), 
        .clk(clk), 
        .seed(dp_shift_seed), 
        .shift_seed(flopr_shift_seed)
        );

    assign shift_seed = flopr_shift_seed;
endmodule
