//FIR filter Module
module fir (x, clk, reset, y);
  input signed [15:0] x;
  input clk, reset;
  output signed [15:0] y;
  //Reg and wire declarations
  reg signed [15:0] xreg [0:7];
  wire signed [31:0] m0, m1, m2, m3, m4, m5, m6, m7;
  wire signed [15:0] a1, a2, a3, a4, a5, a6;
  // Register Implementations
  always@ (posedge clk or posedge reset)
    begin
      if (reset)
        begin
          xreg[0] <= 16'b0;
          xreg[1] <= 16'b0;
          xreg[2] <= 16'b0;
          xreg[3] <= 16'b0;
          xreg[4] <= 16'b0;
          xreg[5] <= 16'b0;
          xreg[6] <= 16'b0;
          xreg[7] <= 16'b0;
        end
      else
        begin
          xreg[0] <= x;
          xreg[1] <= xreg[0];
          xreg[2] <= xreg[1];
          xreg[3] <= xreg[2];
          xreg[4] <= xreg[3];
          xreg[5] <= xreg[4];
          xreg[6] <= xreg[5];
          xreg[7] <= xreg[6];
          end
    end
    // Scalar multiplications
  assign m0 = xreg[0]*$signed(16'hFEA8) + 32'sh00000800;
  assign m1 = xreg[1]*$signed(16'hFF18) + 32'sh00000800;
  assign m2 = xreg[2]*$signed(16'h02EC) + 32'sh00000800;
  assign m3 = xreg[3]*$signed(16'h068A) + 32'sh00000800;
  assign m4 = xreg[4]*$signed(16'h068A) + 32'sh00000800;
  assign m5 = xreg[5]*$signed(16'h02EC) + 32'sh00000800;
  assign m6 = xreg[6]*$signed(16'hFF18) + 32'sh00000800;
  assign m7 = xreg[7]*$signed(16'hFEA8) + 32'sh00000800;
  // Signal Additions
  assign a1 = m0[27:12] + m1[27:12];
  assign a2 = a1 + m2[27:12];
  assign a3 = a2 + m3[27:12];
  assign a4 = a3 + m4[27:12];
  assign a5 = a4 + m5[27:12];
  assign a6 = a5 + m6[27:12];
  assign y = a6 + m7[27:12];
 
endmodule