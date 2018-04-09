module D_Transfer(instruction, state, controlWord, nextState, K);
	input [31:0] instruction;
	input [1:0] state;
	
	output [28:0] controlWord;
	output [1:0] nextState;
	output [63:0] K;
	
	wire [1:0] Psel, Dsel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, PCsel, SL;
	
	assign Psel[1] = 1'b0;
	assign Psel[0] = (~instruction[22] & ~state[0]) | (instruction[22] & state[0]);
	assign DA = (instruction[22] & state[0]) ? instruction[4:0] : instruction[9:5];
	assign SA = instruction[9:5]; // Rn = A
	assign SB = {5{~state[1] & state[0]}} | ({5{~state[1] & state[0]}} & instruction[20:16]) | ({5{state[1]}} & instruction[4:0]); // K is used instead of B
	assign Fsel = 5'b01000; // ADD
	assign regW = ~state[1]; // Write to register if state is 1X
	assign ramW = ~instruction[22] & ~state[1] & state[0]; // Write to RAM only when finished with storing
	assign Dsel = state; // Enable ALU on data bus
	assign Bsel = state[1]; // Enable K only when finished with storing
	assign PCsel = 1'b0; // (Don't care)
	assign SL = 1'b0; // Don't store
	
	assign K = 64'b0;
	assign nextState = 2'b00;
	
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, Dsel, Bsel, PCsel, SL};
endmodule
