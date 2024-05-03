module fsm (
    input logic  clk,
    input logic  reset,
    input logic  [63:0] seed,
    input logic  switch1,
    output logic [63:0] shift_seed,
    output logic out1
);

    typedef enum logic [5:0] {
        S0, S1
    } statetype;

    statetype state, nextstate;

    // Internal signals to hold shifted seed values from datapath and LFSR
    logic [63:0] dp_shift_seed;
    logic [63:0] lfsr_shift_seed;

    // Instantiate datapath and LFSR modules
    datapath dut_dp (
        .grid(seed),
        .grid_evolve(dp_shift_seed),
        .rst(reset),
        .clk(clk)
    );

    lfsr dut_lfsr (
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .shift_seed(lfsr_shift_seed)
    );

    // state register
    always_ff @(posedge clk, posedge reset)
        if (reset)
            state <= S0;
        else
            state <= nextstate;

    // next state logic
    always_comb begin
        case (state)
            S0: begin
                out1 = 1'b0;
                // Output of datapath is used in state S0
                shift_seed = dp_shift_seed;
                nextstate = switch1 ? S1 : S0; 
            end

            S1: begin
                out1 = 1'b1;
                // Output of LFSR is used in state S1
                shift_seed = lfsr_shift_seed;
                nextstate = S0; 
            end
        endcase
    end

endmodule
