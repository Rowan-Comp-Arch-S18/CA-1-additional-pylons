module GPUVGAController(clockVGA, displayEnable, row, col, hsync_n, vsync_n);
	// Display properties
	parameter displayWidth = 640;
	parameter displayHeight = 480;
	
	// hsync properties
	parameter hsyncTime = 96;
	parameter hBPTime = 48;
	parameter hFPTime = 16;
	
	// vsync properties
	parameter vsyncTime = 2;
	parameter vBPTime = 33;
	parameter vFPTime = 10;
	
	// Ports
	input clockVGA;
	output displayEnable;
	output [9:0] row, col;
	output hsync_n, vsync_n;
	
	// States
	parameter syncState = 4'0001;
	parameter bpState = 4'b0010;
	parameter displayState = 4'b0100;
	parameter fpState = 4'b1000;
	wire [3:0] hState, vState;
	// Horizontal
	assign hState = (hCounter < hsyncTime) ? syncState : 4'bz;
	assign hState = ((hCounter >= hsyncTime) & (hCounter < hsyncTime + hBPTime)) ? bpState : 4'bz;
	assign hState = ((hCounter >= hsyncTime + hBPTime) & (hCounter < hsyncTime + hBPtime + displayWidth)) ? displayState : 4'bz;
	assign hState = ((hCounter >= hsyncTime + hBPTime + displayWidth) & (hCounter < hsyncTime + hBPTime + displayWidth + hFPTime)) ? fpState : 4'bz;
	// Vertical
	assign vState = (vCounter < vsyncTime) ? syncState : 4'bz;
	assign vState = ((vCounter >= vsyncTime) & (vCounter < vsyncTime + vBPTime)) ? bpState : 4'bz;
	assign vState = ((vCounter >= vsyncTime + vBPTime) & (vCounter < vsyncTime + vBPtime + displayWidth)) ? displayState : 4'bz;
	assign vState = ((vCounter >= vsyncTime + vBPTime + displayWidth) & (vCounter < vsyncTime + vBPTime + displayWidth + vFPTime)) ? fpState : 4'bz;
	
	// Syncs
	assign hsync_n = ~hState[0];
	assign vsync_n = ~vState[0];
	
	// Display enable
	assign displayEnable = hState[2] & vState[2];
	
	// Location
	reg [9:0] hCounter, vCounter;
	assign col = hCounter - (hsyncTime + hBPTime);
	assign row = vCounter - (vsyncTime + vBPTime);
	
	initial begin
		hCounter <= 0;
		vCounter <= 0;
	end
	
	always @(posedge clockVGA) begin
		
	end
endmodule
