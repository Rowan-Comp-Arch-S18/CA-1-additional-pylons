module ProgramCounter(reset, clock, in, PS, PC, PC4);
	input [1:0] PS;
	input reset, clock;
	input [63:0] in;
	output [63:0] PC4;
	output reg [63:0] PC;
	
	wire [63:0] PCi;
	wire [63:0] SHL2, SHR2, PC4PCx4;
	
	// Calculate PC + 4
	Adder pc4Adder(PC, 64'd4, 1'b0, , PC4);
	
	// Shift for PC + 4 + in * 4
	Shifter inShift(in, 6'd2, SHL2, SHR2);
	Adder pc4in2Adder(SHL2, PC4, 1'b0, , PC4PCx4);
	
	always @(posedge clock) PC <= PCi;
	
								 //  00,  01, 10,      11
	Mux4to1Nbit muxInst1 (PS, PC, PC4, in, PC4PCx4, PCi); 	
endmodule
