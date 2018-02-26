module DatapathRegALUTestbench();
	reg [4:0] DA, SA, SB;
	reg W, reset, clock;
	reg [63:0]K;
	reg BS;
	reg [4:0] FS;
	reg selEN, write;
	wire [3:0] status;
	wire [63:0] data;
	reg [23:0] controlWord;
	
	DatapathRegALU dut(controlWord, reset, clock, K, status, data);
	
	// R5 <= 24
	// R7 <= 39
	// R1 <= R5 + R7
	// R30 <= R1 ^ R5
	// R17 <= R30 << 2
	// M[R7] <= R17
	// R0 <= M[R7]
	// R0 <= R0 + 4
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b0;
		#1 DA <= 5'd5;
		selEN <= 1'b1;
		write <= 1'b0;
		SA <= 5'd31;
		W <= 1'b1;
		K <= 64'd24;
		BS <= 1'b1;
		FS <= 5'b00100;
		#10 DA <= 5'd7;
		SA <= 5'd31;
		W <= 1'b1;
		K <= 64'd39;
		BS <= 1'b1;
		FS <= 5'b00100;
		#10 DA <= 5'd1;
		SA <= 5'd5;
		SB <= 5'd7;
		W <= 1'b1;
		BS <= 1'b0;
		FS <= 5'b01000;
		#10 DA <= 5'd30;
		SA <= 5'd1;
		SB <= 5'd5;
		W <= 1'b1;
		BS <= 1'b0;
		FS <= 5'b01100;
		#10 DA <= 5'd17;
		SA <= 5'd30;
		W <= 1'b1;
		K <= 64'd2;
		BS <= 1'b1;
		FS <= 5'b10000;
		#10 write <= 1'b1;
		selEN <= 1'b1;
		SA <= 5'd7;
		SB <= 5'd17;
		W <= 1'b0;
		K <= 64'd0;
		BS <= 1'b1;
		FS <= 5'b00100;
		#10 DA <= 5'd0;
		write <= 1'b0;
		selEN <= 1'b0;
		SA <= 5'd7;
		W <= 1'b1;
		K <= 64'd0;
		BS <= 1'b1;
		FS <= 5'b00100;
		#10 DA <= 5'b0;
		write <= 1'b0;
		selEN <= 1'b1;
		SA <= 5'd0;
		W <= 1'b0;
		K <= 64'd4;
		BS <= 1'b1;
		FS <= 5'b01000;
		#15 $stop;
	end
	
	always begin
		#5 clock <= ~clock;
	end
endmodule
