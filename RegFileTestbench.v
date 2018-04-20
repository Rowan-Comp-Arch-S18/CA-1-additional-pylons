module RegFileTestbench();
	reg [63:0] D; //64b input
	reg [4:0] DA, SA, SB; //5b data address, select A, select B
	reg W, reset, clock; //1b write enable, reset, clock
	
	wire [63:0] A, B; //64b outputs
	
	wire [63:0] R00, R01, R02, R03, R04, R05, R06, R07, R08, R09, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31; //64b registers
	
	RegFile32x64 dut (D, DA, SA, SB, W, reset, clock, A, B); //design under test for RegFile32x64
	
	initial begin
		clock <= 1'b0;
		reset <= 1'b1; //reset
		DA <= 5'd0; //data goes to R00
		SA <= 5'd31; //select R31 for A
		SB <= 5'd30; //select R30 for B
		W <= 1'b1; //write enabled
		D <= $random; //data gets random 32b word
		#4 reset <= 1'b0; //don't reset
		#320 W <= 1'b0; //write disabled
		#320 $stop; //stop
	end
	
	always begin
		#5 clock <= ~clock; //invert clock
	end
	
	always begin
		#10 DA <= DA + 1'b1; //data address increases
		SA <= SA + 1'b1; //select for A increases
		SB <= SB + 1'b1; //select for B increases
		D <= $random; //data gets random 32b word
	end
	
	assign R00 = dut.R00; //connect registers
	assign R01 = dut.R01;
	assign R02 = dut.R02;
	assign R03 = dut.R03;
	assign R04 = dut.R04;
	assign R05 = dut.R05;
	assign R06 = dut.R06;
	assign R07 = dut.R07;
	assign R08 = dut.R08;
	assign R09 = dut.R09;
	assign R10 = dut.R10;
	assign R11 = dut.R11;
	assign R12 = dut.R12;
	assign R13 = dut.R13;
	assign R14 = dut.R14;
	assign R15 = dut.R15;
	assign R16 = dut.R16;
	assign R17 = dut.R17;
	assign R18 = dut.R18;
	assign R19 = dut.R19;
	assign R20 = dut.R20;
	assign R21 = dut.R21;
	assign R22 = dut.R22;
	assign R23 = dut.R23;
	assign R24 = dut.R24;
	assign R25 = dut.R25;
	assign R26 = dut.R26;
	assign R27 = dut.R27;
	assign R28 = dut.R28;
	assign R29 = dut.R29;
	assign R30 = dut.R30;
	assign R31 = dut.R31;
	
endmodule
