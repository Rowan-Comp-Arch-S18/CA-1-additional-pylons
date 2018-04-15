module ProcessorTestbench();
	// Input signals
	reg reset, clock;
	
	// Monitors
	wire [63:0] PCin, PC, PC4, data, address, K;
	wire [31:0] instruction; // 32 bit
	wire [30:0] controlWord; // 31 bit
	wire [4:0] DA, SA, SB; // register addresses
	wire [63:0] R4, R8, R9;
	
	// Connect monitors
	assign PCin = dut.PCin;
	assign PC = dut.PC;
	assign PC4 = dut.PC4;
	assign data = dut.data;
	assign address = dut.address;
	assign K = dut.K;
	assign instruction = dut.instruction;
	assign controlWord = dut.controlWord;
	assign DA = dut.datapath.DA;
	assign SA = dut.datapath.SA;
	assign SB = dut.datapath.SB;
	assign R4 = dut.datapath.regInst.R04;
	assign R8 = dut.datapath.regInst.R08;
	assign R9 = dut.datapath.regInst.R09;
	
	// DUT
	Processor dut(reset, clock);
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		#7 reset <= 1'b0;
		#7500 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
