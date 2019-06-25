#Brian Barbu (brb9da)

#nop, halt, irmovq, rrmovq, unconditional jmp n single-cycle processor

register pP{
	pc:64 = 0;
}
pc = P_pc;

wire opcode:8;
wire icode:4;
wire rb:4;
wire valC: 64;
wire rA:4;
opcode =  i10bytes[0..8];
icode = opcode[4..8];
rB = i10bytes[8..12];
rA = i10bytes[12..16];
valC = [
	icode == JXX: i10bytes[8..72];
	1	: i10bytes[16..80];
	];
reg_inputE = [
	icode == IRMOVQ: valC;
	icode == RRMOVQ: reg_outputA;
	1	: 0xF;
	];
reg_dstE = [
	icode == IRMOVQ : rB;
	icode == RRMOVQ : rB;
	1	: REG_NONE;
	];
reg_srcA = [
	icode == RRMOVQ : rA;
	1	: REG_NONE;
	];
Stat = [
	icode == HALT	:STAT_HLT;
	icode == JXX	:STAT_AOK;
	icode == CALL	:STAT_AOK;
	icode == RET	:STAT_AOK;
	icode > 11	:STAT_INS;
	icode == NOP	:STAT_AOK;
	ICODE==IRMOVQ :STAT_AOK;
	icode ==RRMOVQ :STAT_AOK;
	1		:STAT_AOK;
];

