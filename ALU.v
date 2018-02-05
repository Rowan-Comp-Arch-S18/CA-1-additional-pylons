module ALU(A, B, FS, status, F);
	input [63:0] A, B;
	input [4:0]FS; //FS[0] - B invert, FS[1] - A invert, FS[4:2] operation select
						//000 - AND, 001 - OR, 010 - ADD, 011 XOR, 100 SHIFT LEFT, 101 SHIFT RIGHT
	
	output [3:0]status;
	output [63:0]F;
	
	wire V, C, Z, N;
	
	wire [63:0] A_compute, B_compute;
	
	assign A_compute = FS[1] ? ~A : A;
	assign B_compute = FS[0] ? ~B : B;
	
	wire [63:0] AandB, AorB, AaddB, AxorB, AshiftleftB, AshiftrightB;
	
	assign AandB = A_compute & B_compute;
	assign AorB = A_compute | B_compute;
	Adder adder_inst(A_compute, B_compute, FS[0], C, AaddB);
	assign AxorB = A_compute ^ B_compute;
	Shifter shifter_inst(A, B[5:0], AshiftleftB, AshiftrightB);
	
	Mux8to1 mux8to1_inst(FS[4:2], AandB, AorB, AaddB, AxorB, AshiftleftB, AshiftrightB, 64'b0, 64'b0, F);
	
	assign V = ~(A_compute[63] ^ B_compute[63]) & (A_compute[63] ^ AaddB[63]);
	assign Z = (F == 64'b0) ? 1'b1 : 1'b0;
	assign N = F[63];
	
	assign status = {V, C, Z, N};
	
	defparam mux8to1_inst.N = 64;
endmodule

module Shifter(A, offset, left, right);
	input [63:0]A;
	input [5:0]offset;
	
	output [63:0] left, right;
	
	assign left = A << offset;
	assign right = A >> offset;
endmodule

module Adder(A, B, Cin, Cout, F);
	input [63:0] A, B;
	input Cin;
	
	output [63:0]F;
	output Cout;
	
	assign {Cout, F} = A + B + Cin;
endmodule

module Mux8to1(S, I0, I1, I2, I3, I4, I5, I6, I7, F);
	parameter N = 8;
	
	input [2:0]S;
	input [N-1:0] I0, I1, I2, I3, I4, I5, I6, I7;
	
	output [N-1:0]F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));
endmodule