#Brian Barbu (brb9da)

##five stage  pipelined y86 processor forwarding and stalling for rmmovq, mrmovq, halt

# -*-sh-*-

######### The PC #############
register fF { pc:64 = 0; }


########## Fetch #############
pc = F_pc;

wire ifun:4;
wire offset:64;
wire valP:64;

f_Stat = [
    f_icode == HALT :   STAT_HLT;
    f_icode > 0xb   :   STAT_INS;
    1   :   STAT_AOK;
];

f_icode = i10bytes[4..8];
ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

f_valC = [
	f_icode in { JXX } : i10bytes[8..72];
	1 : i10bytes[16..80];
];


offset = [
	f_icode in { HALT, NOP, RET } : 1;
	f_icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	f_icode in { JXX, CALL } : 9;
	1 : 10;
];

valP = F_pc + offset;

########## Decode #############

register fD {
    icode   :   4 = NOP;
    rA  :   4   = REG_NONE;
    rB  :   4   = REG_NONE;
    Stat    :   3   = STAT_AOK;
    valC    :   64  =   0;
}
    
d_icode = D_icode;
d_Stat = D_Stat;
d_valC = D_valC;

reg_srcA = [
	D_icode in {RMMOVQ} : D_rA;
	1 : REG_NONE;
];

reg_srcB = [
	D_icode in {RMMOVQ, MRMOVQ} : D_rB;
	1 : REG_NONE;
];


d_dstM  =   [
    D_icode in { MRMOVQ }   :   D_rA;
    1   :   REG_NONE;
    ];

d_valA  =   [
    reg_srcA == REG_NONE    :   0;
    reg_srcA == m_dstM  :   m_valM;
    reg_srcA == W_dstM  :   W_valM;
    1   :   reg_outputA;
];

d_valB  =   [
    reg_srcB == REG_NONE    :   0;
    reg_srcB == m_dstM  :   m_valM;
    reg_srcB == W_dstM  :   W_valM;
    1   :   reg_outputB;
];

########## Execute #############

register dE {
    icode   :   4 = NOP;
    Stat    :   3   = STAT_AOK;
    dstM    :   4 = REG_NONE;
    valA    :   64  =   0;
    valB    :   64  =   0;
    valC    :   64  =   0;
}

e_icode = E_icode;
e_Stat = E_Stat;
e_dstM = E_dstM;
e_valA = E_valA;
e_valB = E_valB;

wire operand1:64;
wire operand2:64;

operand1 = [
	E_icode in { MRMOVQ, RMMOVQ } : E_valC;
	1: 0;
];

operand2 = [
	E_icode in { MRMOVQ, RMMOVQ } : E_valB;
	1: 0;
];


e_valE = [
	E_icode in { MRMOVQ, RMMOVQ } : operand1 + operand2;
	1 : 0;
];


########## Memory #############

register eM {
    icode   :   4 = NOP;
    Stat    :   3   = STAT_AOK;
    valA    :   64  =   0;
    valB    :   64  =   0;
    valE    :   64  =   0;
    dstM    :   4 = REG_NONE;
}

m_icode = M_icode;
m_Stat = M_Stat;
m_dstM = M_dstM;
m_valA = M_valA;
m_valB = M_valB;

mem_readbit = M_icode in { MRMOVQ };
mem_writebit = M_icode in { RMMOVQ };

mem_addr = [
	M_icode in { MRMOVQ, RMMOVQ } : M_valE;
        1: 0xBADBADBAD;
];

mem_input = [
	M_icode in { RMMOVQ } : M_valA;
        1: 0xBADBADBAD;
];

m_valM = mem_output;

########## Writeback #############

register mW {
    icode   :   4 = NOP;
    Stat    :   3   = STAT_AOK;
    valA    :   64  =   0;
    valB    :   64  =   0;
    valM    :   64  =   0;
    dstM    :   4 = REG_NONE;
}
    
reg_dstM = W_dstM;


reg_inputM = [
	W_icode in {MRMOVQ} : W_valM;
        1: 0xBADBADBAD;
];

Stat = W_Stat;
f_pc = valP;



###### Stalling Load Use Hazard Conditions #######

wire loadUse    :   1;

loadUse = [
    E_icode == MRMOVQ && e_dstM == reg_srcA :   1;
    E_icode == MRMOVQ && e_dstM == reg_srcB :   1;
    1   :   0;
];

stall_F = (loadUse ||  (f_Stat  != STAT_AOK));

stall_D = loadUse;
bubble_E = loadUse;
