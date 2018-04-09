module I_Logic(instruction, state, controlWord, nextState);
	input [31:0] instruction;
	input [1:0] state;
	
	output [28:0] controlWord;
	output [1:0] nextState;
	
	wire [1:0] Psel, Dsel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, PCsel, SL;
	
	assign Psel = 2'b01; // PC <- PC + 4
	assign DA = instruction[4:0];
	assign SA = instruction[9:5]; // Rn = A
	assign SB = 5'd0; // K is used instead of B
	assign Fsel = {1'b0, instruction[30] & ~instruction[29], instruction[30] ^ instruction[29], 2'b00};
	assign regW = 1'b1; // Write to register
	assign ramW = 1'b0; // Do not write to RAM
	assign Dsel = 2'b01; // Enable ALU on data bus
	assign Bsel = 1'b1; // Enable K to be used instead of B
	assign PCsel = 1'b0; // (Don't care)
	assign SL = instruction[30] & instruction[29]; // Store on bit 29
		
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, Dsel, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule