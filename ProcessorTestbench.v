module ProcessorTestbench();
	// Input signals
	reg reset, clock;
	
	// Monitors
	wire [63:0] PCin, PC, PC4, data, address, K;
	wire [31:0] instruction; // 32 bit
	wire [30:0] controlWord; // 31 bit
	
	// Connect monitors
	assign PCin = dut.PCin;
	assign PC = dut.PC;
	assign PC4 = dut.PC4;
	assign data = dut.data;
	assign address = dut.address;
	assign K = dut.K;
	assign instruction = dut.instruction;
	assign controlWord = dut.controlWord;
	
	// DUT
	Processor dut(reset, clock);
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		#3 reset <= 1'b0;
		#100 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
