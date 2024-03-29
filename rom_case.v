// auto generated from http://users.rowan.edu/~haskellt8/assembler/
module rom_case(out, address);
	output reg [31:0] out;
	input  [15:0] address; // address- 16 deep memory  
	always @(address) begin
		case (address)
			16'h0000:  out = 32'b11010010100000000000000000100001; // MOVZ X1, 1
			16'h0001:  out = 32'b11010010100000000000000001000010; // MOVZ X2, 2
			16'h0002:  out = 32'b10001011000000100000000000100100; // ADD X4, X1, X2
			16'h0003:  out = 32'b11111000000000010000001111100100; // STUR X4, [XZR, 16]
			16'h0004:  out = 32'b11111000010000010000001111100101; // LDUR X5, [XZR, 16]
			16'h0005:  out = 32'b10010100000000000000000000001010; // BL 10
			16'h0006:  out = 32'b10110101000000000000000000100010; // CBNZ X2, 1
			16'h0007:  out = 32'b00010100000000000000000000000001; // B 1
			16'h0008:  out = 32'b00010111111111111111111111111001; // B -7
			16'h0009:  out = 32'b10110100000000000000000001100001; // CBZ X1, 3
			16'h000a:  out = 32'b11101011000000100000000000111111; // SUBS XZR, X1, X2
			16'h000b:  out = 32'b01010100000000000000000000100011; // B.LO 1
			16'h000c:  out = 32'b11111000000000001000001111100001; // STUR X1, [XZR, 8]
			16'h000d:  out = 32'b11111000010000001000001111100110; // LDUR X6, [XZR, 8]
			16'h000e:  out = 32'b11010010000000000000010011100111; // EORI X7, X7, 1
			16'h000f:  out = 32'b00010111111111111111111111111110; // B -2
			16'h0010:  out = 32'b10010001000000000000100000100001; // ADDI X1, X1, 2
			16'h0011:  out = 32'b11010001000000000000010001000010; // SUBI X2, X2, 1
			16'h0012:  out = 32'b11010110000000000000001111000000; // BR X30
			default: out=32'hD60003E0; //BR XZR
		endcase
	end
endmodule

/*
C code for above asm:
X1 = 1;
X2 = 2;
while(1) {
	X4 = X1 + X2;
	M[16] = X4;
	X5 = M[16];
	IncDec();
	if(X2 == 0) {
		break;
	}
}
if(X1 != 0) {
	if(X1 > X2) {
		M[8] = X1;
	}
}
X6 = M[8]
while(1){
	X7 = X7 ^ 1;
}

void IncDec(void) {
	X1 = X1 + 1;
	X2 = X2 - 1
}
*/