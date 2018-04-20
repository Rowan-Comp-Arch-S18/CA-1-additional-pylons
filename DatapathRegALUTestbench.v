module DatapathRegALUTestbench();
	reg reset, clock;
	reg [63:0]K;
	wire [4:0] status;
	wire [63:0] data, address, PCin, PC4;
	reg [30:0] controlWord;
	
	DatapathRegALU dut(controlWord, reset, clock, K, PC4, status, data, address, PCin);
	
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
		
		// PS = 01, DA = 00101, SA = 11111, SB = 11111, FS = 00100, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		#1 controlWord <= 31'b01_00101_11111_11111_00100_10_0100_1_0_0;
		K <= 64'd24;
		
		// PS = 01, DA = 00111, SA = 11111, SB = 11111, FS = 00100, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_00111_11111_11111_00100_10_0100_1_0_0;
		K <= 64'd39;
		
		// PC = 01, DA = 00001, SA = 00101, SB = 00111, FS = 01000, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 0, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_00001_00101_00111_01000_10_0100_0_0_0;
		
		// PC = 01, DA= 11110, SA = 00001, SB = 00101, FS = 01100, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 0, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_11110_00001_00101_01100_10_0100_0_0_0;
		
		// PC = 01, DA = 10001, SA = 11110, SB = 11111, FS = 10000, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_10001_11110_11111_10000_10_0100_1_0_0;
		K <= 64'd2;
		
		// PC = 01, DA = 11111, SA = 00111, SB = 10001, FS = 00100, regW = 0, ramW = 1, EN_MEM = 0, EN_ALU = 0, EN_B = 1, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_11111_00111_10001_00100_01_0010_1_0_0;
		K <= 64'd0;
		
		// PC = 01, DA = 00000, SA = 00111, SB = 11111, FS = 00100, regW = 1, ramW = 0, EN_MEM = 1, EN_ALU = 0, EN_B = 0, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_00000_00111_11111_00100_10_1000_1_0_0;
		K <= 64'd0;
		
		// PC = 01, DA = 00000, SA = 00000, SB = 11111, FS = 01000, regW = 1, ramW = 0, EN_MEM = 0, EN_ALU = 1, EN_B = 0, EN_PC = 0, selB = 1, PCsel = 0, SL = 0
		#10 controlWord <= 31'b01_00000_00000_11111_01000_10_0100_1_0_0;
		K <= 64'd4;
		#15 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
