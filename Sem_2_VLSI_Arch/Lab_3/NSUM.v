// Top Module defined here
module NSUM (input [2:0] N, 
             input clk, reset, N_valid,
             output sum_valid,
             output [7:0] sum);
  // Internal Wires Declared Here
  wire i_mux_sel, j_mux_sel, i_en, i_acc_mux_sel, i_eq_0, j_eq_i;
  //Data Path and Control Path Instantiated Here
  data_path D0(.N(N), .clk(clk), .i_mux_sel(i_mux_sel), .j_mux_sel(j_mux_sel), .i_en(i_en), .i_acc_mux_sel(i_acc_mux_sel), .i_eq_0(i_eq_0), .j_eq_i(j_eq_i), .sum(sum));
  control_path C0(.clk(clk), .reset(reset), .N_valid(N_valid), .i_eq_0(i_eq_0), .j_eq_i(j_eq_i), .i_mux_sel(i_mux_sel), .j_mux_sel(j_mux_sel), .i_en(i_en), .i_acc_mux_sel(i_acc_mux_sel), .sum_valid(sum_valid));
endmodule


