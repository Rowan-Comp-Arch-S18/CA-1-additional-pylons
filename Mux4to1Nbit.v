module Mux4to1Nbit(S, I00, I01, I02, I03, F);
	parameter N = 64;
	
	input [1:0] S; //2b select
	input [N-1:0] I00, I01, I02, I03;//Nb inputs
	
	output reg [N-1:0] F; //Nb output
	
	always @(*) begin
		case(S)
			2'b00: F <= I00; //pass selected input specified by select
			2'b01: F <= I01;
			2'b10: F <= I02;
			2'b11: F <= I03;
		endcase
	end
	
endmodule
