module ProgramCounter(PC, PC4, );
	00: PC = PC;
	01: PC = PC + 4;
	10: PC = PC + 4 + PC;
	11: PC = PC + 4 + PC*4;