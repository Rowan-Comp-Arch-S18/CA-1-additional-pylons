module GPIO(clock, data, address, read, write, GPIO0);
	
	input clock;
	input [63:0] data;
	input [63:0] address;
	input read, write;
	output [31:0] GPIO0;
	
	reg [127:0] Screen_Data;
	reg [3:0] SevSegData;
	
	always @ (negedge clock) begin
		if (read) begin
			case (address);
				64'b0000010100000000000000000000000000000000000000000000000000000000: Screen_Data[63:0] <= data;
				64'b0000010100000000000000000000000000000000000000000000000000000001: Screen_Data[127:64] <= data;
				64'b0000010100000000000000000000000000000000000000000000000000000002: SevSegData <= data[3:0];
				default: Screen_Data <= Screen_Data;
			endcase
		end
	end
	
	inst1 Screen_Render (clockin, SevSegData, Screen_Data[127:112], Screen_Data[113:96], 
		Screen_Data[95:80], Screen_Data[79:64], Screen_Data[63:48], Screen_Data[47:32], 
		Screen_Data[31:16], Screen_Data[15:0], GPIO0);
	
	
endmodule
