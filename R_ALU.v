module R_ALU(instruction, state, controlWord, nextState, K);
	input [31:0] instruction;
	input [1:0] state;
	
	output [28:0] controlWord;
	output [1:0] nextState;
	output [63:0] K;
	
	// SA = Rm, SB = Rn
	
	wire [1:0] Psel, Dsel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, Bsel, PCsel, SL;
	
	assign Psel = 2'b01; //PC <- PC + 4
	assign DA = instruction[4:0];
	assign SA = instruction[20:16];
	assign SB = instruction[9:5];
	assign regW = 1'b1; //Write to register
	assign ramW = 1'b0; //Do not write to ram
	assign Bsel = instruction[22] ? 1'b1 : 1'b0; //Pass K to ALU on bit 22
	assign Fsel = {instruction[22], ((~instruction[28] & instruction[24]) | (instruction[30] & ~instruction[29] & ~instruction[28])), ((~instruction[27] & ~instruction[21]) | (~instruction[30] & instruction[29] & ~instruction[24]) | (instruction[30] & ~instruction[29] & ~instruction[24])), 1'b0, (instruction[30] & ~instruction[28] & instruction[24])}; //Just trust me
	assign Dsel = 2'b01; //Enable ALU on data bus
	assign PCsel = 1'b0; //Pass A to PC (This could be 0 or 1)
	assign SL = ((instruction[29] & instruction[24]) | (instruction[30] & instruction[29] & ~instruction[24])) ? 1'b1 : 1'b0; //Store on (bit 29 and bit 24) or (bit 30 and bit 29 and not bit 24)
	
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, Dsel, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
	assign K = {58'd0, instruction[15:10]};
	
endmodule
