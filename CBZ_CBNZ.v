module CBZ_CBNZ(status, instruction, state, controlWord, nextState, K);
	input [31:0] instruction;
	input [1:0] state;
	input [4:0] status;
	
	output [30:0] controlWord;
	output [1:0] nextState;
	output [63:0] K;
	
	wire Z, C, N, V, ZI;
	wire [1:0] Psel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, Bsel, EN_MEM, EN_ALU, EN_B, EN_PC, PCsel, SL;
	
	assign V = status[4]; assign C = status[3]; assign Z = status[2]; assign N = status[1]; assign ZI = status[0];
	
	assign Psel = {instruction[24] ^ ZI, 1'b1}; // either PC <- PC + 4 + in * 4 (OR) PC <- PC + 4
	assign DA = 5'b11111; //(Don't care)
	assign SA = 5'b11111; // Compare against 0
	assign SB = instruction[4:0];
	assign Fsel = 5'b00100; // OR
	assign regW = 1'b0; // Do not write to register
	assign ramW = 1'b0; // Do not write to RAM
	assign EN_MEM = 1'b0;
	assign EN_ALU = 1'b0;
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0;
	assign Bsel = 1'b0; // Register B output to ALU for comparison
	assign PCsel = ZI; // Z immeditate
	assign SL = 1'b0;
	
	assign K = {{45{instruction[23]}},{instruction[23:5]}};
		
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule
