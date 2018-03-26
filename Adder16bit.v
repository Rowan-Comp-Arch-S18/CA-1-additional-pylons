module Adder16bit(A, B, Cin, Cout, F);
	input [15:0] A, B; //16b inputs
	input Cin; //1b carry-in
	
	output [15:0] F; //16b output
	output Cout; //1b carry-out
	
	assign {Cout, F} = A + B + Cin; //add, overflow goes to carry-out
endmodule
