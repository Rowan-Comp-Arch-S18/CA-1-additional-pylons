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
	reg [31:0] SevSegData;
	reg [63:0] counter;
	
	wire correctAddress;
	wire [63:0] outData;
	
	assign outData = (address[31:0] == 32'd4) ? counter : {{19'b0},{switch},{~button},{GPIO1}};
	assign correctAddress = (address[63:56] == GPIOAddress);
	assign data = (read & correctAddress) ? outData : 64'bz;
	
	always @ (posedge clock) begin
		counter <= counter + 1'b1;
		if ((address == 64'b0000010100000000000000000000000000000000000000000000000000000001) & write) begin Screen_Data[63:0] <= data; end
		if ((address == 64'b0000010100000000000000000000000000000000000000000000000000000010) & write) begin Screen_Data[127:64] <= data; end
	end
	always @ (posedge clock) begin
		if ((address == 64'b0000010100000000000000000000000000000000000000000000000000000011) & write) begin SevSegData <= data[31:0]; end
	end
	Screen_Render inst1(clock, SevSegData, Screen_Data[63:48], Screen_Data[47:32], 
		Screen_Data[31:16], Screen_Data[15:0], Screen_Data[127:112], Screen_Data[113:96], 
		Screen_Data[95:80], Screen_Data[79:64], GPIO0);
	
	
endmodule
