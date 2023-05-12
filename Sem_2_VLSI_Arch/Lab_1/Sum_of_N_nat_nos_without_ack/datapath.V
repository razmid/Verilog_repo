// Datapath Module

module datapath(input [2:0] N, input [1:0] state, input clk, output reg [4:0]sum, output i_eq_1);
  //Net declarations
  wire [4:0] add_out;
  wire [2:0] i_mux_out;
  wire [4:0] sum_mux_out;
  // register declaration
  reg [2:0] i;
  //Combinational part
  assign i_mux_out = state[1] ? i : state[0] ? i-1 : N;
  assign sum_mux_out = state[1] ? sum : state[0] ? add_out : 0;
  assign add_out = i + sum;
  assign i_eq_1 = (i==1);
  //regiister part
  always @(posedge clk)
    begin
      i <= i_mux_out;
      sum <= sum_mux_out;
    end  
  
endmodule