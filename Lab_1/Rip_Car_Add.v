                       //module for RCA
module Rip_Car_Add (A, B, cin, SUM, cout);
	input [3:0] A, B;
	input cin;
	output [3:0] SUM;
	output cout;
	wire [2:0] carry;
	wire cout;
  Ful_Add FA_0 (.a(A[0]), .b(B[0]), .cin(cin), .sum(SUM[0]), .cout(carry[0]));
  Ful_Add FA_1 (.a(A[1]), .b(B[1]), .cin(carry[0]), .sum(SUM[1]), .cout(carry[1]));
                              Ful_Add FA_2 (.a(A[2]), .b(B[2]), .cin(carry[1]), .sum(SUM[2]), .cout(carry[2]));
                                            Ful_Add FA_3 (.a(A[3]), .b(B[3]), .cin(carry[2]), .sum(SUM[3]), .cout(cout));
endmodule