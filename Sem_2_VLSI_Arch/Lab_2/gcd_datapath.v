// GCD Datapath

module gcd_datapath(input [5:0] A_in,B_in, input clk,A_en,B_en, input [1:0] A_mux_sel, input B_mux_sel, output [5:0] gcd, output A_lt_B,b_eq_0);
  //Net declarations
  wire [5:0] A_mux_out,B_mux_out,sub_out;
  Register declarations
  reg [5:0] A,B;
  //Combinational part
  assign A_mux_out = A_mux_sel[1] ? B : A_mux_sel[0] ? sub_out : A_in;
  assign B_mux_out = B_mux_sel ? A : B_in;
  assign sub_out = A - B;
  assign b_eq_0 = ( B == 5'b0);
  assign A_lt_B = ( A < B ); 
  assign gcd = ( B == 5'b0) ? A : 0;
  //Sequential part
  always @(posedge clk)
    begin
      if (A_en)
      	A <= A_mux_out;
      if (B_en)
      	B <= B_mux_out;
    end
  
endmodule