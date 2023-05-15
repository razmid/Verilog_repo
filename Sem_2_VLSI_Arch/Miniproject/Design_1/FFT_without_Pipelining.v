// Code your design here
`timescale 1 ns/1 ns
module dit_fft_8(clk,reset,x,y);
  // Input Output Declarations
  input clk;
  input signed [15:0] x[0:7][0:1];
  input reset;
  output reg signed [15:0] y [0:7][0:1];
  //Reg and Wire Declarations
  wire signed [15:0] ywire [0:7][0:1];
  reg signed [15:0] xreg [0:7][0:1];
  wire signed [15:0] y0r,y1r,y2r,y3r,y4r,y5r,y6r,y7r,y0i,y1i,y2i,y3i,y4i,y5i,y6i,y7i;
  wire signed [15:0] x20r,x20i,x21r,x21i,x22r,x22i,x23r,x23i,x24r,x24i,x25r,x25i,x26r,x26i,x27r,x27i;
  wire signed [15:0] x10r,x10i,x11r,x11i,x12r,x12i,x13r,x13i,x14r,x14i,x15r,x15i,x16r,x16i,x17r,x17i;
  wire signed [15:0] x0,x1,x2,x3,x4,x5,x6,x7;
  wire signed [15:0] wn2x13r, wn2x13i, wn2x17r, wn2x17i, wn2x26r, wn2x26i;
  wire signed [31:0] wn1x25r, wn1x25i, wn3x27r, wn3x27i;
  wire signed [15:0] wn1x25rr, wn1x25ir, wn3x27rr, wn3x27ir;
// Filter Coefficients
parameter w0r=16'sh0FFF;
parameter w0i=16'sh0000;
parameter w1r=16'sh0B50;//0.707=0.10110101
parameter w1i=16'shF4B0;//-0.707=1.01001011
parameter w2r=16'sh0000;
parameter w2i=16'shF000;//-1
parameter w3r=16'shF4B0;//-0.707=1.01001011
parameter w3i=16'shF4B0;//-0.707=1.01001011
//Registers
always @ (posedge clk or posedge reset)
begin
    if (reset)
        begin
            xreg[0][0] <= 16'sh0000;xreg[0][1] <= 16'sh0000;
            xreg[1][0] <= 16'sh0000;xreg[1][1] <= 16'sh0000;
            xreg[2][0] <= 16'sh0000;xreg[2][1] <= 16'sh0000;
            xreg[3][0] <= 16'sh0000;xreg[3][1] <= 16'sh0000;
            xreg[4][0] <= 16'sh0000;xreg[4][1] <= 16'sh0000;
            xreg[5][0] <= 16'sh0000;xreg[5][1] <= 16'sh0000;
            xreg[6][0] <= 16'sh0000;xreg[6][1] <= 16'sh0000;
            xreg[7][0] <= 16'sh0000;xreg[7][1] <= 16'sh0000;
            y[0][0] <= 16'sh0000; y[0][1] <= 16'sh0000;
            y[1][0] <= 16'sh0000; y[1][1] <= 16'sh0000;
            y[2][0] <= 16'sh0000; y[2][1] <= 16'sh0000;
            y[3][0] <= 16'sh0000; y[3][1] <= 16'sh0000;
            y[4][0] <= 16'sh0000; y[4][1] <= 16'sh0000;
            y[5][0] <= 16'sh0000; y[5][1] <= 16'sh0000;
            y[6][0] <= 16'sh0000; y[6][1] <= 16'sh0000;
            y[7][0] <= 16'sh0000; y[7][1] <= 16'sh0000;
        end
    else
        xreg <= x;
        y<= ywire;
end


//stage1 
  bfly4_4 s11(.xr(xreg[0][0]),.xi(xreg[0][1]), .yr(xreg[4][0]), .yi(xreg[4][1]), .x0r(x10r), .x0i(x10i),.x1r(x11r), .x1i(x11i));
  bfly4_4 s12(.xr(xreg[2][0]),.xi(xreg[2][1]), .yr(xreg[6][0]), .yi(xreg[6][1]), .x0r(x12r), .x0i(x12i),.x1r(x13r), .x1i(x13i));
  bfly4_4 s13(.xr(xreg[1][0]),.xi(xreg[1][1]), .yr(xreg[5][0]), .yi(xreg[5][1]), .x0r(x14r), .x0i(x14i),.x1r(x15r), .x1i(x15i));
  bfly4_4 s14(.xr(xreg[3][0]),.xi(xreg[3][1]), .yr(xreg[7][0]), .yi(xreg[7][1]), .x0r(x16r), .x0i(x16i),.x1r(x17r), .x1i(x17i));
  assign wn2x13r = x13i;
  assign wn2x13i = -(x13r);
  assign wn2x17r = x17i;
  assign wn2x17i = -(x17r);
//stage2
  bfly4_4 s21(.xr(x10r),.xi(x10i), .yr(x12r), .yi(x12i), .x0r(x20r), .x0i(x20i),.x1r(x22r), .x1i(x22i));
  bfly4_4 s22(.xr(x11r),.xi(x11i), .yr(wn2x13r), .yi(wn2x13i), .x0r(x21r), .x0i(x21i),.x1r(x23r), .x1i(x23i));
  bfly4_4 s23(.xr(x14r),.xi(x14i), .yr(x16r), .yi(x16i), .x0r(x24r), .x0i(x24i),.x1r(x26r), .x1i(x26i));
  bfly4_4 s24(.xr(x15r),.xi(x15i), .yr(wn2x17r), .yi(wn2x17i), .x0r(x25r), .x0i(x25i),.x1r(x27r), .x1i(x27i));
  assign wn1x25r = (w1r * x25r) - (w1i * x25i) + 32'sh00000800;
  assign wn1x25i = (w1r * x25i) + (w1i * x25r) + 32'sh00000800;
  assign wn2x26r = x26i;
  assign wn2x26i = -(x26r);
  assign wn3x27r = (w3r * x27r) - (w3i * x27i) + 32'sh00000800;
  assign wn3x27i = (w3r * x27i) + (w3i * x27r) + 32'sh00000800;
  assign wn1x25rr = wn1x25r[27:12];
  assign wn1x25ir = wn1x25i[27:12];
  assign wn3x27rr = wn3x27r[27:12];
  assign wn3x27ir = wn3x27i[27:12];
  
//stage3
  bfly4_4 s31(.xr(x20r),.xi(x20i), .yr(x24r), .yi(x24i), .x0r(ywire[0][0]), .x0i(ywire[0][1]),.x1r(ywire[4][0]), .x1i(ywire[4][1]));
  bfly4_4 s32(.xr(x21r),.xi(x21i), .yr(wn1x25rr), .yi(wn1x25ir), .x0r(ywire[1][0]), .x0i(ywire[1][1]),.x1r(ywire[5][0]), .x1i(ywire[5][1]));
  bfly4_4 s33(.xr(x22r),.xi(x22i), .yr(wn2x26r), .yi(wn2x26i), .x0r(ywire[2][0]), .x0i(ywire[2][1]),.x1r(ywire[6][0]), .x1i(ywire[6][1]));
  bfly4_4 s34(.xr(x23r),.xi(x23i), .yr(wn3x27rr), .yi(wn3x27ir), .x0r(ywire[3][0]), .x0i(ywire[3][1]),.x1r(ywire[7][0]), .x1i(ywire[7][1]));
 
endmodule


