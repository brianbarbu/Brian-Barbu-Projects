# -*-sh-*- 
# Brian Barbu (brb9da)
##five stage y86 pipelined processor forwarding and branch prediction for nop, halt, irmovq, rrmovq, OPq, cmovXX, rmmovq, mrmovq, JXX

######### PC #############
register fF { pc:64 = 0; }


########## Fetch #############
pc = [	
	M_icode in {JXX, CALL} && !M_cnD : M_valP;
	W_icode == RET : W_valM;
	1:  F_pc;
];

wire icode:4;
wire ifun:4;
wire rA:4; 
wire rB:4; 
wire valC:64;

icode = i10bytes[4..8];
ifun = i10bytes[0..4];
rA = i10bytes[12..16];
rB = i10bytes[8..12];

valC = [
	icode in { JXX, CALL } : i10bytes[8..72];
	1 : i10bytes[16..80];
];

wire offset:64;
offset = [
	icode in { HALT, NOP, RET } : 1;
	icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	icode in { JXX, CALL } : 9;
	1 : 10;
];
wire valP:64;
valP = pc + offset;


f_pc = [
	f_stat != STAT_AOK : pc;
	icode in {JXX,CALL} : f_valC;
	1 : f_valP;
];

f_stat = [
	f_icode == HALT : STAT_HLT;
	f_icode > 0xb : STAT_INS;
	1 : STAT_AOK;
];


f_icode = icode;
f_ifun = ifun;

f_rA = rA;
f_rB = rB;

f_valC = valC;
f_valP = valP;




########## Decode #############

register fD {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	ifun:4 = NOP;
	rA:4 = NOP;
	rB:4 = NOP;
	valC:64 = 0;
	valP:64 = 0;
}



reg_srcA = [ 
	D_icode in {CMOVXX, RRMOVQ, RMMOVQ, OPQ, PUSHQ, CALL} : D_rA;
	D_icode == RET : REG_RSP;
	1 : REG_NONE;
];
reg_srcB = [
	D_icode in {RMMOVQ, MRMOVQ, IRMOVQ, OPQ} : D_rB;
	D_icode in {PUSHQ, POPQ, CALL, RET}  : REG_RSP;
	1 : REG_NONE;
];


d_valA = [
	reg_srcA == REG_NONE: 0;
	D_icode in { JXX, CALL} : D_valP;
	reg_srcA == e_dstE : e_valE;
	reg_srcA == m_dstE : m_valE;
	reg_srcA == m_dstM : m_valM; 
	reg_srcA == W_dstE : W_valE;
	reg_srcA == W_dstM : W_valM; 
	1 : reg_outputA;
];

d_valB = [
	reg_srcB == REG_NONE: 0;
	reg_srcB == e_dstE : e_valE;
	reg_srcB == m_dstM : m_valM; 
	reg_srcB == W_dstM : W_valM; 
	reg_srcB == m_dstE : m_valE;
	reg_srcB == W_dstE : W_valE;
	1 : reg_outputB; 
];


d_dstM = [
	D_icode in { MRMOVQ, POPQ} : D_rA;
	1 : REG_NONE;
];

d_dstE = [
	D_icode in {CMOVXX, IRMOVQ, RRMOVQ, OPQ} : D_rB;
	D_icode in {PUSHQ, POPQ, CALL, RET}: REG_RSP;
	1 : REG_NONE;

];



d_stat = D_stat;
d_icode = D_icode;
d_ifun = D_ifun;

d_valC = D_valC;
d_valP = D_valP;

########## Execute #############

register dE {
	stat:3  = STAT_BUB;
	icode:4 = NOP;
	ifun:4  = NOP;
	valC:64 = 0;
	valA:64 = 0;
	valB:64 = 0;
	valP:64 = 0;
	dstE:4 = REG_NONE;
	dstM:4 = REG_NONE;	
}


register cC {
	SF:1 = 0;
	ZF:1 = 1;
}


e_cnD = [
	E_ifun == ALWAYS : true;
	E_ifun == LE : C_SF || C_ZF;
	E_ifun == LT : C_SF;
	E_ifun == EQ : C_ZF;
	E_ifun == NE : !C_ZF;
	E_ifun == GE : !C_SF;
	E_ifun == GT : !C_SF && !C_ZF;
	1 : false;
];


## condition codes
c_ZF = e_valE == 0;
c_SF = e_valE >= 0x8000000000000000;
stall_C = (E_icode != OPQ);

e_valE = [
	E_icode == OPQ && E_ifun == ADDQ : E_valB + E_valA;
	E_icode == OPQ && E_ifun == SUBQ : E_valB - E_valA;
	E_icode == OPQ && E_ifun == ANDQ : E_valB & E_valA;
	E_icode == OPQ && E_ifun == XORQ : E_valB ^ E_valA;
	E_icode == RRMOVQ :E_valA;
	E_icode == IRMOVQ :E_valC;
	E_icode in {RMMOVQ, MRMOVQ} : E_valC + E_valB;
	E_icode in {RET, POPQ} : E_valB + 8;
	E_icode in {CALL, PUSHQ}: E_valB - 8;
	1:0;
];

e_dstE = [
	E_icode == CMOVXX && !e_cnD : REG_NONE;
	1 : E_dstE;
];
	

e_stat =  E_stat;
e_icode = E_icode;

e_valA = E_valA;
e_valB = E_valB;
e_valP = E_valP;

e_dstM = E_dstM;


########## Memory #############

register eM {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	cnD:1   = true;
	valE:64 = 0;
	valA:64 = 0;
	valB:64 = 0;
	valP:64 = 0;
	dstE:4 = REG_NONE;
	dstM:4 = REG_NONE;
}




mem_addr = [ 
	M_icode in { RMMOVQ, MRMOVQ, PUSHQ, CALL } : M_valE;
	M_icode in { POPQ, RET } : M_valE - 8;
	1 : 0; 
];

mem_readbit =  M_icode in { MRMOVQ, POPQ, RET }; 
mem_writebit = M_icode in { RMMOVQ, PUSHQ, CALL }; 

mem_input = [
	m_icode == CALL : M_valP;
	1 : M_valA;
];

m_valM = mem_output;

m_stat = M_stat;
m_icode = M_icode;
m_valE = M_valE;
m_valP = M_valP;
m_valA = M_valA;
m_dstE = M_dstE;
m_dstM = M_dstM;




########## Writeback #############
register mW {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	valP:64 = 0;
	valM:64 = 0;
	valE:64 = 0;
	valA:64 = 0;
	dstE:4 = REG_NONE;
	dstM:4 = REG_NONE;
}

Stat = W_stat; 

reg_dstM = W_dstM;
reg_dstE = W_dstE;
reg_inputM = W_valM;
reg_inputE = W_valE;




##### Register ####################

wire loadUse:1;
wire retHazard:1;

retHazard = RET in {D_icode, E_icode, M_icode};
loadUse = ((E_icode in {MRMOVQ, POPQ}) && (E_dstM in {reg_srcA, reg_srcB})); 


stall_F = loadUse || retHazard;

stall_D = loadUse;
bubble_D = (E_icode in {JXX} && !e_cnD) || (!loadUse && retHazard);

bubble_E = loadUse || (E_icode in {JXX} && !e_cnD);


