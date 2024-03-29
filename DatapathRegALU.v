module DatapathRegALU(controlWord, reset, clock, K, PC4, statusOut, data, address, EN_MEM, ramW, PCin);
	input [30:0] controlWord;
	wire [4:0] DA, SA, SB;
	wire [1:0] PS;
	input reset, clock;
	input [63:0] K, PC4;
	wire selB;
	wire [4:0] FS;
	wire regW;
	output ramW;
	wire EN_ALU, EN_B, EN_PC;
	output EN_MEM;
	output [63:0] data, PCin, address;
	wire [63:0] PC;
	wire PCsel;
	wire SL;
	wire [3:0] status;
	output [4:0] statusOut;
	reg [3:0]statusReg;
	
	assign {PS, DA, SA, SB, FS, regW, ramW, EN_MEM, EN_ALU, EN_B, EN_PC, selB, PCsel, SL} = controlWord; // assigning control signals to a single control word

	wire [63:0] A, BPre, BPost, dataALU, dataRAM; // wires inbetween components, previously undefined
	
	RegFile32x64 regInst(data, DA, SA, SB, regW, reset, clock, A, BPre); // instance of registry file
	
	ALU aluInst(A, BPost, FS, status, dataALU); // instance of ALU
	
	assign address = dataALU;
	
	assign BPost = selB ? K : BPre; // MUX for selecting between B and K
	
	RAM256x64 ramInst(dataALU, clock, BPre, ramW, dataRAM); // instance of RAM file
	
	assign data = EN_MEM ? dataRAM : 64'bz;
	assign data = EN_ALU ? dataALU : 64'bz;
	assign data = EN_B ? BPre : 64'bz;
	assign data = EN_PC ? PC4 : 64'bz;
	
	assign PCin = PCsel ? K : A;
	
	initial statusReg <= 4'b0000;
	always@(posedge clock) if (SL) statusReg <= status;
	
	assign statusOut = {statusReg, status[1]}; //1b overflow, carry-out, zero, negative, zero immediate
	
endmodule
