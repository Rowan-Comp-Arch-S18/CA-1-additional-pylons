module D_Transfer(instruction, state, controlWord, nextState, K);
	input [31:0] instruction;
	input [1:0] state;
	
	output [30:0] controlWord;
	output [1:0] nextState;
	output [63:0] K;
	
	wire [1:0] Psel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, Bsel, EN_MEM, EN_ALU, EN_B, EN_PC, PCsel, SL;
	
	assign Psel = 2'b01; // PC <- PC + 4
	assign DA = instruction[4:0];
	assign SA = instruction[9:5]; // Rn = A
	assign SB = instruction[4:0]; // Rt = B
	assign Fsel = 5'b01000; // ADD
	assign regW = instruction[22];
	assign ramW = ~instruction[22];
	assign EN_MEM = instruction[22];
	assign EN_ALU = 1'b0;
	assign EN_B = ~instruction[22];
	assign EN_PC = 1'b0;
	assign Bsel = 1'b1; // Enable K only when finished with storing
	assign PCsel = 1'b0; // (Don't care)
	assign SL = 1'b0; // Don't store
	
	assign K = {55'd0, instruction[20:12]};
	
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule
