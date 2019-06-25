### Brian Barbu (brb9da)

#two pipe-line stage using forwarding 
#stage 1 fetch and decode
#stage 2 writeback

########## the PC and condition codes registers #############
register fF { pc:64 = 0; rA:4 = 0; rB:4 = 0;}


########## Fetch #############
pc = F_pc;


f_icode = i10bytes[4..8];
f_ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

f_valC = [
	f_icode in { JXX } : i10bytes[8..72];
	1 : i10bytes[16..80];
];

wire offset:64, valP:64;
offset = [
	f_icode in { HALT, NOP, RET } : 1;
	f_icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	f_icode in { JXX, CALL } : 9;
	1 : 10;
];
f_stat = [
	f_icode == HALT : STAT_HLT;
	f_icode > 0xb : STAT_INS;
	1 : STAT_AOK;
];

valP = F_pc + offset;

stall_F = (f_stat != STAT_AOK || W_stat != STAT_AOK);
########## Decode #############

# source selection
reg_srcA = [
	f_icode in {RRMOVQ} : f_rA;
	1 : REG_NONE;
];
f_srcA = reg_srcA;

reg_srcB = [
	f_icode in {RRMOVQ} : f_rB;
	1 : REG_NONE;
];
f_srcB = reg_srcB;

f_dstE = [
	f_icode in {IRMOVQ, RRMOVQ} : f_rB;
	1 : REG_NONE;
];
f_valA = [
	reg_srcA != REG_NONE && reg_srcA == W_dstE : W_valE;
	1: reg_outputA;
];
f_valE = [
	f_icode == IRMOVQ : f_valC;
	f_icode == RRMOVQ && f_ifun == 0 : f_valA;
	1:	0;
];

########## Execute #############



########## Memory #############




########## Writeback #############
register fW {
	stat:3 = STAT_AOK;
	icode:4 = NOP;
	ifun:4 = 0;
	valC:64 = 0;
	srcA:4 = REG_NONE;
	srcB:4 = REG_NONE;
	dstE:4 = REG_NONE;
	valA:64 = 0;
	valE:64 = 0;
}

# destination selection
reg_dstE = [
	W_icode in {IRMOVQ, RRMOVQ}: W_dstE;
	1	: REG_NONE;
];
reg_inputE = [ # unlike book, we handle the "forwarding" actions (something + 0) here
	W_icode == RRMOVQ : W_valA;
	W_icode in {IRMOVQ} : W_valE;
        1: 0xBADBADBAD;
];


########## PC and Status updates #############

Stat = W_stat;

f_pc = valP;

