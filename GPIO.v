module GPIO(clock, GPIO1, button, switch, data, address, read, write, GPIO0, hex0, hex1, hex2, hex3);
	parameter GPIOAddress = 8'b00000101;
	
	input clock;
	input [31:0] GPIO1;
	input [2:0] button;
	input [9:0] switch;
	inout [63:0] data;
	input [63:0] address;
	input read, write;
	output [31:0] GPIO0;
	output [6:0] hex0, hex1, hex2, hex3;
	
	reg [127:0] Screen_Data;
	reg [31:0] SevSegData;
	reg [63:0] counter;
	
	wire correctAddress;
	wire [63:0] outData;
	
	assign outData = (address[31:0] == 32'd4) ? counter : {{19'b0},{switch},{~button},{GPIO1}};
	assign correctAddress = (address[63:56] == GPIOAddress);
	assign data = (read & correctAddress) ? outData : 64'bz;
	
	Hex_to_Dec u0(clock, hex3, hex2, hex1, hex0);
	
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

module Hex_to_Dec(clock, out3, out2, out1, out0);

	input clock;
	output reg [6:0]out0, out1, out2, out3;
	reg [63:0] count;
	reg [63:0] c;
	
	initial begin
		c <= 64'b0;
		count <= 64'b0;
	end
	
	always @ (posedge clock) begin
		c <= c + 64'b1;
	end
	
	always @ (posedge c[22]) begin
		if (count[3:0] <= 4'h8)
			count <= count + 64'd1;
		else begin
			if (count[3:0] > 4'h8)
				count <= count + 64'd7;
			if (count[7:4] > 4'h8)
				count[63:4] <= count[63:4] + 64'd7;
			if (count[11:8] > 4'h8)
				count[63:8] <= count[63:8] + 64'd7;
			if (count[15:12] > 4'h8)
				count[63:12] <= count[63:12] + 64'd7;
		end
	end
	
	always @ (count) begin
		case(count[3:0])
			4'h0: out0 <= ~7'b0111111;
			4'h1: out0 <= ~7'b0000110;
			4'h2: out0 <= ~7'b1011011;
			4'h3: out0 <= ~7'b1001111;
			4'h4: out0 <= ~7'b1100110;
			4'h5: out0 <= ~7'b1101101;
			4'h6: out0 <= ~7'b1111101;
			4'h7: out0 <= ~7'b0000111;
			4'h8: out0 <= ~7'b1111111;
			4'h9: out0 <= ~7'b1101111;
			4'ha: out0 <= ~7'b1110111;
			4'hb: out0 <= ~7'b1111100;
			4'hc: out0 <= ~7'b0111001;
			4'hd: out0 <= ~7'b1011110;
			4'he: out0 <= ~7'b1111001;
			4'hf: out0 <= ~7'b1110001;
			default: out0 <= ~7'b0000000;
		endcase
		case(count[7:4])
			4'h0: out1 <= ~7'b0111111;
			4'h1: out1 <= ~7'b0000110;
			4'h2: out1 <= ~7'b1011011;
			4'h3: out1 <= ~7'b1001111;
			4'h4: out1 <= ~7'b1100110;
			4'h5: out1 <= ~7'b1101101;
			4'h6: out1 <= ~7'b1111101;
			4'h7: out1 <= ~7'b0000111;
			4'h8: out1 <= ~7'b1111111;
			4'h9: out1 <= ~7'b1101111;
			4'ha: out1 <= ~7'b1110111;
			4'hb: out1 <= ~7'b1111100;
			4'hc: out1 <= ~7'b0111001;
			4'hd: out1 <= ~7'b1011110;
			4'he: out1 <= ~7'b1111001;
			4'hf: out1 <= ~7'b1110001;
			default: out1 <= ~7'b0000000;
		endcase
		case(count[11:8])
			4'h0: out2 <= ~7'b0111111;
			4'h1: out2 <= ~7'b0000110;
			4'h2: out2 <= ~7'b1011011;
			4'h3: out2 <= ~7'b1001111;
			4'h4: out2 <= ~7'b1100110;
			4'h5: out2 <= ~7'b1101101;
			4'h6: out2 <= ~7'b1111101;
			4'h7: out2 <= ~7'b0000111;
			4'h8: out2 <= ~7'b1111111;
			4'h9: out2 <= ~7'b1101111;
			4'ha: out2 <= ~7'b1110111;
			4'hb: out2 <= ~7'b1111100;
			4'hc: out2 <= ~7'b0111001;
			4'hd: out2 <= ~7'b1011110;
			4'he: out2 <= ~7'b1111001;
			4'hf: out2 <= ~7'b1110001;
			default: out2 <= ~7'b0000000;
		endcase
		case(count[15:12])
			4'h0: out3 <= ~7'b0111111;
			4'h1: out3 <= ~7'b0000110;
			4'h2: out3 <= ~7'b1011011;
			4'h3: out3 <= ~7'b1001111;
			4'h4: out3 <= ~7'b1100110;
			4'h5: out3 <= ~7'b1101101;
			4'h6: out3 <= ~7'b1111101;
			4'h7: out3 <= ~7'b0000111;
			4'h8: out3 <= ~7'b1111111;
			4'h9: out3 <= ~7'b1101111;
			4'ha: out3 <= ~7'b1110111;
			4'hb: out3 <= ~7'b1111100;
			4'hc: out3 <= ~7'b0111001;
			4'hd: out3 <= ~7'b1011110;
			4'he: out3 <= ~7'b1111001;
			4'hf: out3 <= ~7'b1110001;
			default: out3 <= ~7'b0000000;
		endcase
	end
	
endmodule
