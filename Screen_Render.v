module Screen_Render(clockin, SevSeg, R1, R2, R3, R4, R5, R6, R7, R8, GPIO0);
	
	input clockin;
	input [31:0] SevSeg;
	input [15:0] R1, R2, R3, R4, R5, R6, R7, R8;
	output [31:0]GPIO0;
	
	wire [31:0]row;
	wire [15:0]column;
	
	reg [5:0]count;
	wire [7:0]andwire;
	wire [15:0]andwire2;
	wire [7:0]rowselect;
	
	wire [7:0] SegOut;
	wire [3:0] SegIn;
	
	assign andwire2[15:8] = andwire, andwire2[7:0] = andwire;
	assign GPIO0[31:24] = (SegOut & andwire2);
	assign row[31:24] = 8'b00000000;
	assign GPIO0[23:8] = (column & andwire2), GPIO0[7:0] = (row[7:0] & andwire);
	
	
	Decimalto7Seg inst5(count[2:0], SevSeg[31:0], SegOut);
	
	anding inst3 (count, andwire);
	timekeep inst4 (clockin, clock);
	
	always @(posedge clock)begin
		count <= (count + 6'b000001);
	end
	
	initial 
		count<=0;
	
	decoder inst1(clock, count[2:0], row[7:0]);
	mux inst2(clock, count[2:0], R1, R2, R3, R4, R5, R6, R7, R8, column);
	//muxHex mux3(clock, count[2:0], SevSeg[3:0], SevSeg[7:4], SevSeg[11:8], SevSeg[15:12], SevSeg[19:16], SevSeg[23:20],SevSeg[27:24],SevSeg[31:28], SevIn);
	
endmodule 



module decoder(clock, in, out);
	
	input clock;
	input [2:0]in;
	output reg [7:0]out;
	
	always @(in) begin
		
		case(in)
			3'b000: out <= 8'b00000001;
			3'b001: out <= 8'b00000010;
			3'b010: out <= 8'b00000100;
			3'b011: out <= 8'b00001000;
			3'b100: out <= 8'b00010000;
			3'b101: out <= 8'b00100000;
			3'b110: out <= 8'b01000000;
			3'b111: out <= 8'b10000000;
			default: out <= 16'b0000000000000000;
		endcase
	end
endmodule


module mux(clock, S, R1, R2, R3, R4, R5, R6, R7, R8, out);
	input clock;
	input [2:0]S;
	input [15:0]R1, R2, R3, R4, R5, R6, R7, R8;
	output reg [15:0]out;
	always @(S) begin
		case(S[2:0])
			3'b000: out <= R1;
			3'b001: out <= R2;
			3'b010: out <= R3;
			3'b011: out <= R4;
			3'b100: out <= R5;
			3'b101: out <= R6;
			3'b110: out <= R7;
			3'b111: out <= R8;
			default: out <= 16'b0000000000000000;
		endcase	
	end
	
endmodule	
module muxHex(clock, S, R1, R2, R3, R4, R5, R6, R7, R8, out);
	input clock;
	input [2:0]S;
	input [3:0]R1, R2, R3, R4, R5, R6, R7, R8;
	output reg [3:0]out;
	always @(S) begin
		case(S[2:0])
			3'b000: out <= R1;
			3'b001: out <= R2;
			3'b010: out <= R3;
			3'b011: out <= R4;
			3'b100: out <= R5;
			3'b101: out <= R6;
			3'b110: out <= R7;
			3'b111: out <= R8;
			default: out <= 4'b0000;
		endcase	
	end
	
endmodule	

module anding (S, out);

	input [5:0]S;
	output reg [7:0]out;
	
	always @(S)begin
	
		case(S)
			6'b000000: out <= 8'b11111111;
			6'b001001: out <= 8'b11111111;
			6'b010010: out <= 8'b11111111;
			6'b011011: out <= 8'b11111111;
			6'b100100: out <= 8'b11111111;
			6'b101101: out <= 8'b11111111;
			6'b110110: out <= 8'b11111111;
			6'b100111: out <= 8'b11111111;
			default: out <= 8'b00000000;
		endcase
	end
	
endmodule

module timekeep (clock_in, clock_out);
	input clock_in;
	output reg clock_out;
	
	reg [23:0]count;

	always @(posedge clock_in) begin
		if(count < 10000)
	   	count <= count + 1'b1;
		else
			count <= 1'b0;
	
		clock_out = (count < 5000) ? 1'b1 : 1'b0;
	
	end
	
endmodule
