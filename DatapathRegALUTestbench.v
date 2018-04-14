module DatapathRegALUTestbench();
	reg reset, clock;
	reg [63:0]K;
	wire [4:0] status;
	wire [63:0] data;
	reg [30:0] controlWord;
	
	DatapathRegALU dut(controlWord, reset, clock, K, status, data);
	
	// R5 <= 24
	// R7 <= 39
	// R1 <= R5 + R7
	// R30 <= R1 ^ R5
	// R17 <= R30 << 2
	// M[R7] <= R17
	// R0 <= M[R7]
	// R0 <= R0 + 4
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b0;
		
		// DA = 00101, SA = 11111, SB = N/A, FS = 00100, regW = 1, ramW = 0, selALU = 1, selK = 1
		// PS = 01, DA = 00101, SA = 11111, SB = 11111, FS = 00100, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		// #1 controlWord <= 24'b001011111100000001001011;
		#1 controlWord <= 31'b01_00101_11111_11111_00100_10_0100_1_0_0;
		K <= 64'd24;
		
//		// DA = 00111, SA = 11111, SB = N/A, FS = 00100, regW = 1, ramW = 0, selALU = 1, selK = 1
//		#10 controlWord <= 24'b001111111100000001001011;
//		K <= 64'd39;
//		
//		// DA = 00001, SA = 00101, SB = 00111, FS = 01000, regW = 1, ramW = 0, selALU = 1, selK = 0
//		#10 controlWord <= 24'b000010010100111010001010;
//		
//		// DA = 11110, SA = 00001, SB = 00101, FS = 01100, regW = 1, ramW = 0, selALU = 1, selK = 0
//		#10 controlWord <= 24'b111100000100101011001010;
//		
//		// DA = 10001, SA = 11110, SB = N/A, FS = 10000, regW = 1, ramW = 0, selALU = 1, selK = 1
//		#10 controlWord <= 24'b100011111000000100001011;
//		K <= 64'd2;
//		
//		// DA = N/A, SA = 00111, SB = 10001, FS = 00100, regW = 0, ramW = 1, selALU = 1, selK = 1
//		#10 controlWord <= 24'b000000011110001001000111;
//		K <= 64'd0;
//		
//		// DA = 00000, SA = 00111, SB = N/A, FS = 00100, regW = 1, ramW = 0, selALU = 0, selK = 1
//		#10 controlWord <= 24'b000000011100000001001001;
//		K <= 64'd0;
//		
//		// DA = 00000, SA = 00000, SB = N/A, FS = 01000, regW = 0, ramW = 0, selALU = 1, selK = 1
//		#10 controlWord <= 24'b000000000000000010000011;
//		K <= 64'd4;
		#15 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
