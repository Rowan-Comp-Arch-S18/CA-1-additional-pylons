module B_conditional (status, instruction, state, controlWord, nextState, K);
	input [31:0] instruction;
	input [1:0] state;
	input [3:0] status;
	
	output [63:0] K;
	output [28:0] controlWord;
	output [1:0] nextState;
	
	wire Z, C, N, V;
	wire [1:0] Psel, Dsel;
	wire [4:0] DA, SA, SB, Fsel;
	wire regW, ramW, PCsel, SL;
	wire mux8out, mux4out;
	
	assign V = status[3]; assign C = status[2]; assign Z = status[1]; assign N = status[0]; 
	
	Mux8to1Nbit inst1(instruction[2:0], C & ~Z, ~(C & ~Z), ~(N ^ V), N ^ V, ~((N ^ V)|Z), (N ^ V)|Z, 1'b1, 1'b1, mux8out);
	Mux4to1Nbit inst2(instuction[2:1], Z, C, N, V, mux4out);
	assign Psel[1] = instruction[3] ? mux8out : mux4out;
	
	assign Psel[0] = 1'b1; // either PC <- PC + 4 + in * 4 (OR) PC <- PC + 4
	assign DA = instruction[4:0]; //(Don't care)
	assign SA = instruction[9:5]; // (Don't care)
	assign SB = 5'd0; // (Don't care)
	assign Fsel = {4'b0100, instruction[30]}; // (Don't care)
	assign regW = 1'b0; // Do not write to register
	assign ramW = 1'b0; // Do not write to RAM
	assign Dsel = 2'b01; // (Don't care)
	assign Bsel = 1'b0; // (Don't care)
	assign PCsel = 1'b1; // select K
	assign SL = instruction[29]; // (Don't care)
	assign K = {{38{instruction[25]}},{instruction[25:0]}};
		
	assign controlWord = {Psel, DA, SA, SB, Fsel, regW, ramW, Dsel, Bsel, PCsel, SL};
	
	assign nextState = 2'b00;
	
endmodule
