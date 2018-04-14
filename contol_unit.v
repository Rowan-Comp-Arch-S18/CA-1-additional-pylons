module contol_unit(instruction, status, reset, clock, control_word, literal);
	parameter cw_bits= 29;
	input [31:0] instruction;
	input [4:0] status; 	// V, C, N, Z
	input reset, clock;
	output [cw_bits-1:0] control_word;
	output [63:0] literal;
	
	wire [10:0] opcode;
	
	assign opcode = instruction[31:21];
	
	//partial control words
	wire [cw_bits-1:0] branch_cw, other_cw;
	wire [cw_bits-1:0] D_format_cw, I_arithmetic_cw, I_logic_cw, IW_cw, R_ALU_cw;
	wire [cw_bits:0] B_cw, B_cond_cw, BL_cw, CBZ_cw, BR_cw;
	
	// state logic
	wire NS;
	reg state;
	always @(posedge clock or posedge reset) begin
		if(reset)
			state<= 1'b0;
		else
			state <= NS;
	end
	
	//partial control unic decoders
	//D_decoder
	I_arithmatic_decoder dec0_010 (instruction, I_arithmetic_cw);
	I_logic_decoder dec0_100 (instruction, I_logic_cw);
	IW_decoder dec0_101 (instruction, state, IW_cw);
	R_ALU_decoder dec0_110 (instruction, state, IW_cw);
	B_decoder dec1_000 (instruction, B_cw);
	B_cond_decoder dec1_010 (instruction, status[4:1], B_cond_cw);
	BL_decoder dec1_100 (instruction, BL_cw);
	CBZ_decoder dec1_101 (instruction, status[0], CBZ_cw);
	BR_decoder dec1_110 (instruction, BR_cw);
	
	//2:1 mux to select between branch instructions and all others
	assign control_word = opcode[5] ? branch_cw : other_cw;
	
	//8:1 mus to select between branch instructions
	Mux8to1Nbit branch_mux (branch_cw, opcode[10:8],
		B_cw, 0, B_cond_cw, 0, BL_cw, CBZ_cw, BR_cw, 0);
	defparam other_mux.N = cw_bits+1;
	
	//8:1 mux to select between all other instructions
	Mux8to1Nbit other_mux (other_cw, opcode[4:2],
		D_format_cw, 0, I_arithmetic_cw, 0, I_logic_cw, IW_cw, R_ALU_cw, 0);
	defparam branch_mux.N = cw_bits+1;
	
endmodule
//module I_arithmatic_decoder (instruction, I_arithmetic_cw);
//	
//endmodule
//module I_logic_decoder (instruction, I_logic_cw);
//endmodule
//module IW_decoder (instruction, state, IW_cw);
//endmodule
//module R_ALU_decoder (instruction, state, IW_cw);
//endmodule
//module B_decoder (instruction, B_cw);
//endmodule
//module B_cond_decoder (instruction, status[4:1], B_cond_cw);
//endmodule
//module BL_decoder (instruction, BL_cw);
//endmodule
//module CBZ_decoder (instruction, status[0], CBZ_cw);
//endmodule
//module BR_decoder (instruction, BR_cw);
//endmodule
