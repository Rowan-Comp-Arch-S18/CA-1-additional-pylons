module ProgramCounter(PC, PC4, in, clock);
	input [1:0] in;
	input [63:0] PC;
	input clock;
	output reg [63:0] PC4;
	
	always @(posedge clock) begin
		case(in)
	
			00: PC4 <= PC;
			01: PC4 <= PC + 4;
			10: PC4 <= PC + 4 + PC;
			11: PC4 <= PC + 4 + PC*4;
	
		endcase
	end
endmodule
