module ROM_GPIO_Timer(out, address);
output reg [31:0] out;
input  [15:0] address; // address- 16 deep memory  
always @(address) begin
case (address)
16'h0000:  out = 32'b11010010100000000000000010100001; // MOVZ X1, 5			// set registry to allocated memory
16'h0001:  out = 32'b11010011011000001110000000100001; // LSL X1, X1, 56
16'h0002:  out = 32'b11111000010000000100000000101010; // LDUR X10, [X1, 4]
16'h0003:  out = 32'b11111000000000000011000000101010; // STUR X10, [X1, 3]
16'h0004:  out = 32'b11010110000000000000001111100000; // BR XZR
default: out=32'hD60003E0; //BR XZR
endcase
end
endmodule
