module I_Arithmetic(instruction, state, controlWord, nextState, K);
	input [31:0] instruction;
	input [1:0] state;
	
	output [28:0] controlWord;
	output [1:0] nextState;
	output [63:0] K;
	
	wire [1:0] Psel, Dsel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, PCsel, SL;
	
	assign Psel = 2'b01; // PC <- PC + 4
	assign DA = instruction[4:0];
	assign SA = instruction[9:5]; // Rn = A
	assign SB = 5'd0; // K is used instead of B
	assign Fsel = {4'b0100, instruction[30]}; // ADD, invert A on bit 30, do not invert B
	assign regW = 1'b1; // Write to register
	assign ramW = 1'b0; // Do not write to RAM
	assign Dsel = 2'b01; // Enable ALU on data bus
	assign Bsel = 1'b1; // Enable K to be used instead of B
	assign PCsel = 1'b0; // (Don't care)
	assign SL = instruction[29]; // Store on bit 29
	
	assign K = {42'd0, instruction[21:10]};
		
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, Dsel, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule