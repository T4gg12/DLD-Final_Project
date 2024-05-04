module partyMode(
    input logic clk,
    input logic partySwitch,
    input logic colorSwitch,
    output logic [23:0] alive,
    output logic [23:0] dead
);

parameter NUM_COLORS = 10;

logic selectedColorIndex;
logic [23:0] colorList[NUM_COLORS];

initial begin
    colorList[0] = {8'hFF, 8'h6E, 8'hC7}; // Neon Pink
    colorList[1] = {8'h80, 8'h80, 8'h00}; // Electric Blue
    colorList[2] = {8'hA8, 8'hFF, 8'h00}; // Acid Green
    colorList[3] = {8'hFF, 8'hD3, 8'h00}; // Cyber Yellow
    colorList[4] = {8'h00, 8'hFF, 8'hFF}; // Techno Turquoise
    colorList[5] = {8'hB3, 8'h00, 8'hFF}; // Laser Purple
    colorList[6] = {8'h00, 8'hFF, 8'h00}; // Glowstick Green
    colorList[7] = {8'hFF, 8'h00, 8'hFF}; // Hot Magenta
    colorList[8] = {8'hFF, 8'h66, 8'h00}; // Atomic Orange
    colorList[9] = {8'hFF, 8'h33, 8'h33}; // Radiant Red
end

function void generateRandomColor();
    if (partySwitch) begin
        selectedColorIndex = $urandom_range(0, NUM_COLORS-1);
    end
endfunction

always_ff @(posedge clk) begin
    if (partySwitch) begin
        generateRandomColor(); 
        alive = colorList[selectedColorIndex];
        dead = {8'h80, 8'h80, 8'h80}; // Default dead color
    end
    else if (colorSwitch) begin
        alive = {8'h00, 8'hFF, 8'h00}; // Default alive color
        dead = {8'hFF, 8'h00, 8'h00}; // Default dead color
    end
    else begin
        alive = {8'hFF, 8'h00, 8'h00}; // Default alive color
        dead = {8'h00, 8'h00, 8'hFF}; // Default dead color
    end
end

endmodule