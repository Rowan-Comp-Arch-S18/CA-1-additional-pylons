module Decimalto7Seg(in, out);
	
	input [3:0] in;
	output reg [7:0] out;
	
	always @ (in) begin
		case(in)
			4'h0: out <= 8'b00111111;
			4'h1: out <= 8'b00000110;
			4'h2: out <= 8'b01011011;
			4'h3: out <= 8'b01001111;
			4'h4: out <= 8'b01100110;
			4'h5: out <= 8'b01101101;
			4'h6: out <= 8'b01111101;
			4'h7: out <= 8'b00000111;
			4'h8: out <= 8'b01111111;
			4'h9: out <= 8'b01101111;
			default: out <= 8'b00000000;
		endcase
	end
endmodule
