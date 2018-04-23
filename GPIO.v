module GPIO(clock, data, GPIO0);
	
	input clock;
	input data;
	output [31:0] GPIO0;
	
	wire [127:0] Screen_Data;
	wire [3:0] SevSegData;
	
	inst1 Screen_Render (clockin, SevSegData, Screen_Data[127:112], Screen_Data[113:96], 
		Screen_Data[95:80], Screen_Data[79:64], Screen_Data[63:48], Screen_Data[47:32], 
		Screen_Data[31:16], Screen_Data[15:0], GPIO0);
	
	
endmodule
