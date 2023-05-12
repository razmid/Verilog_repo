                     
//module for FA
module Ful_Add (a, b, cin, sum, cout);
	input a, b, cin;
	output sum, cout;
	wire [2:0] carry;
	assign sum = (a^b^cin);
	assign cout = ((a^b)&cin)|(a&b);
endmodule                  
                  

