//4 x 4 Butterfly Module
module bfly4_4(xr,xi,yr,yi,x0r,x0i,x1r,x1i); 
  input signed [15:0]xr,xi,yr,yi;
  output signed [15:0]x0r,x0i,x1r,x1i;
  assign x0r=xr+yr;
  assign x0i=xi+yi;
  assign x1r=xr-yr;
  assign x1i=xi-yi;
endmodule