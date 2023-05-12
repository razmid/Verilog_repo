// Code your design here
module FSM (input clk, input x, input reset, output detect);
  reg [2:0] state, next_state;
  parameter S0 = 3'b000;
  parameter S1 = 3'b001;
  parameter S2 = 3'b010;
  parameter S3 = 3'b011;
  parameter S4 = 3'b100;
  //State Register
  always@posedge(clk)
    begin
      if (reset) state <= S0;
      else state <= next_state;
    end
  //Next State Logic
  always @ (*)
    begin
      case (state)
        S0: if (x) next_state = S1 else next_state = S0;
        S1: if (x) next_state = S1 else next_state = S2;
        S2: if (x) next_state = S3 else next_state = S0;
        S3: if (x) next_state = S4 else next_state = S2;
        S4: if (x) next_state = S1 else next_state = S2;
      endcase
    end
  //Output Logic
  assign detect = (state == S3);
endmodule
