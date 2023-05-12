//Test Bench
`timescale 1ns / 1ps
module testfibo;
// Inputs
  reg Clock, N_valid;
  reg [2:0] N;
  wire Fibo_valid;
  
// Outputs
  wire [3:0] N_Fibo_num;
// Instantiate the Unit Under Test (UUT)
  Fibonacci uut (.N_valid(N_valid), .N(N), .Clock(Clock), .Fibo_valid(Fibo_valid), .N_Fibo_num(N_Fibo_num));
// Initialize Inputs
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
	Clock = 1;
      
	N_valid = 1'b1;
    N = 3'b100;  
	#12 N_valid = 1'b0;
    end
//Toggle Clock signal
  always
    begin
      #5 Clock = ~Clock;
    end
//Terminate Simulation after 250 units of time
  initial
    begin
      #250 $finish;
    end
endmodule
