module PRNGTestbench();
	wire [63:0] data, address;
	wire read, write;
	reg clock;
	assign address = 64'h0600000000000000;
	assign read = 1'b1;
	assign write = 1'b0;
	
	PseudoRandomNumberGenerator dut(clock, data, address, read, write);
	
	initial begin
		clock <= 1'b0;
		#10000 $stop;
	end
	always begin
		#5 clock <= ~clock;
	end
endmodule
