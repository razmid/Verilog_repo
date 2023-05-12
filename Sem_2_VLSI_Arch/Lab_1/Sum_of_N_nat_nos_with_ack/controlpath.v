// Control Path Module
module controlpath(input N_valid, reset, ack, clk, i_eq_1, 
                   output [1:0] state, 
                   output sum_valid);

  // local parameters (states)
  localparam idle = 2'b00;
  localparam busy = 2'b01;
  localparam done = 2'b10;

  // state register
  reg [1:0] state = 2'b0;
  // Next state reg
  reg [1:0] next_state;
  // Next state combinational logic
  always @(*)
    begin
      case (state)
        idle:
          if (N_valid)
            next_state = busy;
        busy:
          if(i_eq_1)
            next_state = done ;
        done:
          if (ack)
            next_state = idle;
        default:
            next_state = idle;
      endcase
    end
  //State Register (Sequential logic)
  always @(posedge clk or posedge reset)
    begin
      if (reset)
        state <= idle;
      else
        state <= next_state;
    end
  //Qualifier signal 
  assign sum_valid = (state[1]);
endmodule