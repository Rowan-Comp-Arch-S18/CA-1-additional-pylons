module GPUVGAClock(clock50, clock25);
	input clock50;
	output reg clock25;
	
	initial begin
		counter <= 0;
	end
	
	always @(posedge clock50) begin
		counter <= counter + 1'b1;
	end
endmodule
