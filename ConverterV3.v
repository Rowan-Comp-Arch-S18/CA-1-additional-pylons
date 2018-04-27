module ConverterV3(ADDRESS, CLOCK_50, PS2_KBCLK, PS2_KBDAT, OUT);
	input [63:0] ADDRESS;												// Address
	input CLOCK_50;														// Board clock
   input PS2_KBCLK;														// Keyboard clock
   input PS2_KBDAT;														// Keyboard data
	
	output [63:0] OUT;
	
	reg [63:0] outReg;
	
	wire [63:0] reg0, reg1;
	
	parameter KB_ADDRESS = 8'b00000001;
	
	assign correctAddress = (ADDRESS[63:56] == KB_ADDRESS) ? 1'b1 : 1'b0;
	assign OUT = correctAddress ? outReg : 64'bz;
	
	KeyboardV3 keyboard(CLOCK_50, PS2_KBCLK, PS2_KBDAT, reg0, reg1);
	
	always @(negedge CLOCK_50) begin
		if (ADDRESS[0] == 0)
			outReg <= reg0;
		if (ADDRESS[0] == 1)
			outReg <= reg1;
	end
	
endmodule
