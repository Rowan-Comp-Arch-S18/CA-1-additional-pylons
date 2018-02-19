module Mux8to1(S, I0, I1, I2, I3, I4, I5, I6, I7, F); 
	input [2:0] S; //3b select
	input [63:0] I0, I1, I2, I3, I4, I5, I6, I7; //64b inputs
	
	output [63:0] F; //64b output
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0)); //pass selected input specified by select
endmodule
