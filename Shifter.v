module Shifter(A, offset, left, right);
	input [63:0]A;
	input [5:0]offset;
	
	output [63:0] left, right;
	
	assign left = A << offset;
	assign right = A >> offset;
endmodule
