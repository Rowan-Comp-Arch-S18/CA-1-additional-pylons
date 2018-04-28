module PseudoRandomNumberGenerator(procClock, data, address, read, write);
	parameter PRNGAddress = 8'b00000110;
	
	input procClock;
	output [63:0] data;
	input [63:0] address;
	input read, write;
	
	wire correctAddress;
	assign correctAddress = address[63:56] == PRNGAddress;
	
	wire feedback;
	reg [63:0] random;
	assign feedback = ~(random[63] ^ random[62] ^ random[60] ^ random[59]);
	assign data = correctAddress & read ? random : 64'bz;
	
	initial begin
		random <= 64'h128F9A75D093C27E;
	end
	
	always @(negedge procClock) begin
		random <= {random[62:0], feedback};
	end
endmodule
