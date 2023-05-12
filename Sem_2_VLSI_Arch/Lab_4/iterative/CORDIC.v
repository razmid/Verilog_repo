// Code your design here
module CORDIC (x_in, y_in, in_val, out_val, q_in, clk, reset, cosq, sinq, q_out, ready);
  parameter width = 'd16;
  input signed [width-1:0] x_in, y_in, q_in;
  input in_val, clk, reset;
  output signed [width-1:0] cosq, sinq, q_out;
  output reg out_val, ready;
  
  reg [width-1:0] x, y, q;
  wire [width-1:0] x_mux_out, y_mux_out, q_mux_out;
  reg [width-1:0] x_add_out, y_add_out, q_add_out;
  reg [width-1:0] x_shift_out, y_shift_out, tanout;
  reg [3:0] counter;
  reg load_en;
  wire sx, sy;
  
  //States
  localparam IDLE = 2'b00;
  localparam BUSY = 2'b01;
  localparam DONE = 2'b10;
  
  reg [1:0] state, next_state;
  //Lookup Table (CORDIC Angles)
  always @ (*)
    begin
      case (counter)
        4'b0000: tanout = 16'h3244;
        4'b0001: tanout = 16'h1DAC;
        4'b0010: tanout = 16'h0FAE;
        4'b0011: tanout = 16'h07F5;
        4'b0100: tanout = 16'h03FF;
        4'b0101: tanout = 16'h0200;
        4'b0110: tanout = 16'h0100;
        4'b0111: tanout = 16'h0080;
        4'b1000: tanout = 16'h0040;
        4'b1001: tanout = 16'h0020;
        4'b1010: tanout = 16'h0010;
        4'b1011: tanout = 16'h0008;
        4'b1100: tanout = 16'h0004;
        4'b1101: tanout = 16'h0002;
        4'b1110: tanout = 16'h0001;
        4'b1111: tanout = 16'h0000;
      endcase
    end
   //Adder Subtractor 
  always @ (*)
    begin
      if (!q[width-1])
        begin
          x_add_out = x - y_shift_out;
          y_add_out = y + x_shift_out;
          q_add_out = q - tanout;
        end
      else
        begin
          x_add_out = x + y_shift_out;
          y_add_out = y - x_shift_out;
          q_add_out = q + tanout;
        end
    end
    //Registers
  always @ (posedge clk)
    begin
      if (load_en)
        begin 
          x <= x_mux_out;
          y <= y_mux_out;
          q <= q_mux_out;
          counter <= counter+1;
          
        end
    end
  
    //Barrel Shifter
  always @ (*)
    begin

      
    case (counter)
      4'b0000: begin x_shift_out = x; y_shift_out = y;end
      4'b0001: begin x_shift_out = {sx, x[width-1:1]}; y_shift_out = {sy, y[width-1:1]};end
      4'b0010: begin x_shift_out = {sx, sx, x[width-1:2]}; y_shift_out = {sy, sy, y[width-1:2]};end
      4'b0011: begin x_shift_out = {sx, sx, sx, x[width-1:3]}; y_shift_out = {sy, sy, sy, y[width-1:3]};end
      4'b0100: begin x_shift_out = {sx, sx, sx, sx, x[width-1:4]}; y_shift_out = {sy, sy, sy, sy, y[width-1:4]};end
      4'b0101: begin x_shift_out = {sx, sx, sx, sx, sx, x[width-1:5]}; y_shift_out = {sy, sy, sy, sy, sy, y[width-1:5]};end
      4'b0110: begin x_shift_out = {sx, sx, sx, sx, sx, sx, x[width-1:6]}; y_shift_out = {sy, sy, sy, sy, sy, sy, y[width-1:6]};end
      4'b0111: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, x[width-1:7]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, y[width-1:7]};end
      4'b1000: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx,  x[width-1:8]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:8]};end
      4'b1001: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:9]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:9]};end
      4'b1010: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:10]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:10]};end
      4'b1011: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:11]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:11]};end
      4'b1100: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:12]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:12]};end
      4'b1101: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:13]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:13]};end
      4'b1110: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:14]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:14]};end
      4'b1111: begin x_shift_out = {sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, sx, x[width-1:15]}; y_shift_out = {sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, sy, y[width-1:15]};end
      default: begin x_shift_out = x; y_shift_out = y;end
    endcase
    end
    //Multiplexers
  assign sx = x[width-1];
  assign sy = y[width-1];
  assign x_mux_out = state[0] ? x_add_out : x_in;
  assign y_mux_out = state[0] ? y_add_out : y_in + 16'h26DD;
  assign q_mux_out = state[0] ? q_add_out : q_in-16'h3244;
  assign cosq = state[1] ? x : 'h0;
  assign sinq = state[1] ? y : 'h0;
  assign q_out = state[1] ? q : 'h0;
 
  //control FSM
  always @ (*)
    begin
      case (state)
        IDLE:
          begin
            load_en = 1;
            counter = 4'b0;
            next_state = IDLE;
            out_val = 0;
            ready =1;
            if (in_val)
              begin
                next_state = BUSY;
                ready = 0;
              end
          end
        BUSY:
          begin
            if (counter == 'hF)
              begin
                next_state = DONE;
                load_en = 0;
              end
            else
              begin
                load_en = 1;
                out_val = 0;
                next_state = BUSY;
              end
          end
        DONE:
          begin
            out_val = 1;
            next_state = IDLE;
          end
        default:
          next_state = IDLE; 
      endcase
    end
    //State Registers
  always @ (posedge clk or posedge reset)
    begin
      if (reset)
        state <= IDLE;
      else
        state <= next_state;        
    end
endmodule     
