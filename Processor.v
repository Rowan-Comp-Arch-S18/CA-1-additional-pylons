module Processor(reset, clock);
	input reset, clock;
	
	wire [1:0] PS;
	wire [63:0] PCin, PC, PC4, data, address, K;
	wire [31:0] instruction; // 32 bit
	wire [30:0] controlWord; // 31 bit
	wire [4:0] status; // From the ALU
	
	// Main processor components
	assign PS = controlWord[30:29];
	ProgramCounter programCounter(reset, clock, PCin, PS, PC, PC4);
	DatapathRegALU datapath(controlWord, reset, clock, K, PC4, status, data, address, PCin);
	control_unit controlUnit(instruction, status, reset, clock, controlWord, K);
	ROM rom(instruction, PC[17:2]);
	
	// Peripherals
	// TODO
endmodule
