module GPUFramebuffer(address, clock, in, write, out);
	parameter framebufferSize = 600;
	parameter framebufferSizeAddress = 10;
	
	input [63:0] address;
	input clock;
	input [63:0] in;
	input write;
	
	output reg [63:0] out;
	
	reg [63:0] mem [0:framebufferSize-1]; // 600 64 bits for storing 2400 characters
	
	always @(negedge clock) begin
		if (write) begin
			mem[address] <= in;
		end
	end
	
	always @(negedge clock) begin
		out <= mem[address];
	end
	
endmodule
