//Module for Control Path is defined here
module control_path (input clk, reset, N_valid, i_eq_0, j_eq_i,
                     output reg i_mux_sel, j_mux_sel, i_en, i_acc_mux_sel, sum_valid);
  //State register and next state reg are defined here
  reg [1:0] state, nextstate;
  //State values are assigned here
  localparam IDLE = 2'b00;
  localparam BUSY = 2'b01;
  localparam DONE = 2'b10;
  // Next state logic (Combinational Logic) Defined here
  always@(*)
    case (state)
      IDLE: 
        begin
        i_mux_sel = 0;
        j_mux_sel = 0;
        i_en = 1;
        i_acc_mux_sel = 0;
        sum_valid = 0;
          if (N_valid)
          nextstate = BUSY;
        end
      BUSY:
        begin
        if (j_eq_i)
          begin
            i_mux_sel = 1;
            j_mux_sel = 0;
            i_en = 1;
            i_acc_mux_sel = 1;
            sum_valid = 0;
          end
      else 
        begin
            j_mux_sel = 1;
            i_en = 0;
            i_acc_mux_sel = 1;
            sum_valid = 0;
        end
      if (i_eq_0)
        begin
          i_en = 0;
          sum_valid = 1;
          nextstate = DONE;
        end
        end
      DONE: 
        begin
          nextstate = IDLE;
          sum_valid = 0;
        end 
    endcase
  //State Register Assignment with asynchronous reset)
  always @(posedge clk or posedge reset)
    begin
      if (reset)
        state <= IDLE;
      else
        state <= nextstate;
    end
endmodule