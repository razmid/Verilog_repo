//module for fibonacci with RCA & 4bit Register
module Fibo_Gen (Clk, Reset, Fibo_out);
	input Clk, Reset;
	output [3:0] Fibo_out;
  wire [3:0] fn_1, fn_2;
  wire [3:0] dn_1;
	wire cout;
  Reg_4_Reset_1 Reg_4_0 (.clk(Clk), .reset(Reset), .D(dn_1), .Q(fn_1));
  Reg_4_Reset_0 Reg_4_1 (.clk(Clk), .reset(Reset), .D(fn_1), .Q(fn_2));
  Rip_Car_Add RCA_1 (.A(fn_1), .B(fn_2), .cin(0), .SUM(dn_1), .cout(cout));
	assign Fibo_out = fn_2;
endmodule