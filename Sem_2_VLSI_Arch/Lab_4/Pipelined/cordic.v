// Top Module defined here
module cordic (clk, reset, x, y, q, mode, cosq, sinq, qout);

    parameter width = 'd16;
    input clk, reset, mode;
    input signed [width-1:0] x, y, q;
    output signed [width-1:0] cosq, sinq, qout;
    
    //Internal Wire declaration
    wire [15:0] xw [0:15];
    wire [15:0] yw [0:15];
    wire [15:0] qw [0:15];
    
  //Module Instantiations
  CU CU0 (.clk(clk), .reset(reset), .xin(x), .yin(y), .qin(q), .mode(mode), .delq(16'h3244), .shift(4'b0000), .xout(xw[0]), .yout(yw[0]), .qout(qw[0]));    
  CU CU1 (.clk(clk), .reset(reset), .xin(xw[0]), .yin(yw[0]), .qin(qw[0]), .mode(mode), .delq(16'h1DAC), .shift(4'b0001), .xout(xw[1]), .yout(yw[1]), .qout(qw[1]));
  CU CU2 (.clk(clk), .reset(reset), .xin(xw[1]), .yin(yw[1]), .qin(qw[1]), .mode(mode), .delq(16'h0FAE), .shift(4'b0010), .xout(xw[2]), .yout(yw[2]), .qout(qw[2]));
  CU CU3 (.clk(clk), .reset(reset), .xin(xw[2]), .yin(yw[2]), .qin(qw[2]), .mode(mode), .delq(16'h07F5), .shift(4'b0011), .xout(xw[3]), .yout(yw[3]), .qout(qw[3]));
  CU CU4 (.clk(clk), .reset(reset), .xin(xw[3]), .yin(yw[3]), .qin(qw[3]), .mode(mode), .delq(16'h03FF), .shift(4'b0100), .xout(xw[4]), .yout(yw[4]), .qout(qw[4]));  
  CU CU5 (.clk(clk), .reset(reset), .xin(xw[4]), .yin(yw[4]), .qin(qw[4]), .mode(mode), .delq(16'h0200), .shift(4'b0101), .xout(xw[5]), .yout(yw[5]), .qout(qw[5]));
  CU CU6 (.clk(clk), .reset(reset), .xin(xw[5]), .yin(yw[5]), .qin(qw[5]), .mode(mode), .delq(16'h0100), .shift(4'b0110), .xout(xw[6]), .yout(yw[6]), .qout(qw[6]));
  CU CU7 (.clk(clk), .reset(reset), .xin(xw[6]), .yin(yw[6]), .qin(qw[6]), .mode(mode), .delq(16'h0080), .shift(4'b0111), .xout(xw[7]), .yout(yw[7]), .qout(qw[7]));
  CU CU8 (.clk(clk), .reset(reset), .xin(xw[7]), .yin(yw[7]), .qin(qw[7]), .mode(mode), .delq(16'h0040), .shift(4'b1000), .xout(xw[8]), .yout(yw[8]), .qout(qw[8]));
  CU CU9 (.clk(clk), .reset(reset), .xin(xw[8]), .yin(yw[8]), .qin(qw[8]), .mode(mode), .delq(16'h0020), .shift(4'b1001), .xout(xw[9]), .yout(yw[9]), .qout(qw[9]));
  CU CU10 (.clk(clk), .reset(reset), .xin(xw[9]), .yin(yw[9]), .qin(qw[9]), .mode(mode), .delq(16'h0010), .shift(4'b1010), .xout(xw[10]), .yout(yw[10]), .qout(qw[10]));
  CU CU11 (.clk(clk), .reset(reset), .xin(xw[10]), .yin(yw[10]), .qin(qw[10]), .mode(mode), .delq(16'h0008), .shift(4'b1011), .xout(xw[11]), .yout(yw[11]), .qout(qw[11]));
  CU CU12 (.clk(clk), .reset(reset), .xin(xw[11]), .yin(yw[11]), .qin(qw[11]), .mode(mode), .delq(16'h0004), .shift(4'b1100), .xout(xw[12]), .yout(yw[12]), .qout(qw[12]));
  CU CU13 (.clk(clk), .reset(reset), .xin(xw[12]), .yin(yw[12]), .qin(qw[12]), .mode(mode), .delq(16'h0002), .shift(4'b1101), .xout(xw[13]), .yout(yw[13]), .qout(qw[13]));
  CU CU14 (.clk(clk), .reset(reset), .xin(xw[13]), .yin(yw[13]), .qin(qw[13]), .mode(mode), .delq(16'h0001), .shift(4'b1110), .xout(xw[14]), .yout(yw[14]), .qout(qw[14]));
  CU CU15 (.clk(clk), .reset(reset), .xin(xw[14]), .yin(yw[14]), .qin(qw[14]), .mode(mode), .delq(16'h0000), .shift(4'b1111), .xout(xw[15]), .yout(yw[15]), .qout(qw[15]));

    // Output Signal Assignment
    assign cosq = xw[15];
    assign sinq = yw[15];
    assign qout = qw[15];

endmodule


