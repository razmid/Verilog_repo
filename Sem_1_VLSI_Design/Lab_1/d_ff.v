//Module for generic d ff
module d_ff #(parameter reset_value = 1'b0)(clk, reset, d, q);
  input clk, reset, d;
  output reg q;
  always @(posedge clk or negedge reset)
    begin
      if (!reset)
        q<= reset_value;
      else
        q<=d;
    end
endmodule