module DatapathRegALU(controlWord, reset, clock, K, status, data);
	input [23:0] controlWord;
	wire [4:0] DA, SA, SB;
	input reset, clock;
	input [63:0]K;
	wire selK;
	wire [4:0] FS;
	wire regW, ramW;
	wire selALU;
	output [3:0] status;
	output [63:0] data;
	
	assign {DA, SA, SB, FS, regW, ramW, selALU, selK} = controlWord;
	
	wire [63:0] A, BPre, BPost, dataALU, dataRAM;
	
	RegFile32x64 regInst(data, DA, SA, SB, regW, reset, clock, A, BPre);
	
	ALU aluInst(A, BPost, FS, status, dataALU);
	
	assign BPost = selK ? K : BPre;
	
	RAM256x64 ramInst(dataALU, clock, BPre, ramW, dataRAM);
	
	assign data = selALU ? dataALU : dataRAM; // If selALU is true, data = dataALU; if selALU is false, data = dataRAM
	
endmodule
