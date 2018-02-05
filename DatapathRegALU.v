module DatapathRegALU(DA, SA, SB, W, reset, clock, K, BS, FS, status, data);
	input [4:0] DA, SA, SB;
	input W, reset, clock;
	input [63:0]K;
	input BS;
	input [4:0] FS;
	output [3:0] status;
	output [63:0] data;
	
	wire [63:0] A, B_pre, B_post;
	
	RegFile32x64 reg_inst(A, B_pre, data, DA, SA, SB, W, reset, clock);
	
	ALU alu_inst(A, B_post, FS, status, data);
	
	Mux2to1 mux_inst(BS, B_pre, K, B_post);
	
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
