module Shifter(A, offset, left, right);
	input [63:0] A; //64b input
	input [5:0] offset; //6b shift amount
	
	output [63:0] left, right; //64b outputs
	
	assign left = A << offset; //shift A by offset bits to the left
	assign right = A >> offset; //shift A by offset bits to the right
endmodule
