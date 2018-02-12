module ALUTestbench();
	wire [63:0]F;
	reg [63:0] A, B;
	wire [3:0]status;
	reg [4:0]FS;
	
	ALU dut(A, B, FS, status, F);
	
	initial begin
		FS <= 5'b00000; //AND
		A <= 64'd2;
		B <= 64'd5;
		#5 FS <= 5'b00100; //OR
		#5 FS <= 5'b01000; //ADD
		A <= 64'd1;
		B <= 64'd15;
		#5 FS <= 5'b01001; //SUB
		#5 FS <= 5'b10000; //Shift Left
		#5 FS <= 5'b10100; // Shift Right
		A <= 64'h8000000000000000;
		#5 FS <= 5'b01100; //XOR
		A <= 64'd3;
		B <= 64'd6;
		#5 $stop;
	end
endmodule
