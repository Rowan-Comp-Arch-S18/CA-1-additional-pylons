module GPUColorDecoder(colorSelector, colorOut);
	input [1:0] colorSelector;
	output [3:0] colorOut;
	
	Mux4to1Nbit colors(colorSelector, 4'b0000, 4'b0101, 4'b1010, 4'b1111, colorOut);
	defparam colors.N = 4;
endmodule
