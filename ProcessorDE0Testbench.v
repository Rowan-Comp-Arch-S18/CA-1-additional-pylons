`timescale 1ns / 1ns
module ProcessorDE0Testbench();
	// Signals
	reg [2:0] button;
	wire [3:0] vgaR, vgaG, vgaB;
	wire vgaHS, vgaVS;
	reg clock;// Monitors
	wire procClock;
	wire [63:0] PCin, PC, PC4, data, address, K;
	wire read, write;
	wire [9:0] rowGPU, colGPU;
	wire [10:0] intCharAddGPU, extAddGPU;
	wire [31:0] instruction; // 32 bit
	wire [30:0] controlWord; // 31 bit
	wire [4:0] DA, SA, SB; // register addresses
	wire [63:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30;
	
	assign rowGPU = dut.gpu.row;
	assign colGPU = dut.gpu.col;
	assign intCharAddGPU = dut.gpu.charPixelDisplayAddress;
	assign extAddGPU = dut.gpu.extFramebufferAddress;
	
	// Connect monitors
	assign procClock = dut.procClock;
	assign PCin = dut.proc.PCin;
	assign PC = dut.proc.PC;
	assign PC4 = dut.proc.PC4;
	assign K = dut.proc.K;
	assign data = dut.data;
	assign address = dut.address;
	assign read = dut.read;
	assign write = dut.write;
	assign instruction = dut.proc.instruction;
	assign controlWord = dut.proc.controlWord;
	assign DA = dut.proc.datapath.DA;
	assign SA = dut.proc.datapath.SA;
	assign SB = dut.proc.datapath.SB;
	assign R0 = dut.proc.datapath.regInst.R00;
	assign R1 = dut.proc.datapath.regInst.R01;
	assign R2 = dut.proc.datapath.regInst.R02;
	assign R3 = dut.proc.datapath.regInst.R03;
	assign R4 = dut.proc.datapath.regInst.R04;
	assign R5 = dut.proc.datapath.regInst.R05;
	assign R6 = dut.proc.datapath.regInst.R06;
	assign R7 = dut.proc.datapath.regInst.R07;
	assign R8 = dut.proc.datapath.regInst.R08;
	assign R9 = dut.proc.datapath.regInst.R09;
	assign R10 = dut.proc.datapath.regInst.R10;
	assign R11 = dut.proc.datapath.regInst.R11;
	assign R12 = dut.proc.datapath.regInst.R12;
	assign R13 = dut.proc.datapath.regInst.R13;
	assign R14 = dut.proc.datapath.regInst.R14;
	assign R15 = dut.proc.datapath.regInst.R15;
	assign R16 = dut.proc.datapath.regInst.R16;
	assign R17 = dut.proc.datapath.regInst.R17;
	assign R18 = dut.proc.datapath.regInst.R18;
	assign R19 = dut.proc.datapath.regInst.R19;
	assign R20 = dut.proc.datapath.regInst.R20;
	assign R21 = dut.proc.datapath.regInst.R21;
	assign R22 = dut.proc.datapath.regInst.R22;
	assign R23 = dut.proc.datapath.regInst.R23;
	assign R24 = dut.proc.datapath.regInst.R24;
	assign R25 = dut.proc.datapath.regInst.R25;
	assign R26 = dut.proc.datapath.regInst.R26;
	assign R27 = dut.proc.datapath.regInst.R27;
	assign R28 = dut.proc.datapath.regInst.R28;
	assign R29 = dut.proc.datapath.regInst.R29;
	assign R30 = dut.proc.datapath.regInst.R30;
	
	ProcessorDE0 dut(, , button, ,, ,,,, ,,,,, vgaR, vgaG, vgaB, vgaHS, vgaVS, clock,, ,,,,,,,,,,,, ,,,);
	
	initial begin
		clock <= 1'b1;
		button[2:1] <= 2'b00;
		button[0] <= 1'b0;
		#70 button[0] <= 1'b1;
		#10000000 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
