module ROM_Cycle_Screen(out, address);
  input[15:0] address;
  output reg[31:0] out;
  always @(address) begin
    case(address)
		// These are the addresses to load data into and read the status
      16'd0: out = 32'b11010010100000000000000001010100; // MOVZ X20, 2
      16'd1: out = 32'b11010011011000001110001010010100; // LSL X20, X20, 56
      16'd2: out = 32'b10010001000000000000101010010101; // ADDI X21, X20, 2
		// Initialize the counter
      16'd3: out = 32'b11010010100000000000000000000000; // MOVZ X0, 0
		// Wait for vsync to go high
      16'd4: out = 32'b11111000010000000000001010101010; // LDUR X10, [X21, 0]
      16'd5: out = 32'b10010010000000000000100101001010; // ANDI X10, X10, 2
      16'd6: out = 32'b10110100111111111111111110101010; // CBZ X10, -3
		// Wait for dispEnable to go high
      16'd7: out = 32'b11111000010000000000001010101010; // LDUR X10, [X21, 0]
      16'd8: out = 32'b10010010000000000000010101001010; // ANDI X10, X10, 1
      16'd9: out = 32'b10110100111111111111111110101010; // CBZ X10, -3
		// Load into the background text color
      16'd10: out = 32'b11010011011000000000110000000001; // LSL X1, X0, 3
      16'd11: out = 32'b11111000000000000000001010000001; // STUR X1, [X20, 0]
		// Increment the counter
      16'd12: out = 32'b10010001000000000000010000000000; // ADDI X0, X0, 1
      16'd13: out = 32'b00010111111111111111111111110110; // B -10
      default: out = 32'b11010110000000000000001111100000; // BR XZR
    endcase
  end
endmodule
