//Module Definition
module Fibonacci_N(N_valid, N, Clock, Fibo_valid, N_Fibo_num);
  input N_valid, Clock;
  input [2:0] N;
  output [3:0] N_Fibo_num;
  output Fibo_valid;
  //Reg & Wire declarations
  reg [3:0] counter_out;
  wire [3:0] counter_in, sum, D0, D1, Fibo_out;
  reg [3:0] R0, R1;
    
  //Sequential part
  always @ (posedge Clock)
    begin
      counter_out <= counter_in;
      R0<=D0;
      R1<=D1;
    end
    //Combinational part
  assign counter_in = N_valid ? N: counter_out-1;
  assign Fibo_valid = ~(counter_out[2]|counter_out[1]|~counter_out[0]);
  assign N_Fibo_num = Fibo_valid ? Fibo_out:4'b0;
  assign sum = R0+R1;
  assign D0 = N_valid? 4'b1: sum;
  assign D1 = N_valid? 4'b0: R0;
  assign Fibo_out = R1;
endmodule


      
             
  
