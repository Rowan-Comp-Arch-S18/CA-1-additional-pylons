module GPU(procClock, clock50, vga, data, address, read, write);
	parameter GPUAddress = 8'b00000010;
	parameter GPUControlAddress = 56'd0;
	parameter GPUStatusAddress = 56'd2;
	parameter GPUCharactersAddress = 56'd4;
	
	// Addressing
	input read, write;
	input [63:0] address;
	inout [63:0] data;
	wire [63:0] no1, no2;
	wire correctAddress;
	assign correctAddress = (address[63:56] == GPUAddress) ? 1'b1 : 1'b0;
	assign data = (read & correctAddress) ? no2 : 64'bz;
	
	// Clock
	input procClock, clock50;
	wire clockVGA;	
	GPUVGAClock vgaClock(clock50, clockVGA);
	
	// Break out VGA signals
	output [13:0] vga;
	wire [3:0] vgaR, vgaG, vgaB;
	wire vgaHS, vgaVS;
	assign vga = {vgaR, vgaG, vgaB, vgaHS, vgaVS};
	
	// VGA control
	wire displayEnable;
	wire [9:0] row, col;
	GPUVGAController vgaController(clockVGA, displayEnable, row, col, vgaHS, vgaVS);
	
	// Temp display a white screen
	assign vgaR = {4{displayEnable}};
	assign vgaG = {4{displayEnable}};
	assign vgaB = {4{displayEnable}};
	
	// Framebuffers
	GPUFramebuffer external(address[55:0] - GPUCharactersAddress, clock50, data, correctAddress & write, no1);
	GPUFramebuffer internal(address[55:0] - GPUCharactersAddress, clock50, no1, correctAddress & write, no2);
endmodule
