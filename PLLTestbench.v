`timescale 1ns / 1ns
module PLLTestbench();
	wire out;
	reg in;
	
	ProcessorPLL dut(in, out);
	
	initial begin
		in <= 0;
		#100 $stop;
	end
	
	always begin
		#5 in <= ~in;
	end
endmodule
