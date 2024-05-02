module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  
  // output  
  output logic [7:0] led,
  output logic       sseg_ca,
  output logic       sseg_cb,
  output logic       sseg_cc,
  output logic       sseg_cd,
  output logic       sseg_ce,
  output logic       sseg_cf,
  output logic       sseg_cg,
  output logic       sseg_dp,
  output logic [3:0] sseg_an,
  output logic [2:0] hdmi_d_p,  
  output logic [2:0] hdmi_d_n,   
  output logic       hdmi_clk_p,   
  output logic	     hdmi_clk_n,
   
  inout logic	     hdmi_cec,  
  inout logic	     hdmi_sda,   
  inout logic	     hdmi_scl,   
  input logic	     hdmi_hpd
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  
  // Internal signals
  logic [7:0] red_out;
  logic [7:0] green_out;
  logic [7:0] blue_out;
  logic [63:0] n2;
  logic [63:0] seed8;
  
  // Instantiate clk_div module
  clk_div clk_div_inst(.clk(sysclk_125mhz), .rst(sw[0]), .clk_en(out_clk));
  
  // Instantiate callTo module
  callTo callTo_inst(.seed(seed8), .clk(out_clk), .reset(sw[1]), .sw1(sw[2]), .sw2(sw[3]), .shift_seed(n2)); 
  
  // HDMI
  hdmi_top test (n2, sysclk_125mhz, hdmi_d_p, hdmi_d_n, hdmi_clk_p, 
		         hdmi_clk_n, hdmi_cec, hdmi_sda, hdmi_scl, hdmi_hpd);
  
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  .digit0(sw[3:0]),
  .digit1(4'b0111),
  .digit2(sw[7:4]),
  .digit3(4'b1111),
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

  // Assigning n2 inside always block
  always @(posedge sysclk_125mhz or posedge rst) begin
    if (rst) begin
      n2 <= 64'h0412_6424_0034_3C28;
    end else begin
      // Your logic to update n2 goes here
      // Example: n2 <= something;
    end
  end
  
  // Extract RGB components from n2
  always_comb begin
    red_out = n2[7:0];      // Extract red component
    green_out = n2[15:8];    // Extract green component
    blue_out = n2[23:16];    // Extract blue component
  end

  // Register logic storing clock counts
  always @(posedge sysclk_125mhz) begin
    if (btn[3]) begin
      CURRENT_COUNT <= 17'h00000;
    end else begin
      CURRENT_COUNT <= NEXT_COUNT;
    end
  end
  
  // Increment logic
  assign NEXT_COUNT = (CURRENT_COUNT == 17'd100000) ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = (CURRENT_COUNT == 17'd100000) ? 1'b1 : 1'b0;

endmodule
