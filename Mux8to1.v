module Mux8to1(S, I0, I1, I2, I3, I4, I5, I6, I7, F);
	parameter N = 8;
	
	input [2:0]S;
	input [N-1:0] I0, I1, I2, I3, I4, I5, I6, I7;
	
	output [N-1:0]F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));
endmodule
