module RegFile32x64(A, B, D, DA, SA, SB, W, reset, clock);
	output [63:0]A, B; //output buses
	input [63:0]D; // data input
	input [4:0]DA; // dara address
	input [4:0]SA; // select for A buses
	input [4:0]SB; // select for B buses
	input W; // write enable
	input reset; // async
	input clock; // posedge
	
	wire [63:0] R00, R01, R02, R03, R04, R05, R06, R07, R08, R09, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31, R32, R33, R34, R35, R36, R37, R38, R39, R40, R41, R42, R43, R44, R45, R46, R47, R48, R49, R50, R51, R52, R53, R54, R55, R56, R57, R58, R59, R60, R61, R62, R63;
	
	wire {31:0}L;
	
	RegisterNbit reg0  (R00, D, L[0] , reset, clock);
	RegisterNbit reg1  (R00, D, L[1] , reset, clock);
	RegisterNbit reg2  (R00, D, L[2] , reset, clock);
	RegisterNbit reg3  (R00, D, L[3] , reset, clock);
	RegisterNbit reg4  (R00, D, L[4] , reset, clock);
	RegisterNbit reg5  (R00, D, L[5] , reset, clock);
	RegisterNbit reg6  (R00, D, L[6] , reset, clock);
	RegisterNbit reg7  (R00, D, L[7] , reset, clock);
	RegisterNbit reg8  (R00, D, L[8] , reset, clock);
	RegisterNbit reg9  (R00, D, L[9] , reset, clock);
	RegisterNbit reg10 (R00, D, L[10], reset, clock);
	RegisterNbit reg11 (R00, D, L[11], reset, clock);
	RegisterNbit reg12 (R00, D, L[12], reset, clock);
	RegisterNbit reg13 (R00, D, L[13], reset, clock);
	RegisterNbit reg14 (R00, D, L[14], reset, clock);
	RegisterNbit reg15 (R00, D, L[15], reset, clock);
	RegisterNbit reg16 (R00, D, L[16], reset, clock);
	RegisterNbit reg17 (R00, D, L[17], reset, clock);
	RegisterNbit reg18 (R00, D, L[18], reset, clock);
	RegisterNbit reg19 (R00, D, L[19], reset, clock);
	RegisterNbit reg20 (R00, D, L[20], reset, clock);
	RegisterNbit reg21 (R00, D, L[21], reset, clock);
	RegisterNbit reg22 (R00, D, L[22], reset, clock);
	RegisterNbit reg23 (R00, D, L[23], reset, clock);
	RegisterNbit reg24 (R00, D, L[24], reset, clock);
	RegisterNbit reg25 (R00, D, L[25], reset, clock);
	RegisterNbit reg26 (R00, D, L[26], reset, clock);
	RegisterNbit reg27 (R00, D, L[27], reset, clock);
	RegisterNbit reg28 (R00, D, L[28], reset, clock);
	RegisterNbit reg29 (R00, D, L[29], reset, clock);
	RegisterNbit reg30 (R00, D, L[30], reset, clock);
	assign R31 = 64'b0;
	
	wire [31:0]m;
	
	Decoder5to32 D_decoder(DA, m);
	
	assign L = m & {W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W};
	
	Mux32to1NbRt A_mux (A, SA, R00, R01, R02, R03, R04, R05, R06, R07, R08, R09, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31);
	Mux32to1NbRt B_mux (B, SB, R00, R01, R02, R03, R04, R05, R06, R07, R08, R09, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31);
	
	defparam A_mux.N = 64;
	defparam B_mux.N = 64;
	
endmodule
