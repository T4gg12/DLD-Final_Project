`timescale 1ns / 1ps

module callTo_tb();
    integer handle;
    
    // Inputs
    logic clk;
    logic reset;
    logic sw1;
    logic [63:0] seed;
    
    // Outputs
    logic [63:0] shift_seed;
    
    // Instantiate the callTo module with sw1 and sw2 enabled
    callTo dut (
        .clk(clk),
        .reset(reset),
        .sw1(sw1),
        .seed(seed),
        .shift_seed(shift_seed)
    );

    // Setup the clock to toggle every 1 time unit
    initial begin
        clk = 1'b1;
        forever #5 clk = ~clk;
    end

    // Open output file
    initial begin
        handle = $fopen("callTo.out", "w");
    end

    // Monitor signals and write to file
    always @(posedge clk) begin
        $fdisplay(handle, "%b %b || %b", reset, sw1, shift_seed);
    end

    // Initialize inputs and apply test cases
    initial begin
        reset = 1'b1;
        seed = 64'h0412_6424_0034_3C28; // Initialize seed
        #10; // Assert reset for 10 time units
        reset = 0;
        #100; // Release reset after 100 time units

        // Test cases
        #1;   
        sw1 = 1'b1;
        #41;  
        sw1 = 1'b0;
    end

endmodule
