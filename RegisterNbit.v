module RegisterNbit(Q, D, load, reset, clock);
	parameter N = 64;
	
	input load; // 1b load enable
	input reset; // 1b async positive edge reset
	input clock; // 1b positve edge clock
	input [N-1:0] D; // data input
	
	output reg [N-1:0] Q; //Nb output
	
	always @(posedge clock or posedge reset) begin
		if(reset)
			Q <= 0; //reset if reset is true
		else if(load)
			Q <= D; //load if load is true
		else
			Q <= Q; //hold otherwise
	end
endmodule
