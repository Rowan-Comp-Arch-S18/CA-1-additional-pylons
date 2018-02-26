module RAM256x64(address, clock, in, write, out);
	input [7:0] address; //8b address
	input clock; //1b clock
	input [63:0] in; //64b input
	input write; //1b write enable
	
	output reg [63:0] out; //64b output
	
	reg [63:0]mem[0:255]; //reserve memory
	
	always @(negedge clock) begin
		if (write) begin
			mem[address] <= in; //write to RAM when write is enabled
		end
	end
	
	always @(negedge clock) begin
		out <= mem[address]; //access RAM
	end
endmodule
