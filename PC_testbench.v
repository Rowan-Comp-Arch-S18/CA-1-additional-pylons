module PC_testbench();
	
	reg reset, clock;
	wire [63:0] PC, PC4, PCi;
	reg [1:0] PS;
	reg [63:0] in;
	
	ProgramCounter PCinst(clock, in, PS, PC, PC4);
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b0;
		in <= 64'd2;
		
		#1 PS <= 2'b10;
		
		#10 PS <= 2'b00;
		
		#10 PS <= 2'b01;
		
		#10 PS <= 2'b10;
		
		#10 PS <= 2'b11;
		
		#10 PS <= 2'b00;
		
		#10 PS <= 2'b01;
		
		#10 PS <= 2'b10;
		
		#10 PS <= 2'b11;
		#15 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
