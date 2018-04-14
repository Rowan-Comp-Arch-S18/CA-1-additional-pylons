module I_Logic(instruction, state, controlWord, nextState, K);
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
	assign SB = 5'd0; // K is used instead of B
	assign Fsel = {1'b0, instruction[30] & ~instruction[29], instruction[30] ^ instruction[29], 2'b00};
	assign regW = 1'b1; // Write to register
	assign ramW = 1'b0; // Do not write to RAM
	assign EN_MEM = 1'b0;
	assign EN_ALU = 1'b1; //Enable ALU on data bus
	assign EN_B = 1'b0;
	assign EN_PC = 1'b0;
	assign Bsel = 1'b0; // Enable K to be used instead of B
	assign PCsel = 1'b0; // (Don't care)
	assign SL = instruction[30] & instruction[29]; // Store on bit 29
	
	assign K = {52'd0, instruction[21:10]};
		
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule
