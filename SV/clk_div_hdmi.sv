module clk_div_hdmi(
    input logic clk,
    output logic clk_en
);

    logic [26:0] clk_count; 

    always_ff @(posedge clk) begin
        clk_count <= clk_count + 1;
    end

    assign clk_en = clk_count[22]; 

endmodule
