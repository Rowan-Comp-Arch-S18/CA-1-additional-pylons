module B_conditional(status, instruction, state, controlWord, nextState, K);
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
	wire muxout;
	
	assign V = status[4]; assign C = status[3]; assign Z = status[2]; assign N = status[1]; assign ZI = status[0];
	
	Mux8to1Nbit bcondmux (instruction[3:1], Z, C, N, V, (C & ~Z), ~(N^V), (~(N^V) & ~Z), ~instruction[0], muxout);
	assign Psel = {muxout ^ instruction[0], 1'b1}; // either PC <- PC + 4 + in * 4 (OR) PC <- PC + 4
	assign DA = 5'b11111; //(Don't care)
	assign SA = 5'b11111; // (Don't care)
	assign SB = 5'b11111; // (Don't care)
	assign Fsel = 5'b00000; //THIS IS A DON'T CARE | AND, do not invert A, do not invert B 
	assign regW = 1'b0; // Do not write to register
	assign ramW = 1'b0; // Do not write to RAM
	assign EN_MEM = 1'b0;
	assign EN_ALU = 1'b0;
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0;
	assign Bsel = 1'b0; // (Don't care)
	assign PCsel = 1'b1; // select K
	assign SL = 1'b0; // (Don't care)
	
	assign K = {{45{instruction[23]}},{instruction[23:5]}};
		
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule
