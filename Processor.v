module Processor(reset, clock, data, address, read, write);
	input reset, clock;
	
	wire [1:0] PS;
	wire [63:0] PCin, PC, PC4, K;
	wire [31:0] instruction; // 32 bit
	wire [30:0] controlWord; // 31 bit
	wire [4:0] status; // From the ALU
	inout [63:0] data;
	output [63:0] address;
	output read, write;
	
	// Main processor components
	assign PS = controlWord[30:29];
	ProgramCounter programCounter(reset, clock, PCin, PS, PC, PC4);
	DatapathRegALU datapath(controlWord, reset, clock, K, PC4, status, data, address, read, write, PCin);
	control_unit controlUnit(instruction, status, reset, clock, controlWord, K);
	//ROM rom(instruction, PC[17:2]);
	//rom_case rom(instruction, PC[17:2]);
	ROM_Cycle_Screen rom(instruction, PC[17:2]);
endmodule
