module ProgramCounter(clock, in, PS, PC, PC4);
	input [1:0] PS;
	input clock;
	input [25:0] in;
	output [63:0] PC, PC4;
	
	
	wire [63:0] PCi, PC;
	reg [63:0] PCreg;
	wire [31:0] ROMout;
	wire [63:0] SHL2, signExtend, PC4PCx4;
	
	ROM romInst (ROMout, PC);
	
	Adder adderInst1 (PC, 64'd4, 1'b0, , PC4); 
	
	//Adder adderInst2 (addOut, PC4PCx4, 1'b0, , ALUresult);
	
	Adder adderInst3 (SHL2, PC4, 1'b0, , PC4PCx4); 
	
	Shifter shifter_inst(signExtend, 6'd2, SHL2, );
	
	assign signExtend = {{38{in[25]}},in[25:0]};
	
	//assign ROMextend = {{32{ROMout[31]}},ROMout[31:0]};
	
	//assign PC4 = addOut;
	
	always @(posedge clock)PCreg <= PCi;
	
	assign PC = PCreg;
								 //  00,  01,  		 10,     11
	Mux4to1Nbit muxInst1 (PS, PC, PC4, signExtend, PC4PCx4, PCi); 	
	
	
	
	
endmodule
