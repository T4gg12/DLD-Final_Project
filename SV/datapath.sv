/*
 
 Conway's Game of Life modeled in SVerilog
 
 */

module datapath ( grid, grid_evolve, clk, rst );

   output logic [63:0] 	grid_evolve;
   input logic [63:0] 	grid;
   input logic clk;
   input logic rst;   

   logic [63:0] grid_reg;
   logic [63:0] grid_evolve_reg;

   always_ff @(posedge clk or posedge rst)
   begin
       if (rst) begin
           grid_reg <= 64'h0;
           grid_evolve_reg <= 64'h0;
       end else begin
           grid_reg <= grid;
           grid_evolve_reg <= grid_evolve; 
       end
   end
   
   evolve3 e0_0 (grid_evolve[0], grid[1], grid[8], grid[9], grid_evolve_reg[0]);
   evolve5 e0_1 (grid_evolve[1], grid[0], grid[2], grid[8], grid[9], grid[10], grid_evolve_reg[1]);
   evolve5 e0_2 (grid_evolve[2], grid[1], grid[3], grid[9], grid[10], grid[11], grid_evolve_reg[2]);
   evolve5 e0_3 (grid_evolve[3], grid[2], grid[4], grid[10], grid[11], grid[12], grid_evolve_reg[3]);
   evolve5 e0_4 (grid_evolve[4], grid[3], grid[5], grid[11], grid[12], grid[13], grid_evolve_reg[4]);
   evolve5 e0_5 (grid_evolve[5], grid[4], grid[6], grid[12], grid[13], grid[14], grid_evolve_reg[5]);
   evolve5 e0_6 (grid_evolve[6], grid[5], grid[7], grid[13], grid[14], grid[15], grid_evolve_reg[6]);
   evolve3 e0_7 (grid_evolve[7], grid[6], grid[14], grid[15], grid_evolve_reg[7]);
   
   evolve5 e1_0 (grid_evolve[8], grid[0], grid[1], grid[9], grid[16], grid[17], grid_evolve_reg[8]);
   evolve8 e1_1 (grid_evolve[9], grid[0], grid[1], grid[2], grid[8], grid[10], grid[16], grid[17], grid[18], grid_evolve_reg[9]);
   evolve8 e1_2 (grid_evolve[10], grid[1], grid[2], grid[3], grid[9], grid[11], grid[17], grid[18], grid[19], grid_evolve_reg[10]);
   evolve8 e1_3 (grid_evolve[11], grid[2], grid[3], grid[4], grid[10], grid[12], grid[18], grid[19], grid[20], grid_evolve_reg[11]);
   evolve8 e1_4 (grid_evolve[12], grid[3], grid[4], grid[5], grid[11], grid[13], grid[19], grid[20], grid[21], grid_evolve_reg[12]);
   evolve8 e1_5 (grid_evolve[13], grid[4], grid[5], grid[6], grid[12], grid[14], grid[20], grid[21], grid[22], grid_evolve_reg[13]);
   evolve8 e1_6 (grid_evolve[14], grid[5], grid[6], grid[7], grid[13], grid[15], grid[21], grid[22], grid[23], grid_evolve_reg[14]);
   evolve5 e1_7 (grid_evolve[15], grid[6], grid[7], grid[14], grid[22], grid[23], grid_evolve_reg[15]);
   
   evolve5 e2_0 (grid_evolve[16], grid[0+8*1], grid[1+8*1], grid[9+8*1], grid[16+8*1], grid[17+8*1], grid_evolve_reg[16]);
   evolve8 e2_1 (grid_evolve[17], grid[0+8*1], grid[1+8*1], grid[2+8*1], grid[8+8*1], grid[10+8*1], grid[16+8*1], grid[17+8*1], grid[18+8*1], grid_evolve_reg[17]);
   evolve8 e2_2 (grid_evolve[18], grid[1+8*1], grid[2+8*1], grid[3+8*1], grid[9+8*1], grid[11+8*1], grid[17+8*1], grid[18+8*1], grid[19+8*1], grid_evolve_reg[18]);
   evolve8 e2_3 (grid_evolve[19], grid[2+8*1], grid[3+8*1], grid[4+8*1], grid[10+8*1], grid[12+8*1], grid[18+8*1], grid[19+8*1], grid[20+8*1], grid_evolve_reg[19]);
   evolve8 e2_4 (grid_evolve[20], grid[3+8*1], grid[4+8*1], grid[5+8*1], grid[11+8*1], grid[13+8*1], grid[19+8*1], grid[20+8*1], grid[21+8*1], grid_evolve_reg[20]);
   evolve8 e2_5 (grid_evolve[21], grid[4+8*1], grid[5+8*1], grid[6+8*1], grid[12+8*1], grid[14+8*1], grid[20+8*1], grid[21+8*1], grid[22+8*1], grid_evolve_reg[21]);
   evolve8 e2_6 (grid_evolve[22], grid[5+8*1], grid[6+8*1], grid[7+8*1], grid[13+8*1], grid[15+8*1], grid[21+8*1], grid[22+8*1], grid[23+8*1], grid_evolve_reg[22]);
   evolve5 e2_7 (grid_evolve[23], grid[6+8*1], grid[7+8*1], grid[14+8*1], grid[22+8*1], grid[23+8*1], grid_evolve_reg[23]);
   
   evolve5 e3_0 (grid_evolve[24], grid[0+8*2], grid[1+8*2], grid[9+8*2], grid[16+8*2], grid[17+8*2], grid_evolve_reg[24]);
   evolve8 e3_1 (grid_evolve[25], grid[0+8*2], grid[1+8*2], grid[2+8*2], grid[8+8*2], grid[10+8*2], grid[16+8*2], grid[17+8*2], grid[18+8*2], grid_evolve_reg[25]);
   evolve8 e3_2 (grid_evolve[26], grid[1+8*2], grid[2+8*2], grid[3+8*2], grid[9+8*2], grid[11+8*2], grid[17+8*2], grid[18+8*2], grid[19+8*2], grid_evolve_reg[26]);
   evolve8 e3_3 (grid_evolve[27], grid[2+8*2], grid[3+8*2], grid[4+8*2], grid[10+8*2], grid[12+8*2], grid[18+8*2], grid[19+8*2], grid[20+8*2], grid_evolve_reg[27]);
   evolve8 e3_4 (grid_evolve[28], grid[3+8*2], grid[4+8*2], grid[5+8*2], grid[11+8*2], grid[13+8*2], grid[19+8*2], grid[20+8*2], grid[21+8*2], grid_evolve_reg[28]);
   evolve8 e3_5 (grid_evolve[29], grid[4+8*2], grid[5+8*2], grid[6+8*2], grid[12+8*2], grid[14+8*2], grid[20+8*2], grid[21+8*2], grid[22+8*2], grid_evolve_reg[29]);
   evolve8 e3_6 (grid_evolve[30], grid[5+8*2], grid[6+8*2], grid[7+8*2], grid[13+8*2], grid[15+8*2], grid[21+8*2], grid[22+8*2], grid[23+8*2], grid_evolve_reg[30]);
   evolve5 e3_7 (grid_evolve[31], grid[6+8*2], grid[7+8*2], grid[14+8*2], grid[22+8*2], grid[23+8*2], grid_evolve_reg[31]);
   
   evolve5 e4_0 (grid_evolve[32], grid[0+8*3], grid[1+8*3], grid[9+8*3], grid[16+8*3], grid[17+8*3], grid_evolve_reg[32]);
   evolve8 e4_1 (grid_evolve[33], grid[0+8*3], grid[1+8*3], grid[2+8*3], grid[8+8*3], grid[10+8*3], grid[16+8*3], grid[17+8*3], grid[18+8*3], grid_evolve_reg[33]);
   evolve8 e4_2 (grid_evolve[34], grid[1+8*3], grid[2+8*3], grid[3+8*3], grid[9+8*3], grid[11+8*3], grid[17+8*3], grid[18+8*3], grid[19+8*3], grid_evolve_reg[34]);
   evolve8 e4_3 (grid_evolve[35], grid[2+8*3], grid[3+8*3], grid[4+8*3], grid[10+8*3], grid[12+8*3], grid[18+8*3], grid[19+8*3], grid[20+8*3], grid_evolve_reg[35]);
   evolve8 e4_4 (grid_evolve[36], grid[3+8*3], grid[4+8*3], grid[5+8*3], grid[11+8*3], grid[13+8*3], grid[19+8*3], grid[20+8*3], grid[21+8*3], grid_evolve_reg[36]);
   evolve8 e4_5 (grid_evolve[37], grid[4+8*3], grid[5+8*3], grid[6+8*3], grid[12+8*3], grid[14+8*3], grid[20+8*3], grid[21+8*3], grid[22+8*3], grid_evolve_reg[37]);
   evolve8 e4_6 (grid_evolve[38], grid[5+8*3], grid[6+8*3], grid[7+8*3], grid[13+8*3], grid[15+8*3], grid[21+8*3], grid[22+8*3], grid[23+8*3], grid_evolve_reg[38]);
   evolve5 e4_7 (grid_evolve[39], grid[6+8*3], grid[7+8*3], grid[14+8*3], grid[22+8*3], grid[23+8*3], grid_evolve_reg[39]);  

   evolve5 e5_0 (grid_evolve[40], grid[0+8*4], grid[1+8*4], grid[9+8*4], grid[16+8*4], grid[17+8*4], grid_evolve_reg[40]);
   evolve8 e5_1 (grid_evolve[41], grid[0+8*4], grid[1+8*4], grid[2+8*4], grid[8+8*4], grid[10+8*4], grid[16+8*4], grid[17+8*4], grid[18+8*4], grid_evolve_reg[41]);
   evolve8 e5_2 (grid_evolve[42], grid[1+8*4], grid[2+8*4], grid[3+8*4], grid[9+8*4], grid[11+8*4], grid[17+8*4], grid[18+8*4], grid[19+8*4], grid_evolve_reg[42]);
   evolve8 e5_3 (grid_evolve[43], grid[2+8*4], grid[3+8*4], grid[4+8*4], grid[10+8*4], grid[12+8*4], grid[18+8*4], grid[19+8*4], grid[20+8*4], grid_evolve_reg[43]);
   evolve8 e5_4 (grid_evolve[44], grid[3+8*4], grid[4+8*4], grid[5+8*4], grid[11+8*4], grid[13+8*4], grid[19+8*4], grid[20+8*4], grid[21+8*4], grid_evolve_reg[44]);
   evolve8 e5_5 (grid_evolve[45], grid[4+8*4], grid[5+8*4], grid[6+8*4], grid[12+8*4], grid[14+8*4], grid[20+8*4], grid[21+8*4], grid[22+8*4], grid_evolve_reg[45]);
   evolve8 e5_6 (grid_evolve[46], grid[5+8*4], grid[6+8*4], grid[7+8*4], grid[13+8*4], grid[15+8*4], grid[21+8*4], grid[22+8*4], grid[23+8*4], grid_evolve_reg[46]);
   evolve5 e5_7 (grid_evolve[47], grid[6+8*4], grid[7+8*4], grid[14+8*4], grid[22+8*4], grid[23+8*4], grid_evolve_reg[47]);  

   evolve5 e6_0 (grid_evolve[48], grid[0+8*5], grid[1+8*5], grid[9+8*5], grid[16+8*5], grid[17+8*5], grid_evolve_reg[48]);
   evolve8 e6_1 (grid_evolve[49], grid[0+8*5], grid[1+8*5], grid[2+8*5], grid[8+8*5], grid[10+8*5], grid[16+8*5], grid[17+8*5], grid[18+8*5], grid_evolve_reg[49]);
   evolve8 e6_2 (grid_evolve[50], grid[1+8*5], grid[2+8*5], grid[3+8*5], grid[9+8*5], grid[11+8*5], grid[17+8*5], grid[18+8*5], grid[19+8*5], grid_evolve_reg[50]);
   evolve8 e6_3 (grid_evolve[51], grid[2+8*5], grid[3+8*5], grid[4+8*5], grid[10+8*5], grid[12+8*5], grid[18+8*5], grid[19+8*5], grid[20+8*5], grid_evolve_reg[51]);
   evolve8 e6_4 (grid_evolve[52], grid[3+8*5], grid[4+8*5], grid[5+8*5], grid[11+8*5], grid[13+8*5], grid[19+8*5], grid[20+8*5], grid[21+8*5], grid_evolve_reg[52]);
   evolve8 e6_5 (grid_evolve[53], grid[4+8*5], grid[5+8*5], grid[6+8*5], grid[12+8*5], grid[14+8*5], grid[20+8*5], grid[21+8*5], grid[22+8*5], grid_evolve_reg[53]);
   evolve8 e6_6 (grid_evolve[54], grid[5+8*5], grid[6+8*5], grid[7+8*5], grid[13+8*5], grid[15+8*5], grid[21+8*5], grid[22+8*5], grid[23+8*5], grid_evolve_reg[54]);
   evolve5 e6_7 (grid_evolve[55], grid[6+8*5], grid[7+8*5], grid[14+8*5], grid[22+8*5], grid[23+8*5], grid_evolve[47]);
   
   evolve3 e7_0 (grid_evolve[56], grid[0+8*6], grid[1+8*6], grid[9+8*6], grid_evolve_reg[56]);
   evolve5 e7_1 (grid_evolve[57], grid[0+8*6], grid[1+8*6], grid[2+8*6], grid[8+8*6], grid[10+8*6], grid_evolve_reg[57]);
   evolve5 e7_2 (grid_evolve[58], grid[1+8*6], grid[2+8*6], grid[3+8*6], grid[9+8*6], grid[11+8*6], grid_evolve_reg[58]);
   evolve5 e7_3 (grid_evolve[59], grid[2+8*6], grid[3+8*6], grid[4+8*6], grid[10+8*6], grid[12+8*6], grid_evolve_reg[59]);
   evolve5 e7_4 (grid_evolve[60], grid[3+8*6], grid[4+8*6], grid[5+8*6], grid[11+8*6], grid[13+8*6], grid_evolve_reg[60]);
   evolve5 e7_5 (grid_evolve[61], grid[4+8*6], grid[5+8*6], grid[6+8*6], grid[12+8*6], grid[14+8*6], grid_evolve_reg[61]);
   evolve5 e7_6 (grid_evolve[62], grid[5+8*6], grid[6+8*6], grid[7+8*6], grid[13+8*6], grid[15+8*6], grid_evolve_reg[62]);
   evolve3 e7_7 (grid_evolve[63], grid[6+8*6], grid[7+8*6], grid[14+8*6], grid_evolve_reg[63]);  
 
endmodule // top


module evolve3 (next_state, vector1, vector2, vector3, current_state);
	
   input logic  vector1;
   input logic  vector2;
   input logic  vector3;
   input logic  current_state;
   output logic next_state;
   
   logic [3:0] 	sum;
   
   assign sum = vector1 + vector2 + vector3;
   rules r1 (sum, current_state, next_state);
   
endmodule // evolve3

module evolve5 (next_state, vector1, vector2, vector3, 
		vector4, vector5, current_state);
   
   input logic   vector1;
   input logic 	 vector2;
   input logic 	 vector3;
   input logic 	 vector4;
   input logic 	 vector5;
   input logic 	 current_state;
   output logic  next_state;
   
   logic [3:0] 	 sum;
   
   assign sum = vector1 + vector2 + vector3 + vector4 + vector5;
   rules r1 (sum, current_state, next_state);
   
endmodule // evolve5


module evolve8 (next_state, vector1, vector2, vector3, 
		vector4, vector5, vector6, 
		vector7, vector8, current_state);
   
   input logic 	vector1;
   input logic 	vector2;
   input logic 	vector3;
   input logic 	vector4;
   input logic 	vector5;
	
   input logic 	vector6;
   input logic 	vector7;
   input logic 	vector8;
   input logic 	current_state;
   output logic next_state;
   
   logic [3:0] 	sum;
   
   assign sum = vector1 + vector2 + vector3 + vector4 + 
		vector5 + vector6 + vector7 + vector8;
   rules r1 (sum, current_state, next_state);
   
endmodule // evolve8


module rules (pop_count, current_state, next_state);
   
   input logic [3:0] pop_count;
   input logic 	     current_state;
   output logic      next_state;
   
   assign next_state = (pop_count == 2 & current_state) | pop_count == 3;
   
endmodule // rules





