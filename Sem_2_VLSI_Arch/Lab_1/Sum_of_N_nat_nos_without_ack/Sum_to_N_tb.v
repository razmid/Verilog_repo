// Testbench for Sum to N Numbers design

module Sum_to_N_tb;
  
  reg N_valid,clk,reset;
  reg [2:0] N;
  
  wire sum_valid;
  wire [4:0] sum;
  
  
  sum_to_N_top model_1(.N(N),.N_valid(N_valid),.clk(clk),.sum(sum),.sum_valid(sum_valid),.reset(reset));
  
  always #5 clk = ~clk;
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end
  
  initial
    begin
      clk = 0;
      reset = 0;
      N_valid = 0;
      
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
      N = 7;
      N_valid = 1;
      #10     
      N_valid = 0;
      #10
      N_valid = 0;
      #180
      $finish;
    end
  
endmodule
