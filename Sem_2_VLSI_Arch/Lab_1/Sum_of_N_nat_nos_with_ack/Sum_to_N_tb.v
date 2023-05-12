// Testbench for Sum to N Numbers design
module Sum_to_N_tb;
  //Inputs to the DUT defined as reg
  reg N_valid,clk,ack,reset;
  reg [2:0] N;
  //Nets declared for the outputs from DUT
  wire sum_valid;
  wire [4:0] sum;
   // DUT instantiation
  sum_to_N_top model_1(.N(N), .N_valid(N_valid),.clk(clk), .sum(sum), .sum_valid(sum_valid), .reset(reset), .ack(ack));
  // Clock signal generated
  always #5 clk = ~clk;
  // For the wave window
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end
  //Stimulus generation
  initial
    begin
      clk = 0;
      reset = 0;
      N_valid = 0;
      ack = 0;
      N = 3;
      #10
      reset = 1;
      #10
      reset = 0;
      N_valid = 1;
      #10
      N_valid = 0;
      #10
      N = 4;
      N_valid = 1;
      #10
      N_valid = 0;
      #40
      ack = 1;
      N = 5;
      N_valid = 1;
      #10
      ack = 0;
      N_valid = 0;
      #180
      $finish;
    end
 endmodule