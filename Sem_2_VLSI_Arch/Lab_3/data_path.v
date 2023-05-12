// Data Path Module defined here
module data_path(input [2:0] N, 
                 input clk, i_mux_sel, j_mux_sel, i_en, i_acc_mux_sel,
                 output i_eq_0, j_eq_i,
                 output [7:0] sum);
  // Internal Wires Declared Here      
  wire [2:0] i_mux_out, j_mux_out;
  wire [7:0] i_acc_mux_out, add_out;
  //Registers are declared here
  reg [2:0] i, j;
  reg [7:0] i_acc;
  // Combinational Part    
  assign i_eq_0 = (i==0);
  assign j_eq_i = (j==i);
  assign i_mux_out = i_mux_sel ? i-1 : N;
  assign j_mux_out = j_mux_sel ? j+1 : 1;
  assign i_acc_mux_out = i_acc_mux_sel ? add_out : 0;
  assign add_out = i + i_acc;
  assign sum = (i==0)? i_acc: 0;
  //Register Part
  always @(posedge clk)
    begin
      i_acc <= i_acc_mux_out;
      if (i_en) i <= i_mux_out;
      j <= j_mux_out;
    end
endmodule