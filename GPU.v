module GPU(procClock, clock50, vga, data, address, read, write);
	parameter GPUAddress = 8'b00000010;
	parameter GPUControlAddress = 56'd0;
	parameter GPUStatusAddress = 56'd2;
	parameter GPUCharactersAddress = 56'd4;
	
	input procClock, clock50;
	input [13:0] vga;
	input read, write;
	input [63:0] address;
	inout [63:0] data;
	
	wire [63:0] no1, no2;
	wire correctAddress;
	
	GPUFramebuffer external(address - GPUCharactersAddress, clock50, data, correctAddress & write, no1);
	GPUFramebuffer internal(address - GPUCharactersAddress, clock50, no1, correctAddress & write, no2);
	
	assign correctAddress = (address[63:56] == GPUAddress) ? 1'b1 : 1'b0;
	assign data = (read & correctAddress) ? no2 : 64'bz;
endmodule
