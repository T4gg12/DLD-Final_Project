module fsm (clk, reset, switch1, switch2, seed, shift_seed, out1);

   input logic  clk;
   input logic  reset;
   input logic 	[63:0]seed;
   input logic switch1;
   input logic switch2;
   
   output logic [63:0] shift_seed;
   output logic out1;

   typedef enum 	logic [5:0] {S0, S1, S2} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
    case (state)
       S0: begin	  
          if(switch1)
            nextstate <= S1;
          else if(switch2)
            nextstate <= S2;
          else
            nextstate <= S0;
            shift_seed = seed;
       end

       S1: begin
        out1 = 1'b0;
        nextstate <= S0;
        shift_seed = seed;
       end

       S2: begin
        out1 = 1'b1;
        nextstate <= S0;
        shift_seed = seed;
       end
    endcase
endmodule