module GPIO(clock, GPIO1, button, switch, data, address, read, write, GPIO0);
	parameter GPIOAddress = 8'b00000101;
	
	input clock;
	input [31:0] GPIO1;
	input [2:0] button;
	input [9:0] switch;
	inout [63:0] data;
	input [63:0] address;
	input read, write;
	output [31:0] GPIO0;
	
	reg [127:0] Screen_Data;
	reg [3:0] SevSegData;
	
	wire correctAddress;
	wire [63:0] outData;
	
	assign outData = {{19'b0},{switch},{~button},{GPIO1}};
	assign correctAddress = (address[63:56] == GPIOAddress);
	assign data = (read & correctAddress) ? outData : 64'bz;
	
	always @ (negedge clock) begin
		if (write) begin
			if (address == 64'b0000010100000000000000000000000000000000000000000000000000000001) begin Screen_Data[63:0] <= data; end
			if (address == 64'b0000010100000000000000000000000000000000000000000000000000000010) begin Screen_Data[127:64] <= data; end
			if (address == 64'b0000010100000000000000000000000000000000000000000000000000000011) begin SevSegData <= data[3:0]; end
		end
	end
	
	Screen_Render inst1(clock, SevSegData, Screen_Data[63:48], Screen_Data[47:32], 
		Screen_Data[31:16], Screen_Data[15:0], Screen_Data[127:112], Screen_Data[113:96], 
		Screen_Data[95:80], Screen_Data[79:64], GPIO0);
	
	
endmodule
