// Code your testbench here
module TB_FSM;
  reg reset, clk, x;
  wire [3:0] detect;
  FSM UUT(.clk(clk),.x(x),.reset(reset),.detect(detect));
  initial
    begin
      Clk = 0;
    end
  always
    begin
      #5 Clk = ~Clk;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
      reset = 1'b1;
      x = 0;
      #6 reset = 1'b0;
      x = 1;
      
      
      
      #150 $finish;
    end
endmodule
