module ALU(A, B, FS, status, F);
	input [63:0] A, B; //64b inputs
	input [4:0] FS; //5b function select
						 //FS[0] - B invert, FS[1] - A invert, FS[4:2] operation select
						 //000XX - AND, 001XX - OR, 010XX - ADD, 011XX XOR, 100XX SHIFT LEFT, 101XX SHIFT RIGHT
	
	output [3:0] status; //4b status signal
	output [63:0] F; //64b output
	
	wire V, C, Z, N; //1b overflow, carry-out, zero, negative
	
	wire [63:0] A_compute, B_compute; //64b wires for A and B after potential invert by FS[1] and FS[0]
	
	assign A_compute = FS[1] ? ~A : A; //invert A if invert A is true
	assign B_compute = FS[0] ? ~B : B; //invert B if invert B is true
	
	wire [63:0] AandB, AorB, AaddB, AxorB, AshiftleftB, AshiftrightB; //64b wires for outputs of the six functions
	
	assign AandB = A_compute & B_compute; //and A and B
	assign AorB = A_compute | B_compute; //or A and B 
	Adder adder_inst(A_compute, B_compute, FS[0], C, AaddB); //add A and B
	assign AxorB = A_compute ^ B_compute; //xor A and B
	Shifter shifter_inst(A, B[5:0], AshiftleftB, AshiftrightB); //shift A and B (this gives left and right shifts as outputs)
	
	Mux8to1 mux8to1_inst(FS[4:2], AandB, AorB, AaddB, AxorB, AshiftleftB, AshiftrightB, 64'b0, 64'b0, F); //put the 6 functions through a mux, select is FS[4:2]
	
	assign V = ~(A_compute[63] ^ B_compute[63]) & (A_compute[63] ^ AaddB[63]); //true if there is overflow
	assign Z = (F == 64'b0) ? 1'b1 : 1'b0; //true if F is zero
	assign N = F[63]; //true if F is negative
	
	assign status = {V, C, Z, N}; //concat the status bits into one status signal
endmodule
