module DatapathRegALU(DA, SA, SB, W, reset, clock, K, BS, FS, write, selEN, status, data);
	input [4:0] DA, SA, SB;
	input W, reset, clock;
	input [63:0]K;
	input BS;
	input [4:0] FS;
	input write;
	input selEN;
	output [3:0] status;
	output [63:0] data;
	
	wire [63:0] A, BPre, BPost, dataALU, in, address;
	
	RegFile32x64 regInst(A, BPre, data, DA, SA, SB, W, reset, clock);
	
	ALU aluInst(A, BPost, FS, status, dataALU);
	
	Mux2to1 muxInst(BS, BPre, K, BPost);
	
	RAM256x64 ramInst(address, clock, in, write, out);
	
	assign data = selEN ? dataALU : dataRAM; // If selEN is true, data = dataALU; if selEN is false, data = dataRAM
	
	DFF inInst (.d(BPre), .clk(~clock), .clrn(reset), .prn(1'b1), .q(in));
	DFF addressALUInst (.d(dataALU), .clk(~clock), .clrn(reset), .prn(1'b1), .q(address));
	DFF outInst (.d(out), .clk(clock), .clrn(reset), .prn(1'b1), .q(dataRAM));
	
endmodule

module Mux2to1(S, I0, I1, F);
	input S;
	input [63:0] I0, I1;
	output reg [63:0]F;
	
	always @(*) begin
		case(S)
			1'b0: F <= I0;
			1'b1: F <= I1;
		endcase
	end
	
endmodule
