// Control Path Module

module controlpath(input N_valid, reset, clk, i_eq_1, output [1:0] state, output sum_valid);
  //local parameters declaration (states)
  localparam idle = 2'b00;
  localparam busy = 2'b01;
  localparam done1 = 2'b10;
  localparam done2 = 2'b11;
  //state register declaration
  reg [1:0] state = 2'b0;
  reg [1:0] next_state;
  //Next state logic (combinational)
  always @(*)
    begin
      case (state)
        idle:
          if (N_valid)
       	    next_state = busy;
        busy:
          if(i_eq_1)
            next_state = done1 ;
        done1:
            next_state = done2;
        done2:
            next_state = idle;
        default:
            next_state = idle;
      endcase
    end
  // State register assignment
  always @(posedge clk or posedge reset)
    begin
      if (reset)
        state <= idle;
      else
        state <= next_state;
    end
  // Qualifier generation
  assign sum_valid = (state[1]);
  
endmodule