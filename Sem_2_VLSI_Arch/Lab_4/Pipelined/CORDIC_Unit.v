// Module CORDIC Unit
module CU (clk, reset, xin, yin, qin, mode, delq, shift, xout, yout, qout);
    parameter width = 'd16;
    input clk, reset, mode;
    input signed [width-1:0] xin, yin, qin, delq;
    input [3:0] shift;
    output reg signed [width-1:0] xout, yout, qout;
	wire m; 
    reg signed [width-1:0] x, y, q;
    
    assign m = mode ? (~y[width-1]):q[width-1];
    
    always @(posedge clk or posedge reset)
        begin
            if (reset)
                begin
                    x <= 'h0;
                    y <= 'h0;
                    q <= 'h0;
                end
            else
                begin
                    x <= xin;
                    y <= yin;
                    q <= qin;
                end
        end
    
    always@ (*)
        begin
          if (m)
                begin
                    xout = x + (y>>>shift);
                    yout = y - (x>>>shift);
                    qout = q + delq;
                end
            else 
                begin
                    xout = x - (y>>>shift);
                    yout = y + (x>>>shift);
                    qout = q - delq;
                end
        end
endmodule