module Mux32to1Nbit(S, I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31, F);
	parameter N = 8;
	
	input [4:0] S; //5b select
	input [N-1:0] I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12, I13, I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31; //Nb inputs
	
	output reg [N-1:0] F; //Nb output
	
	always @(*) begin
		case(S)
			5'b00000: F <= I00; //pass selected input specified by select
			5'b00001: F <= I01;
			5'b00010: F <= I02;
			5'b00011: F <= I03;
			5'b00100: F <= I04;
			5'b00101: F <= I05;
			5'b00110: F <= I06;
			5'b00111: F <= I07;
			5'b01000: F <= I08;
			5'b01001: F <= I09;
			5'b01010: F <= I10;
			5'b01011: F <= I11;
			5'b01100: F <= I12;
			5'b01101: F <= I13;
			5'b01110: F <= I14;
			5'b01111: F <= I15;
			5'b10000: F <= I16;
			5'b10001: F <= I17;
			5'b10010: F <= I18;
			5'b10011: F <= I19;
			5'b10100: F <= I20;
			5'b10101: F <= I21;
			5'b10110: F <= I22;
			5'b10111: F <= I23;
			5'b11000: F <= I24;
			5'b11001: F <= I25;
			5'b11010: F <= I26;
			5'b11011: F <= I27;
			5'b11100: F <= I28;
			5'b11101: F <= I29;
			5'b11110: F <= I30;
			5'b11111: F <= I31;
		endcase
	end
	
endmodule
