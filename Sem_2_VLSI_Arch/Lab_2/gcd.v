// GCD Top
module gcd_top(input [5:0] A_in,B_in, input clk,reset,op_valid,ack, output gcd_valid, output [5:0] gcd);
  //Net Declarations
  wire [1:0] A_mux_sel;
  wire B_mux_sel,A_en,B_en,A_lt_B,b_eq_0;
  //Data path and Control path Module instantiation
  gcd_datapath D1 (.A_in(A_in), .B_in(B_in), .clk(clk), .A_en(A_en), .B_en(B_en), .A_mux_sel(A_mux_sel), .B_mux_sel(B_mux_sel), .gcd(gcd), .A_lt_B(A_lt_B), .b_eq_0(b_eq_0));
  
  gcd_controlpath C1(.clk(clk), .reset(reset), .ack(ack), .b_eq_0(b_eq_0), .A_lt_B(A_lt_B), .op_valid(op_valid), .A_mux_sel(A_mux_sel), .B_mux_sel(B_mux_sel), .gcd_valid(gcd_valid), .A_en(A_en), .B_en(B_en));
  
endmodule