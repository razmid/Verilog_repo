//Functional model module defined here    
module NSUM_behav
(
  input [2:0] N,
  output reg [7:0] Y
);
  reg [2:0] inN;
  reg [7:0] i_acc;
  integer i, j;
  always @(*)
   begin
     i_acc = 0;
     inN = N;
     for (i = inN; i > 0; i = i-1) begin
       for (j =1; j<=i; j = j+1) begin
         i_acc = i_acc + i;
       end
     end
     Y = i_acc;
   end
endmodule