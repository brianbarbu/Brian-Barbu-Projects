#Brian Barbu (brb9da)

#five stage pipelined y86 processor, forwarding for nop, halt, irmovq, rrmovq, OPq, and cmovXX

######### PC #############
register fF { 
	pc:64 = 0; 
}

#condition codes
register cC {
	SF:1 = 0;
	ZF:1 = 1;
}

########## Fetch #############
pc = F_pc;

f_icode = i10bytes[4..8];
f_ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

wire offset:64;
wire valP:64;


f_valC = [
	f_icode in { CALL, JXX } : i10bytes[8..72];
	1 : i10bytes[16..80];
];

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


stall_F = (f_stat != STAT_AOK || D_stat != STAT_AOK || E_stat != STAT_AOK || M_stat != STAT_AOK);



########## Decode #############
register fD {
	stat:3 = STAT_AOK;
	ifun:4 = 0;
	icode:4 = NOP;
	rA:4 = REG_NONE;
	rB:4 = REG_NONE;
	valC:64 = 0;

}

d_icode = D_icode;
d_ifun = D_ifun;
d_stat = D_stat;

reg_srcA = [
	D_icode in {RRMOVQ, RMMOVQ, OPQ, CMOVXX, POPQ, PUSHQ} : D_rA;
	1 : REG_NONE;
];
d_srcA = reg_srcA;

d_valA = [
	reg_srcA != REG_NONE && reg_srcA == E_dstE : e_valE;
	reg_srcA != REG_NONE && reg_srcA == M_dstE : M_valE;
	reg_srcA != REG_NONE && reg_srcA == W_dstE && D_icode == MRMOVQ : W_valM;
	reg_srcA != REG_NONE && reg_srcA == W_dstE : W_valE;
	reg_srcA != REG_NONE && reg_srcA == m_dstE && D_icode == MRMOVQ : m_valM;
	reg_srcA != REG_NONE && reg_srcA == m_dstE : m_valE;
	1 : reg_outputA;
];

reg_srcB = [
	D_icode in {RMMOVQ, MRMOVQ, OPQ, CMOVXX} : D_rB;
	1 : REG_NONE;
];
d_srcB = reg_srcB;

d_valB = [
	reg_srcB != REG_NONE && reg_srcB == E_dstE : e_valE;
	reg_srcB != REG_NONE && reg_srcB == M_dstE : M_valE;
	reg_srcB != REG_NONE && reg_srcB == W_dstE && D_icode == MRMOVQ : W_valM;
	reg_srcB != REG_NONE && reg_srcB == W_dstE : W_valE;
	reg_srcB != REG_NONE && reg_srcB == m_dstE && D_icode == MRMOVQ : m_valM;
	reg_srcB != REG_NONE && reg_srcB == m_dstE : m_valE;
	1 : reg_outputB;
];

d_dstE = [
	D_icode == MRMOVQ : D_rA;
	D_icode in {IRMOVQ, RRMOVQ, OPQ, CMOVXX} : D_rB;
	1 : REG_NONE;
];


d_valC = D_valC;


########## Execute #############

register dE {
	stat:3 = STAT_AOK;
	icode:4 = NOP;
	ifun:4 = 0;
	valA:64 = 0;
	valB:64 = 0;
	valC:64 = 0;
	srcA:4 = REG_NONE;
	srcB:4 = REG_NONE;
	dstE:4 = REG_NONE;
}

e_valE = [
	E_icode == OPQ && E_ifun == ADDQ : E_valA + E_valB;
	E_icode == OPQ && E_ifun == SUBQ : E_valB - E_valA;
	E_icode == OPQ && E_ifun == ANDQ : E_valA & E_valB;
	E_icode == OPQ && E_ifun == XORQ : E_valA ^ E_valB;
	E_icode == IRMOVQ : E_valC;
	E_icode in { MRMOVQ, RMMOVQ } : E_valC + E_valB;
	E_icode == RRMOVQ && E_ifun == 0 : E_valA;
	E_icode == CMOVXX && E_ifun != 0 : E_valB;
	1 : 0;
];
e_valA = E_valA;


wire conditionsMet:1;
conditionsMet = [
	E_ifun == ALWAYS : true;
	E_ifun == LE : C_SF || C_ZF;
	E_ifun == LT : C_SF;
	E_ifun == EQ : C_ZF;
	E_ifun == NE : !C_ZF;
	E_ifun == GE : !C_SF;
	E_ifun == GT : !C_SF && !C_ZF;
	1 : false;
];

c_ZF = (e_valE == 0);
c_SF = (e_valE >= 0x8000000000000000);
stall_C = (E_icode != OPQ);


e_dstE = [
	E_icode == CMOVXX && !conditionsMet : REG_NONE;
	E_icode == JXX && !conditionsMet : REG_NONE;
	1 : E_dstE;
];


e_Cnd = conditionsMet;
e_icode = E_icode;
e_ifun = E_ifun;
e_stat = E_stat;


########## Memory #############

register eM {
	stat:3 = STAT_AOK;
	icode:4 = NOP;
	ifun:4 = 0;
	Cnd:1 = 0;
	valE:64 = 0;
	valA:64 = 0;
	dstE:4 = REG_NONE;

}

m_icode = M_icode;
m_ifun = M_ifun;
m_stat = M_stat;

mem_readbit = M_icode in { MRMOVQ };
mem_writebit = M_icode in { RMMOVQ };

mem_addr = [
	M_icode in { MRMOVQ, RMMOVQ } : M_valE;
        1: 0xBADBADBAD;
];

mem_input = [
	M_icode in { RMMOVQ } : M_valA;
        1: 0;
];

m_valE = M_valE;
m_valM = mem_output;
m_Cnd = M_Cnd;
m_dstE = M_dstE;
m_valA = M_valA;


########## Writeback #############

register mW {
	stat:3 = STAT_AOK;
	icode:4 = NOP;
	ifun:4 = 0;
	valA:64 = 0;
	valM:64 = 0;
	valE:64 = 0;
	dstE:4 = REG_NONE;
	Cnd:1 = 0;
}

reg_dstE = [
	W_icode in {IRMOVQ, OPQ} : W_dstE;
	W_icode == MRMOVQ : W_dstE;
	W_icode == RRMOVQ && W_Cnd : W_dstE;
	1 : REG_NONE;
];

#e_valE = E_valC
reg_inputE = [
	W_icode in {IRMOVQ} : W_valE; 
	W_icode == MRMOVQ : W_valM;
	W_icode == RRMOVQ : W_valA;
	W_icode == OPQ : W_valE;
	1 : 0;
];

### PC and Stat ########

Stat = W_stat;

f_pc = valP;
