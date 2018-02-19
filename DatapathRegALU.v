module DatapathRegALU(DA, SA, SB, regW, reset, clock, K, BS, FS, ramW, selEN, status, data);
	input [4:0] DA, SA, SB;
	input reset, clock;
	input [63:0]K;
	input BS;
	input [4:0] FS;
	input regW, ramW;
	input selEN;
	output [3:0] status;
	output [63:0] data;
	
	wire [63:0] A, BPre, BPost, dataALU, dataRAM;
	
	RegFile32x64 regInst(data, DA, SA, SB, regW, reset, clock, A, BPre);
	
	ALU aluInst(A, BPost, FS, status, dataALU);
	
	assign BPost = BS ? K : BPre;
	
	RAM256x64 ramInst(dataALU, clock, BPre, ramW, dataRAM);
	
	assign data = selEN ? dataALU : dataRAM; // If selEN is true, data = dataALU; if selEN is false, data = dataRAM
	
endmodule
