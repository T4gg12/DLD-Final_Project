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
  logic [63:0] n2;
  logic smol_clk;
  logic [63:0] seed8;                                     
  logic out_clk;
  
assign seed8 = (sw[7]) ? 64'h0412_6424_0034_3C28 ://scuicide
                (sw[6]) ? 64'h0000_0000_0007_0402 ://glider
                          64'h0000_001c_3800_0000 ;//toad
                          
  // Place Conway Game of Life instantiation here
    // Instantiate clk_div module
  clk_div clk_div_inst(.clk(sysclk_125mhz), .rst(sw[0]),.speedSwitch(sw[5]), .clk_en(out_clk));
  
  // Instantiate callTo module
  callTo callTo_inst(.seed(seed8), .clk(out_clk), .reset(sw[1]), .sw1(sw[2]), .shift_seed(n2)); 
 
  // HDMI
  // logic hdmi_out_en;
  //assign hdmi_out_en = 1'b0;
  hdmi_top test (n2, sysclk_125mhz, hdmi_d_p, hdmi_d_n, hdmi_clk_p, 
		         hdmi_clk_n, hdmi_cec, hdmi_sda, hdmi_scl, hdmi_hpd, sw[3], sw[4]);
  
// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule