 // Top module

module sum_to_N_top(input clk,N_valid,reset, input [2:0] N, output sum_valid, output [4:0] sum);
  
  // net declarations
  wire i_eq_1;
  wire [1:0] state;
  // module instantiations
  datapath data1(.N(N), .state(state), .clk(clk), .sum(sum), .i_eq_1(i_eq_1));
  controlpath control1(.N_valid(N_valid), .reset(reset), .clk(clk), .i_eq_1(i_eq_1), .state(state), .sum_valid(sum_valid));

endmodule