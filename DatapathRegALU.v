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
	wire [63:0] PC;
	wire [31:0] ROMout;
	wire [63:0] addOut, ALUresult, SHL2, sExtend, regInputB;
	//wire [10:0] opCode;
	
	
	//assign opCode = ROMout[63:53];
	
	assign {DA, SA, SB, FS, regW, ramW, selALU, selK} = controlWord; // assigning control signals to a single control word
	
	wire [63:0] A, BPre, BPost, dataALU, dataRAM; // wires inbetween components, previously undefined
	
	RegFile32x64 regInst(data, DA, SA, SB, regW, reset, clock, A, BPre); // instance of registry file
	
	ALU aluInst(A, BPost, FS, status, dataALU); // instance of ALU
	
	assign BPost = selK ? K : BPre; // MUX for selecting between B and K
	
	RAM256x64 ramInst(dataALU, clock, BPre, ramW, dataRAM); // instance of RAM file
	
	assign data = selALU ? dataALU : dataRAM; // If selALU is true, data = dataALU; if selALU is false, data = dataRAM
	
	ROM romInst (ROMout, PC);
	
	Adder adderInst1 (PC, 64'd4, , , addOut); // addOut -> PS: 01
	
	Adder adderInst2 (addOut, regInputB, , , ALUresult); // ALUresult -> PS: 11
	
	Adder adderInst3 (SHL2, BPost, , , regInputB); // BPost -> PS: 10
	
	Shifter shifter_inst(sExtend, 6'd2, SHL2, );
	
	assign sExtend = {ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],
		ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],
		ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],
		ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],
		ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25],ROMout[25:0]};
	
	
	
	
	//assign PC = ROMout[21] ? ALUresult : addOut;
	
												//  00,     01,    10,        11
	Mux4to1Nbit muxInst1 (ROMout[21:20], PC, addOut, BPost, ALUresult, PC); 	
	
endmodule
