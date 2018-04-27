module ProcessorDE0(
	LEDG,
	SW,
	BUTTON,
	PS2_KBCLK, PS2_KBDAT,
	UART_RXD, UART_TXD, UART_RTS, UART_CTS,
	SD_CLK, SD_CMD, SD_DAT0, SD_DAT3, SD_WP_N,
	VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS,
	CLOCK_50, CLOCK_50_2,
	DRAM_CAS_N, DRAM_CS_N, DRAM_CLK, DRAM_CKE, DRAM_BA_0, DRAM_BA_1, DRAM_DQ, DRAM_LDQM, DRAM_UDQM, DRAM_RAS_N, DRAM_WE_N, DRAM_ADDR,
	HEX0, HEX1, HEX2, HEX3, GPIO1_D, GPIO0_D);
	// OUTPUT
	// LED
	output [9:0] LEDG;
	// UART (RS-232)
	output UART_TXD, UART_CTS;
	// SD Card
	output SD_CLK;
	// VGA
	output [3:0] VGA_R, VGA_G, VGA_B;
	output VGA_HS, VGA_VS;
	// SDRAM
	output DRAM_CAS_N, DRAM_CS_N, DRAM_CLK, DRAM_CKE, DRAM_BA_0, DRAM_BA_1, DRAM_LDQM, DRAM_UDQM, DRAM_RAS_N, DRAM_WE_N;
	output [12:0] DRAM_ADDR;
	// 7-segment
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	// GPIO Extension Board
	output [31:0]GPIO0_D;
	
	// INPUT
	// Switches
	input [9:0] SW;
	// Buttons
	input [2:0] BUTTON;
	// UART (RS-232)
	input UART_RXD, UART_RTS;
	// SD Card
	input SD_WP_N;
	// Clocks
	input CLOCK_50, CLOCK_50_2;
	// GPIO Extension Board
	input [31:0]GPIO1_D;
	// PS/2 Keyboard
	input PS2_KBCLK, PS2_KBDAT;
	
	// INOUT
	// SD Card
	inout SD_CMD, SD_DAT0, SD_DAT3;
	// SDRAM
	inout [15:0]DRAM_DQ;
	
	// WIRE
	wire [63:0] data, address;
	wire read, write;
	
	// Processor
	wire clock25;
	GPUVGAClock tempSlowClock(CLOCK_50, clock25);
	Processor proc(~BUTTON[0], clock25, data, address, read, write);
	assign LEDG[9:0] = data[9:0];
	// Peripherals
	// GPU
	GPU gpu(clock25, CLOCK_50, {VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS}, data, address, read, write);
	// SD Card
	SD_Card sd(SD_CLK, SD_CMD, {SD_DAT3, SD_DAT0}, SD_WP_N);
	// Keyboard
	ConverterV3 keyboardConverter(address, read, CLOCK_50, PS2_KBCLK, PS2_KBDAT, data);
	// Extension Board
	GPIO extension(clock25, data, address, read, write, GPIO0_D);
endmodule
