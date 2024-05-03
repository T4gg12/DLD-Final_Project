module clk_div (
    input logic clk,
    input logic rst,
    input logic speedSwitch,
    output logic clk_en
);

    logic [26:0] clk_count; 

    always_ff @(posedge clk, posedge rst) begin
        if (rst)
            clk_count <= 27'h0;
        else
            clk_count <= clk_count + 1;
    end

    always_comb begin
        if (speedSwitch)
            clk_en = clk_count[23]; 
        else
            clk_en = clk_count[25];
    end

endmodule // clk_div