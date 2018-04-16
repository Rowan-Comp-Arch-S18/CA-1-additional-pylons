module ProcessorTestbench();
	// Input signals
	reg reset, clock;
	
	// Monitors
	wire [63:0] PCin, PC, PC4, data, address, K;
	wire [31:0] instruction; // 32 bit
	wire [30:0] controlWord; // 31 bit
	wire [4:0] DA, SA, SB; // register addresses
	wire [63:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30;
	
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
	assign R0 = dut.datapath.regInst.R00;
	assign R1 = dut.datapath.regInst.R01;
	assign R2 = dut.datapath.regInst.R02;
	assign R3 = dut.datapath.regInst.R03;
	assign R4 = dut.datapath.regInst.R04;
	assign R5 = dut.datapath.regInst.R05;
	assign R6 = dut.datapath.regInst.R06;
	assign R7 = dut.datapath.regInst.R07;
	assign R8 = dut.datapath.regInst.R08;
	assign R9 = dut.datapath.regInst.R09;
	assign R10 = dut.datapath.regInst.R10;
	assign R11 = dut.datapath.regInst.R11;
	assign R12 = dut.datapath.regInst.R12;
	assign R13 = dut.datapath.regInst.R13;
	assign R14 = dut.datapath.regInst.R14;
	assign R15 = dut.datapath.regInst.R15;
	assign R16 = dut.datapath.regInst.R16;
	assign R17 = dut.datapath.regInst.R17;
	assign R18 = dut.datapath.regInst.R18;
	assign R19 = dut.datapath.regInst.R19;
	assign R20 = dut.datapath.regInst.R20;
	assign R21 = dut.datapath.regInst.R21;
	assign R22 = dut.datapath.regInst.R22;
	assign R23 = dut.datapath.regInst.R23;
	assign R24 = dut.datapath.regInst.R24;
	assign R25 = dut.datapath.regInst.R25;
	assign R26 = dut.datapath.regInst.R26;
	assign R27 = dut.datapath.regInst.R27;
	assign R28 = dut.datapath.regInst.R28;
	assign R29 = dut.datapath.regInst.R29;
	assign R30 = dut.datapath.regInst.R30;
	
	// DUT
	Processor dut(reset, clock);
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b1;
		#7 reset <= 1'b0;
		#2000 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
