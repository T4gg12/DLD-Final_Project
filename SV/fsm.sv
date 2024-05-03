module fsm (
    input logic  clk,
    input logic  reset,
    input logic  switch1,
    output logic out1
);

    typedef enum logic [5:0] {
        S0, S1
    } statetype;
    statetype state, nextstate;

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
                if(switch1)
                nextstate <= S1;
                else
                nextstate <= S0;
            end

            S1: begin
                out1 = 1'b1;
                if(reset || switch1 == 0)
                nextstate <= S0;
                else
                nextstate <= S1;
            end
        endcase
    end

endmodule
