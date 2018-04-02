module DatapathRegALU(controlWord, reset, clock, K, statusReg, data);
	input [28:0] controlWord;
	wire [4:0] DA, SA, SB;
	wire [1:0] PS;
	input reset, clock;
	input [63:0]K;
	wire selB;
	wire [4:0] FS;
	wire regW, ramW;
	wire [1:0]selD;
	wire [3:0] status;
	output [63:0] data;
	wire [63:0] PC, PC4;
	wire PCsel;
	wire SL;
	output reg [3:0]statusReg;
	
	assign {PS, DA, SA, SB, FS, regW, ramW, selD, selB, PCsel, SL} = controlWord; // assigning control signals to a single control word

	wire [63:0] A, BPre, BPost, dataALU, dataRAM; // wires inbetween components, previously undefined
	
	RegFile32x64 regInst(data, DA, SA, SB, regW, reset, clock, A, BPre); // instance of registry file
	
	ALU aluInst(A, BPost, FS, status, dataALU); // instance of ALU
	
	assign BPost = selB ? K : BPre; // MUX for selecting between B and K
	
	RAM256x64 ramInst(dataALU, clock, BPre, ramW, dataRAM); // instance of RAM file
	
	//assign data = selD ? dataALU : dataRAM; // If selD is true, data = dataALU; if selD is false, data = dataRAM
	
	Mux4to1Nbit(selD, dataRAM, dataALU, BPre, PC, data);
	
	//add control unit
	
	assign PCin = PCsel ? K : A;
	
	ProgramCounter(clock, PCin, PS, PC, PC4);
	
	always@(posedge clock) if (SL) statusReg <= status;
	
endmodule
