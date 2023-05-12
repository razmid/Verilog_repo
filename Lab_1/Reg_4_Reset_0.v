module Reg_4_Reset_0 (clk, reset, D, Q);
  input clk, reset;
  input [3:0] D;
  output reg [3:0] Q;
  d_ff #(1'b0) d_ff0 (.clk(clk), .reset(reset), .d(D[0]), .q(Q[0]));
  d_ff #(1'b0) d_ff0 (.clk(clk), .reset(reset), .d(D[1]), .q(Q[1]));
                                          d_ff #(1'b0) d_ff0 (.clk(clk), .reset(reset), .d(D[2]), .q(Q[2]));
                                                              d_ff #(1'b0) d_ff0 (.clk(clk), .reset(reset), .d(D[3]), .q(Q[3]));
endmodule