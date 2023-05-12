// GCD testbench

module gcd_tb;
  
  reg op_valid,clk,ack,reset;
  reg [5:0] A_in,B_in;
  
  wire gcd_valid;
  wire [5:0] gcd;
  
  
  gcd_top model_1(.A_in(A_in),.B_in(B_in),.op_valid(op_valid),.clk(clk),.gcd(gcd),.gcd_valid(gcd_valid),.reset(reset),.ack(ack));
  
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
      op_valid = 0;
      ack = 0;
      A_in = 6'b100100;
      B_in = 6'b110000;
      #10
      reset = 1;
      #10
      reset = 0;
      op_valid = 1;
      #10
      op_valid = 0;
      #100
      ack = 1;
      #20 
      ack = 0;
      A_in = 6'b111100;
      B_in = 6'b011001;
      op_valid = 1;
      
     #10
      op_valid = 0;
      #180
      $finish;
    end
  
endmodule

