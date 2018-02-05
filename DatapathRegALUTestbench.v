module DatapathRegALUTestbench();
	reg [4:0] DA, SA, SB;
	reg W, reset, clock;
	reg [63:0]K;
	reg BS;
	reg [4:0] FS;
	wire [3:0] status;
	wire [63:0] data;
	
	DatapathRegALU dut(DA, SA, SB, W, reset, clock, K, BS, FS, status, data);
	
	initial begin
		clock <= 1'b1;
		reset <= 1'b0;
		#10 DA <= 5'd5;
		SA <= 5'd31;
		W <= 1'b1;
		K <= 64'd24;
		BS <= 1'b1;
		FS <= 5'b00100;
		#20 DA <= 5'd7;
		SA <= 5'd31;
		W <= 1'b1;
		K <= 64'd39;
		BS <= 1'b1;
		FS <= 5'b00100;
		#20 DA <= 5'd1;
		SA <= 5'd5;
		SB <= 5'd7;
		W <= 1'b1;
		BS <= 1'b0;
		FS <= 5'b01000;
		#20 DA <= 5'd30;
		SA <= 5'd1;
		SB <= 5'd5;
		W <= 1'b1;
		BS <= 1'b0;
		FS <= 5'b01100;
		#20 DA <= 5'd17;
		SA <= 5'd30;
		W <= 1'b1;
		K <= 64'd2;
		BS <= 1'b1;
		FS <= 5'b10000;
		#5 $stop;
	end
	
	always begin
		#10 clock <= ~clock;
	end
endmodule
