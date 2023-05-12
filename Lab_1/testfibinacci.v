// Code your testbench here
module testfibinacci;
  reg Reset, Clk;
  wire [3:0] Fibo_out;
  Fibo_Gen UUT(.Clk(Clk),.Reset(Reset),.Fibo_out(Fibo_out));
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
      Reset = 1'b0;
      #6 Reset = 1'b1;
      #150 $finish;
    end
endmodule
