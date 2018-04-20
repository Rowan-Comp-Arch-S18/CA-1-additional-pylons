module Adder(A, B, Cin, Cout, F);
	input [63:0] A, B; //64b inputs
	input Cin; //1b carry-in
	
	output [63:0] F; //64b output
	output Cout; //1b carry-out
	
	assign {Cout, F} = A + B + Cin; //add, overflow goes to carry-out
endmodule
