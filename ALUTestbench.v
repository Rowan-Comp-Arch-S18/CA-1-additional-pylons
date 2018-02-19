module ALUTestbench();
	reg [63:0] A, B; //64b inputs
	reg [4:0] FS; //5b function select
	
	wire [3:0] status; //4b status
	wire [63:0] F; //64b output
	
	ALU dut(A, B, FS, status, F); //design under test for ALU
	
	initial begin
		FS <= 5'b00000; //and, no invert
		A <= 64'd2; //a gets decimal 2
		B <= 64'd5; //b gets decimal 5
		#5 FS <= 5'b00100; //or, no invert
		#5 FS <= 5'b01000; //add, no invert
		A <= 64'd1; //a gets decimal 1
		B <= 64'd15; //b gets decimal 15
		#5 FS <= 5'b01001; //add, b invert
		#5 FS <= 5'b10000; //shift left
		#5 FS <= 5'b10100; //shift right
		A <= 64'h8000000000000000; // a gets hex 0
		#5 FS <= 5'b01100; //xor, no invert
		A <= 64'd3; //a gets decimal 3
		B <= 64'd6; //b gets decimal 6
		#5 $stop;
	end
endmodule
