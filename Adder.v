module Adder(A, B, Cin, Cout, F);
	input [63:0] A, B;
	input Cin;
	
	output [63:0]F;
	output Cout;
	
	assign {Cout, F} = A + B + Cin;
endmodule
