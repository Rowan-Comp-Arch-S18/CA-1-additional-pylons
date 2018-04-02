module R_ALU(instruction, state, controlWord, nextState);
	input [31:0] instruction;
	input [1:0] state;
	
	output [28:0] controlWord;
	output [1:0] nextState;
	
	// SA = Rm, SB = Rn
	
	wire [1:0] Psel, Dsel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, ALUsel, PCsel, SL;
	
	assign Psel = 2'b01; //PC <- PC + 4
	assign DA = instruction[4:0];
	assign SA = instruction[20:16];
	assign SB = instruction[9:5];
	assign regW = 1'b1; //Write to register
	assign ramW = 1'b0; //Do not write to ram
	assign ALUsel = 1'b0; //Pass B to ALU
	assign Fsel = {3'b010, instruction[30], 1'b0}; //ADD, invert A on bit 30, do not invert B
	assign Dsel = 2'b01; //Enable ALU on data bus
	assign PCsel = 1'b0; //Pass A to PC (This could be 0 or 1)
	assign SL = instruction[29]; //Store on bit 29
	
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, Dsel, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule
