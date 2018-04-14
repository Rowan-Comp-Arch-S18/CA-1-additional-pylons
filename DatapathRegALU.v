module DatapathRegALU(controlWord, reset, clock, K, statusOut, data);
	input [30:0] controlWord;
	wire [4:0] DA, SA, SB;
	wire [1:0] PS;
	input reset, clock;
	input [63:0]K;
	wire selB;
	wire [4:0] FS;
	wire regW, ramW;
	wire EN_MEM, EN_ALU, EN_B, EN_PC;
	output [63:0] data;
	wire [63:0] PC, PC4;
	wire PCsel;
	wire SL;
	wire [3:0] status;
	output [4:0] statusOut;
	reg [3:0]statusReg;
	
	assign {PS, DA, SA, SB, FS, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, selB, PCsel, SL} = controlWord; // assigning control signals to a single control word

	wire [63:0] A, BPre, BPost, dataALU, dataRAM, PCin; // wires inbetween components, previously undefined
	
	RegFile32x64 regInst(data, DA, SA, SB, regW, reset, clock, A, BPre); // instance of registry file
	
	ALU aluInst(A, BPost, FS, status, dataALU); // instance of ALU
	
	assign BPost = selB ? K : BPre; // MUX for selecting between B and K
	
	RAM256x64 ramInst(dataALU, clock, BPre, ramW, dataRAM); // instance of RAM file
	
	assign data = EN_MEM ? dataRAM : 64'bz;
	assign data = EN_ALU ? dataALU : 64'bz;
	assign data = EN_B ? BPre : 64'bz;
	assign data = EN_PC ? PC4 : 64'bz;
	
	assign PCin = PCsel ? K : A;
	
	ProgramCounter programCounter(clock, PCin, PS, PC, PC4);
	
	always@(posedge clock) if (SL) statusReg <= status;
	
	assign statusOut = {statusReg, status[1]}; //1b overflow, carry-out, zero, negative, zero immediate
	
endmodule
