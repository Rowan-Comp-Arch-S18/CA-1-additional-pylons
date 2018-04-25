module GPUCharPixelDisplay(clock, pixelMode, backgroundColor, row, col, charDataIn, charAddress, vga);
	input clock, pixelMode;
	input [11:0] backgroundColor;
	input [9:0] row, col;
	input [63:0] charDataIn;
	output [10:0] charAddress;
	output [11:0] vga;
	
	// Calculate the next charAddress
	wire [11:0] colPlusOne;
	assign colPlusOne = col + 10'd1;
	wire [11:0] charAddressCalcTemp, charAddressCalc, pixelAddressCalc;
	// Char
	assign charAddressCalcTemp = {row[9:4], 1'b0} + {row[9:4], 3'b000};
	assign charAddressCalc = colPlusOne[10:5] + {charAddressCalcTemp, 1'b0};
	// Pixel
	assign pixelAddressCalc = 10'd600 + {row[9:3], 3'b000} + row[9:3] + row[9:3] + colPlusOne[10:6];
	
	reg [63:0] charData;
	initial begin
		charData <= 64'b0;
	end
	always @(posedge clock) begin
		charData <= charDataIn;
	end
	
	// Character calculations
	wire [11:0] charColorCalc, charColor;
	wire [15:0] charBlock;
	wire charPixelOn;
	Mux4to1Nbit charBlockSelector(col[4:3], charData[63:48], charData[47:32], charData[31:16], charData[15:0], charBlock);
	defparam charBlockSelector.N = 16;
	GPUCharDecoder charDecoder(row[3:0], col[2:0], charBlock[15:8], charPixelOn);
	GPUColorDecoder charR(charBlock[7:6], charColorCalc[11:8]);
	GPUColorDecoder charG(charBlock[5:4], charColorCalc[7:4]);
	GPUColorDecoder charB(charBlock[3:2], charColorCalc[3:0]);
	assign charColor = charPixelOn ? charColorCalc : backgroundColor;
	
	// Pixel calculations
	wire [11:0] pixelColor;
	wire [7:0] pixelBlock;
	Mux8to1Nbit pixelBlockSelector(col[5:3], charData[63:56], charData[55:48], charData[47:40], charData[39:32], charData[31:24], charData[23:16], charData[15:8], charData[7:0], pixelBlock);
	defparam pixelBlockSelector.N = 8;
	GPUColorDecoder pixelR(pixelBlock[7:6], pixelColor[11:8]);
	GPUColorDecoder pixelG(pixelBlock[5:4], pixelColor[7:4]);
	GPUColorDecoder pixelB(pixelBlock[3:2], pixelColor[3:0]);
	
	// Select the correct output
	assign charAddress = pixelMode ? pixelAddressCalc : charAddressCalc;
	assign vga = pixelMode ? pixelColor : charColor;
endmodule
