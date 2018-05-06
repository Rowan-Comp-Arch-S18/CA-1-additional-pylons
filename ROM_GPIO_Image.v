module ROM_GPIO_Image(out, address);
output reg [31:0] out;
input  [15:0] address; // address- 16 deep memory  
always @(address) begin
case (address)
16'h0000:  out = 32'b11010010100000000000000010100001; // MOVZ X1, 5			// set registry to allocated memory
16'h0001:  out = 32'b11010010100000000000000010100110; // MOVZ X6, 5			// set starting position for player1
16'h0002:  out = 32'b11010010100000000000000010100111; // MOVZ X7, 5			// set starting position for player2
16'h0003:  out = 32'b11010010100000000000100000010000; // MOVZ X16, 64		// set starting position for ball
16'h0004:  out = 32'b11010011011000001110000000100001; // LSL X1, X1, 56
16'h0005:  out = 32'b11010010100000000000000000110001; // MOVZ X17, 1		// load top half of image into register
16'h0006:  out = 32'b11010011011000000100001000110001; // LSL X17, X17, 16
16'h0007:  out = 32'b11110010100000000000000000110001; // MOVK X17, 1
16'h0008:  out = 32'b11010011011000000100001000110001; // LSL X17, X17, 16
16'h0009:  out = 32'b11110010100000000000000000110001; // MOVK X17, 1
16'h000a:  out = 32'b11010011011000000011111000110001; // LSL X17, X17, 15
16'h000b:  out = 32'b11010010100000000000000000101111; // MOVZ X15, 1		// load top half of image into register
16'h000c:  out = 32'b11010011011000000100000111101111; // LSL X15, X15, 16
16'h000d:  out = 32'b11110010100000000000000000101111; // MOVK X15, 1
16'h000e:  out = 32'b11010011011000000100000111101111; // LSL X15, X15, 16
16'h000f:  out = 32'b11110010100000000000000000101111; // MOVK X15, 1
16'h0010:  out = 32'b11010010100000000000000000011011; // MOVZ X27, 0
16'h0011:  out = 32'b11010010100000000000000000011010; // MOVZ X26, 0
16'h0012:  out = 32'b11010010100000000000000000011001; // MOVZ X25, 0
16'h0013:  out = 32'b11010010100000000000000000001010; // MOVZ X10, 0
16'h0014:  out = 32'b11010010100000000000000000010100; // MOVZ X20, 0
16'h0015:  out = 32'b10001011000011110000001000101010; // ADD X10, X17, X15
16'h0016:  out = 32'b10001011000110010000001101110100; // ADD X20, X27, X25
16'h0017:  out = 32'b10001011000100000000000101001010; // ADD X10, X10, X16
16'h0018:  out = 32'b10001011000110100000001010010100; // ADD X20, X20, X26
16'h0019:  out = 32'b11010011011000000100001001110110; // LSL X22, X19, 16 
16'h001a:  out = 32'b10001011000100100000001011010110; // ADD X22, X22, X18
16'h001b:  out = 32'b11111000000000000001000000111111; // STUR XZR, [X1, 1]	// store and load image
16'h001c:  out = 32'b11111000000000000010000000111111; // STUR XZR, [X1, 2]
16'h001d:  out = 32'b11111000000000000001000000101010; // STUR X10, [X1, 1]	// store and load image
16'h001e:  out = 32'b11111000000000000010000000110100; // STUR X20, [X1, 2]
16'h001f:  out = 32'b11111000000000000011000000111111; // STUR XZR, [X1, 3]
16'h0020:  out = 32'b11111000010000000011000000111110; // LDUR X30, [X1, 3]
16'h0021:  out = 32'b11111000000000000011000000110110; // STUR X22, [X1, 3]
16'h0022:  out = 32'b11111000000000000100000000111111; // STUR XZR, [X1, 4]
16'h0023:  out = 32'b11111000010000000100000000111101; // LDUR X29, [X1, 4]
16'h0024:  out = 32'b11111000000000000100000000111101; // STUR X29, [X1, 4]
16'h0025:  out = 32'b11010011011000001000001111000010; // LSL X2, X30, 32
16'h0026:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0027:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0028:  out = 32'b01010100000000000000000100100001; // B.NE 9	
16'h0029:  out = 32'b11010001000000000000010011100111; // SUBI X7, X7, 1
16'h002a:  out = 32'b11010010100000000000000000001011; // MOVZ X11, 0
16'h002b:  out = 32'b11010010100000000000000000001101; // MOVZ X13, 0
16'h002c:  out = 32'b11010011011000001100001101101101; // LSL X13, X27, 48	//down
16'h002d:  out = 32'b11010011011000001100001000101011; // LSL X11, X17, 48
16'h002e:  out = 32'b11010011010000000100001000110001; // LSR X17, X17, 16
16'h002f:  out = 32'b11010011010000000100001101111011; // LSR X27, X27, 16
16'h0030:  out = 32'b10001011000011010000001000110001; // ADD X17, X17, X13
16'h0031:  out = 32'b10001011000010110000001101111011; // ADD X27, X27, X11	//end of down
16'h0032:  out = 32'b11010011011000001000011111000010; // LSL X2, X30, 33
16'h0033:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0034:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0035:  out = 32'b01010100000000000000000100100001; // B.NE 9	
16'h0036:  out = 32'b10010001000000000000010011100111; // ADDI X7, X7, 1
16'h0037:  out = 32'b11010010100000000000000000010101; // MOVZ X21, 0
16'h0038:  out = 32'b11010010100000000000000000010111; // MOVZ X23, 0
16'h0039:  out = 32'b11010011010000001100001000110111; // LSR X23, X17, 48	//up
16'h003a:  out = 32'b11010011010000001100001101110101; // LSR X21, X27, 48
16'h003b:  out = 32'b11010011011000000100001000110001; // LSL X17, X17, 16
16'h003c:  out = 32'b11010011011000000100001101111011; // LSL X27, X27, 16
16'h003d:  out = 32'b10001011000101110000001101111011; // ADD X27, X27, X23
16'h003e:  out = 32'b10001011000101010000001000110001; // ADD X17, X17, X21	//end of up
16'h003f:  out = 32'b11010011011000001111111111000010; // LSL X2, X30, 63
16'h0040:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0041:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0042:  out = 32'b01010100000000000000000100100001; // B.NE 9
16'h0043:  out = 32'b11010001000000000000010011000110; // SUBI X6, X6, 1
16'h0044:  out = 32'b11010010100000000000000000001011; // MOVZ X11, 0
16'h0045:  out = 32'b11010010100000000000000000001101; // MOVZ X13, 0
16'h0046:  out = 32'b11010011011000001100001100101101; // LSL X13, X25, 48	//down
16'h0047:  out = 32'b11010011011000001100000111101011; // LSL X11, X15, 48
16'h0048:  out = 32'b11010011010000000100000111101111; // LSR X15, X15, 16
16'h0049:  out = 32'b11010011010000000100001100111001; // LSR X25, X25, 16
16'h004a:  out = 32'b10001011000011010000000111101111; // ADD X15, X15, X13
16'h004b:  out = 32'b10001011000010110000001100111001; // ADD X25, X25, X11	//end of down
16'h004c:  out = 32'b11010011011000001111101111000010; // LSL X2, X30, 62
16'h004d:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h004e:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h004f:  out = 32'b01010100000000000000000100100001; // B.NE 9
16'h0050:  out = 32'b10010001000000000000010011000110; // ADDI X6, X6, 1
16'h0051:  out = 32'b11010010100000000000000000010101; // MOVZ X21, 0
16'h0052:  out = 32'b11010010100000000000000000010111; // MOVZ X23, 0
16'h0053:  out = 32'b11010011010000001100000111110111; // LSR X23, X15, 48	//up
16'h0054:  out = 32'b11010011010000001100001100110101; // LSR X21, X25, 48
16'h0055:  out = 32'b11010011011000000100000111101111; // LSL X15, X15, 16
16'h0056:  out = 32'b11010011011000000100001100111001; // LSL X25, X25, 16
16'h0057:  out = 32'b10001011000101110000001100111001; // ADD X25, X25, X23
16'h0058:  out = 32'b10001011000101010000000111101111; // ADD X15, X15, X21	//end of up
16'h0059:  out = 32'b11010010100000000000000000001001; // MOVZ X9, 0			//checking ball on player1 side
16'h005a:  out = 32'b11010011011000001111101000000010; // LSL X2, X16, 62
16'h005b:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h005c:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h005d:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h005e:  out = 32'b11010010100000000000000010001000; // MOVZ X8, 4
16'h005f:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h0060:  out = 32'b11010011011000001011101000000010; // LSL X2, X16, 46
16'h0061:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0062:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0063:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0064:  out = 32'b11010010100000000000000010101000; // MOVZ X8, 5
16'h0065:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h0066:  out = 32'b11010011011000000111101000000010; // LSL X2, X16, 30
16'h0067:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0068:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0069:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h006a:  out = 32'b11010010100000000000000011001000; // MOVZ X8, 6
16'h006b:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h006c:  out = 32'b11010011011000000011101000000010; // LSL X2, X16, 14
16'h006d:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h006e:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h006f:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0070:  out = 32'b11010010100000000000000011101000; // MOVZ X8, 7
16'h0071:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h0072:  out = 32'b11010011011000001111101101000010; // LSL X2, X26, 62
16'h0073:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0074:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0075:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0076:  out = 32'b11010010100000000000000000001000; // MOVZ X8, 0
16'h0077:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h0078:  out = 32'b11010011011000001011101101000010; // LSL X2, X26, 46
16'h0079:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h007a:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h007b:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h007c:  out = 32'b11010010100000000000000000101000; // MOVZ X8, 1
16'h007d:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h007e:  out = 32'b11010011011000000111101101000010; // LSL X2, X26, 30
16'h007f:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0080:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0081:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0082:  out = 32'b11010010100000000000000001001000; // MOVZ X8, 2
16'h0083:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h0084:  out = 32'b11010011011000000011101101000010; // LSL X2, X26, 14
16'h0085:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0086:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0087:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0088:  out = 32'b11010010100000000000000001101000; // MOVZ X8, 3
16'h0089:  out = 32'b11010010100000000000000000101001; // MOVZ X9, 1
16'h008a:  out = 32'b11010011011000001100011000000010; // LSL X2, X16, 49		//checking ball on player2 side
16'h008b:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h008c:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h008d:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h008e:  out = 32'b11010010100000000000000010001000; // MOVZ X8, 4
16'h008f:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h0090:  out = 32'b11010011011000001000011000000010; // LSL X2, X16, 33
16'h0091:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0092:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0093:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0094:  out = 32'b11010010100000000000000010101000; // MOVZ X8, 5
16'h0095:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h0096:  out = 32'b11010011011000000100011000000010; // LSL X2, X16, 17
16'h0097:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0098:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0099:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h009a:  out = 32'b11010010100000000000000011001000; // MOVZ X8, 6
16'h009b:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h009c:  out = 32'b11010011011000000000011000000010; // LSL X2, X16, 1
16'h009d:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h009e:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h009f:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00a0:  out = 32'b11010010100000000000000011101000; // MOVZ X8, 7
16'h00a1:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h00a2:  out = 32'b11010011011000001100011101000010; // LSL X2, X26, 49
16'h00a3:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h00a4:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h00a5:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00a6:  out = 32'b11010010100000000000000000001000; // MOVZ X8, 0
16'h00a7:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h00a8:  out = 32'b11010011011000001000011101000010; // LSL X2, X26, 33
16'h00a9:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h00aa:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h00ab:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00ac:  out = 32'b11010010100000000000000000101000; // MOVZ X8, 1
16'h00ad:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h00ae:  out = 32'b11010011011000000100011101000010; // LSL X2, X26, 17
16'h00af:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h00b0:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h00b1:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00b2:  out = 32'b11010010100000000000000001001000; // MOVZ X8, 2
16'h00b3:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h00b4:  out = 32'b11010011011000000000011101000010; // LSL X2, X26, 1
16'h00b5:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63 
16'h00b6:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h00b7:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00b8:  out = 32'b11010010100000000000000001101000; // MOVZ X8, 3
16'h00b9:  out = 32'b11010010100000000000000001001001; // MOVZ X9, 2
16'h00ba:  out = 32'b11010010100000000000000000001100; // MOVZ X12, 0
16'h00bb:  out = 32'b11110001000000000000000100101001; // SUBIS X9, X9, 0
16'h00bc:  out = 32'b01010100000000000000001101100000; // B.EQ 27
16'h00bd:  out = 32'b11110001000000000000100100111100; // SUBIS X28, X9, 2
16'h00be:  out = 32'b01010100000000000000000001000000; // B.EQ 2
16'h00bf:  out = 32'b11010010100000000000000000011100; // MOVZ X28, 0
16'h00c0:  out = 32'b10010001000000000000000011011100; // ADDI X28, X6, 0
16'h00c1:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00c2:  out = 32'b11010010100000000000000000011100; // MOVZ X28, 0
16'h00c3:  out = 32'b10010001000000000000000011111100; // ADDI X28, X7, 0
16'h00c4:  out = 32'b11010011011000001111011110000010; // LSL X2, X28, 61		//checking paddle against ball
16'h00c5:  out = 32'b11010011010000001111010001000010; // LSR X2, X2, 61
16'h00c6:  out = 32'b11101011000010000000000001000101; // SUBS X5, X2, X8
16'h00c7:  out = 32'b01010100000000000000000010000001; // B.NE 4
16'h00c8:  out = 32'b11010010100000000000000000000011; // MOVZ X3, 0
16'h00c9:  out = 32'b11110001000000000000100100100010; // SUBIS X2, X9, 2
16'h00ca:  out = 32'b01010100000000000000000000100000; // B.EQ 1 
16'h00cb:  out = 32'b10010001000000000000010001100011; // ADDI X3, X3, 1
16'h00cc:  out = 32'b11110001000000000000010010100010; // SUBIS X2, X5, 1
16'h00cd:  out = 32'b01010100000000000000000010000001; // B.NE 4
16'h00ce:  out = 32'b11010010100000000000000010000011; // MOVZ X3, 4
16'h00cf:  out = 32'b11110001000000000000100100100010; // SUBIS X2, X9, 2
16'h00d0:  out = 32'b01010100000000000000000000100000; // B.EQ 1 
16'h00d1:  out = 32'b10010001000000000000010001100011; // ADDI X3, X3, 1
16'h00d2:  out = 32'b10110001000000000000010010100010; // ADDIS X2, X5, 1
16'h00d3:  out = 32'b01010100000000000000000010000001; // B.NE 4
16'h00d4:  out = 32'b11010010100000000000000001000011; // MOVZ X3, 2
16'h00d5:  out = 32'b11110001000000000000100100100010; // SUBIS X2, X9, 2
16'h00d6:  out = 32'b01010100000000000000000000100000; // B.EQ 1 
16'h00d7:  out = 32'b10010001000000000000010001100011; // ADDI X3, X3, 1		// end of paddle check
16'h00d8:  out = 32'b11010011011000001111110001100100; // LSL X4, X3, 63		
16'h00d9:  out = 32'b11010011010000001111110010000100; // LSR X4, X4, 63
16'h00da:  out = 32'b11110001000000000000010010000010; // SUBIS X2, X4, 1
16'h00db:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h00dc:  out = 32'b11010011011000000000011000010000; // LSL X16, X16, 1		//left
16'h00dd:  out = 32'b11010011011000000000011101011010; // LSL X26, X26, 1		//end of left
16'h00de:  out = 32'b11110001000000000000000010000010; // SUBIS X2, X4, 0
16'h00df:  out = 32'b01010100000000000000000001000001; // B.NE 2	
16'h00e0:  out = 32'b11010011010000000000011000010000; // LSR X16, X16, 1		//right
16'h00e1:  out = 32'b11010011010000000000011101011010; // LSR X26, X26, 1		//end of right
16'h00e2:  out = 32'b11010011010000000000010001100100; // LSR X4, X3, 1
16'h00e3:  out = 32'b11110001000000000000100010000010; // SUBIS X2, X4, 2
16'h00e4:  out = 32'b01010100000000000000000100000001; // B.NE 8	
16'h00e5:  out = 32'b11010010100000000000000000001011; // MOVZ X11, 0
16'h00e6:  out = 32'b11010010100000000000000000001101; // MOVZ X13, 0
16'h00e7:  out = 32'b11010011011000001100001101001101; // LSL X13, X26, 48	//down
16'h00e8:  out = 32'b11010011011000001100001000001011; // LSL X11, X16, 48
16'h00e9:  out = 32'b11010011010000000100001000010000; // LSR X16, X16, 16
16'h00ea:  out = 32'b11010011010000000100001101011010; // LSR X26, X26, 16
16'h00eb:  out = 32'b10001011000011010000001000010000; // ADD X16, X16, X13
16'h00ec:  out = 32'b10001011000010110000001101011010; // ADD X26, X26, X11	//end of down
16'h00ed:  out = 32'b11110001000000000000010010000010; // SUBIS X2, X4, 1
16'h00ee:  out = 32'b01010100000000000000000100000001; // B.NE 8	
16'h00ef:  out = 32'b11010010100000000000000000010101; // MOVZ X21, 0
16'h00f0:  out = 32'b11010010100000000000000000010111; // MOVZ X23, 0
16'h00f1:  out = 32'b11010011010000001100001000010111; // LSR X23, X16, 48	//up
16'h00f2:  out = 32'b11010011010000001100001101010101; // LSR X21, X26, 48
16'h00f3:  out = 32'b11010011011000000100001000010000; // LSL X16, X16, 16
16'h00f4:  out = 32'b11010011011000000100001101011010; // LSL X26, X26, 16
16'h00f5:  out = 32'b10001011000101110000001101011010; // ADD X26, X26, X23
16'h00f6:  out = 32'b10001011000101010000001000010000; // ADD X16, X16, X21	//end of up
16'h00f7:  out = 32'b11010011010000001100001000000010; // LSR X2, X16, 48		//check top and bottom wall
16'h00f8:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1		
16'h00f9:  out = 32'b01010100000000000000000000100100; // B.MI 1
16'h00fa:  out = 32'b10010001000000000000100001100011; // ADDI X3, X3, 2
16'h00fb:  out = 32'b11010011011000001100001101000010; // LSL X2, X26, 48
16'h00fc:  out = 32'b11010011010000001100000001000010; // LSR X2, X2, 48
16'h00fd:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h00fe:  out = 32'b01010100000000000000000000100100; // B.MI 1
16'h00ff:  out = 32'b11010001000000000000100001100011; // SUBI X3, X3, 2
16'h0100:  out = 32'b11010011011000001111111000000010; // LSL X2, X16, 63		//checking ball score on player1 side
16'h0101:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0102:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0103:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0104:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h0105:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0106:  out = 32'b11010011011000001011111000000010; // LSL X2, X16, 47
16'h0107:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0108:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0109:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h010a:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h010b:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h010c:  out = 32'b11010011011000000111111000000010; // LSL X2, X16, 31
16'h010d:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h010e:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h010f:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0110:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h0111:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0112:  out = 32'b11010011011000000011111000000010; // LSL X2, X16, 15
16'h0113:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0114:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0115:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0116:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h0117:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0118:  out = 32'b11010011011000001111101101000010; // LSL X2, X26, 62
16'h0119:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h011a:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h011b:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h011c:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h011d:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h011e:  out = 32'b11010011011000001011111101000010; // LSL X2, X26, 47
16'h011f:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0120:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0121:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0122:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h0123:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0124:  out = 32'b11010011011000000111111101000010; // LSL X2, X26, 31
16'h0125:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0126:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0127:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0128:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h0129:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h012a:  out = 32'b11010011011000000011111101000010; // LSL X2, X26, 15
16'h012b:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h012c:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h012d:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h012e:  out = 32'b10010001000000000000011001010010; // ADDI X18, X18, 1
16'h012f:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0130:  out = 32'b11010011011000001100001000000010; // LSL X2, X16, 48		//checking ball score on player2 side
16'h0131:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0132:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0133:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0134:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h0135:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0136:  out = 32'b11010011011000001000001000000010; // LSL X2, X16, 32
16'h0137:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0138:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0139:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h013a:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h013b:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h013c:  out = 32'b11010011011000000100001000000010; // LSL X2, X16, 16
16'h013d:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h013e:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h013f:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0140:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h0141:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0142:  out = 32'b11010011011000000000001000000010; // LSL X2, X16, 0
16'h0143:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0144:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0145:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0146:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h0147:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0148:  out = 32'b11010011011000001100001101000010; // LSL X2, X26, 48
16'h0149:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h014a:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h014b:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h014c:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h014d:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h014e:  out = 32'b11010011011000001000001101000010; // LSL X2, X26, 32
16'h014f:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0150:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0151:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0152:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h0153:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0154:  out = 32'b11010011011000000100001101000010; // LSL X2, X26, 16
16'h0155:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0156:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h0157:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h0158:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h0159:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h015a:  out = 32'b11010011011000000000001101000010; // LSL X2, X26, 0
16'h015b:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h015c:  out = 32'b11110001000000000000010001000010; // SUBIS X2, X2, 1
16'h015d:  out = 32'b01010100000000000000000001000001; // B.NE 2
16'h015e:  out = 32'b10010001000000000000011001110011; // ADDI X19, X19, 1
16'h015f:  out = 32'b11010110000000000000001111100000; // BR XZR
16'h0160:  out = 32'b11111000000000000100000000111111; // STUR XZR, [X1, 4]
16'h0161:  out = 32'b11111000010000000100000000111101; // LDUR X29, [X1, 4]
16'h0162:  out = 32'b11111000000000000100000000111101; // STUR X29, [X1, 4]
16'h0163:  out = 32'b11010011011000001010001110100010; // LSL X2, X29, 40
16'h0164:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0165:  out = 32'b11110001000000000000000001000101; // SUBIS X5, X2, 0
16'h0166:  out = 32'b01010100111111111111111101000001; // B.NE -6
16'h0167:  out = 32'b11010010100000000000000000000010; // MOVZ X2, 0
16'h0168:  out = 32'b11111000000000000100000000111111; // STUR XZR, [X1, 4]
16'h0169:  out = 32'b11111000010000000100000000111101; // LDUR X29, [X1, 4]
16'h016a:  out = 32'b11111000000000000100000000111101; // STUR X29, [X1, 4]
16'h016b:  out = 32'b11010011011000001010001110100010; // LSL X2, X29, 40
16'h016c:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h016d:  out = 32'b11110001000000000000000001000101; // SUBIS X5, X2, 0
16'h016e:  out = 32'b01010100111111111111111101000000; // B.EQ -6
16'h016f:  out = 32'b11111000000000000100000000111111; // STUR XZR, [X1, 4]
16'h0170:  out = 32'b11111000010000000100000000111101; // LDUR X29, [X1, 4]
16'h0171:  out = 32'b11111000000000000100000000111101; // STUR X29, [X1, 4]
16'h0172:  out = 32'b11010011011000001010001110100010; // LSL X2, X29, 40
16'h0173:  out = 32'b11010011010000001111110001000010; // LSR X2, X2, 63
16'h0174:  out = 32'b11110001000000000000000001000101; // SUBIS X5, X2, 0
16'h0175:  out = 32'b01010100111111111111111101000001; // B.NE -6
16'h0176:  out = 32'b01010100111111111101001110100000; // B.EQ -355
default: out=32'hD60003E0; //BR XZR
endcase
end
endmodule
