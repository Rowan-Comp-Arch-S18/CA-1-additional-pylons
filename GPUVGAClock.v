module GPUVGAClock(clock50, clock25);
	input clock50;
	output reg clock25;
	
	initial begin
		clock25 <= 0;
	end
	
	always @(posedge clock50) begin
		clock25 <= ~clock25;
	end
endmodule
