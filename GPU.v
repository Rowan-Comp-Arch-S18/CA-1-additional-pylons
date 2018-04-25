module GPU(procClock, clock50, vgaOut, data, address, read, write);
	parameter GPUAddress = 8'b00000010;
	parameter GPUControlAddress = 11'd0;
	parameter GPUStatusAddress = 11'd2;
	parameter GPUCharactersAddressMin = 11'd4;
	parameter GPUCharactersAddressMax = 11'd1204;
	
	// Addressing
	input read, write;
	input [63:0] address;
	inout [63:0] data;
	wire [63:0] extFramebufferIn, extFramebufferOut, intFramebufferIn, intFramebufferOut;
	wire [10:0] extFramebufferAddress, intFramebufferAddress;
	wire correctAddress, controlAddress, statusAddress, characterAddress;
	assign correctAddress = address[63:56] == GPUAddress;
	assign controlAddress = (address[10:0] == GPUControlAddress) ? correctAddress : 1'b0;
	assign statusAddress = (address[10:0] == GPUStatusAddress) ? correctAddress : 1'b0;
	assign characterAddress = ((address[10:0] >= GPUCharactersAddressMin) & (address[10:0] < GPUCharactersAddressMax)) ? correctAddress : 1'b0;
	
	// VGA control
	output [13:0] vgaOut;
	wire [11:0] vga, vgaEnable;
	wire vgaHS, vgaVS;
	wire displayEnable;
	wire [9:0] row, col;
	assign vgaEnable = {12{displayEnable}} & vga;
	assign vgaOut = {vgaEnable, vgaHS, vgaVS};
	
	// Signals
	reg [63:0] controlSignals;
	wire [63:0] statusSignals;
	assign statusSignals = {62'b0, ~vgaVS, displayEnable};
	wire copyEnable, resetControlSignals;
	assign copyEnable = ~vgaVS & (controlSignals[0] | controlSignals[1]);
	
	// Clock
	input procClock, clock50;
	wire clockVGA, clockExtFramebuffer;
	GPUVGAController vgaController(clockVGA, displayEnable, row, col, vgaHS, vgaVS);
	GPUVGAClock vgaClock(clock50, clockVGA);
	assign clockExtFramebuffer = copyEnable ? clockVGA : procClock;
	
	initial begin
		controlSignals <= 64'b0010; // Blank the display
	end
	always @(posedge clock50) begin
		if (resetControlSignals) begin
			controlSignals[1:0] <= 2'b00;
		end
		else if (write & controlAddress) begin
			controlSignals <= data;
		end
	end
	
	// Data bus
	assign data = (read & controlAddress) ? controlSignals : 64'bz;
	assign data = (read & statusAddress) ? statusSignals : 64'bz;
	assign data = (read & characterAddress) ? extFramebufferOut : 64'bz;
	
	// Copy counter
	reg lastCopyEnable;
	reg [10:0] copyCounter;
	assign resetControlSignals = ~copyEnable & lastCopyEnable;
	initial begin
		lastCopyEnable <= 1'b0;
		copyCounter <= 11'b0;
	end
	always @(negedge clockVGA) begin
		lastCopyEnable <= copyEnable;
	end
	always @(posedge clockVGA) begin
		if (copyEnable) begin
			copyCounter <= copyCounter + 11'b1;
		end
		else begin
			copyCounter <= 11'b0;
		end
	end
	
	// Char/Pixel display
	wire [10:0] charPixelDisplayAddress;
	GPUCharPixelDisplay charPixelDisplay(clockVGA, controlSignals[2], controlSignals[14:3], row, col, intFramebufferOut, charPixelDisplayAddress, vga);
	
	// Framebuffers
	assign extFramebufferIn = controlSignals[1] ? 64'b0 : data;
	assign intFramebufferIn = controlSignals[1] ? 64'b0 : extFramebufferOut;
	assign extFramebufferAddress = copyEnable ? copyCounter : address[10:0] - GPUCharactersAddressMin;
	assign intFramebufferAddress = copyEnable ? copyCounter - 11'd1 : charPixelDisplayAddress;
	GPUFramebuffer external(extFramebufferAddress, clockExtFramebuffer, extFramebufferIn, (~vgaVS & controlSignals[1]) | (characterAddress & write), extFramebufferOut);
	GPUFramebuffer internal(intFramebufferAddress, clockVGA, intFramebufferIn, copyEnable, intFramebufferOut);
endmodule
