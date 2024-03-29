## Brian Barbu (brb9da)

##jXX, mrmovq in single-cyle processor

########## the PC and condition codes registers #############
register xF { 
	pc:64 = 0; 
}

register cC {
	SF:1 = 0;
	ZF:1 = 1;
}



########## Fetch #############
pc = F_pc;

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
	icode in { JXX,CALL } : i10bytes[8..72];
	1 : 	i10bytes[16..80];
];


wire offset:64;
wire valP:64;
offset = [
	icode in { HALT, NOP, RET } : 1;
	icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	icode in { JXX, CALL } : 9;
	1 : 	10;

];

valP = F_pc +  offset;


########## Decode #############

reg_srcA = [
	icode in {RRMOVQ, RMMOVQ, OPQ, PUSHQ} : rA;
	icode == POPQ : REG_RSP;
	icode == RET : REG_RSP;
	1 : 	REG_NONE;
];

reg_srcB = [
	icode in {OPQ, RMMOVQ, MRMOVQ} : rB;
	icode == CALL : REG_RSP;
	icode == PUSHQ : REG_RSP;
	icode == POPQ : REG_RSP;
	icode == RET : REG_RSP;
	1 : 	REG_NONE;
];



########## Execute #############


wire conditionsMet:1;

conditionsMet = [
	ifun == ALWAYS : true;
	ifun == LE : C_SF || C_ZF;
	ifun == EQ : C_ZF;
	ifun == LT : C_SF;
	ifun == GE : !C_SF;
	ifun == NE : !C_ZF;
	ifun == GT : !C_SF && !C_ZF;
	1 :	 false;
];

wire valE:64;
valE = [
	icode == OPQ && ifun == ADDQ : reg_outputA + reg_outputB;
	icode == OPQ && ifun == SUBQ : reg_outputB - reg_outputA;
	icode == OPQ && ifun == XORQ : reg_outputA ^ reg_outputB;
	icode == OPQ && ifun == ANDQ : reg_outputA & reg_outputB;
	icode in { RMMOVQ, MRMOVQ} : valC + reg_outputB;
	icode == CALL : reg_outputB - 0x8;
	icode == PUSHQ : reg_outputB - 0x8;
	icode == POPQ : reg_outputB + 0x8;
	icode == RET : reg_outputB + 0x8;
	1 : 	0;
];



### condition codes
c_ZF = (valE == 0);
c_SF = (valE >= 0x8000000000000000);
stall_C = (icode != OPQ);



########## Memory #############

mem_readbit = [
	icode in { MRMOVQ, POPQ, RET} : 1;
	1 : 	0;
];

mem_writebit = [
	icode in { RMMOVQ, PUSHQ, CALL } : 1;
	1 : 	0;
];

mem_addr = [
	icode in {POPQ, RET} : reg_outputB;
	1: 	valE;
];

mem_input = [
	icode == CALL : valP;
	1 : 	reg_outputA;
];

 



########## Writeback #############

reg_dstE = [
	icode == MRMOVQ : rA;
	icode == RRMOVQ && conditionsMet : rB;
	icode in { PUSHQ , POPQ , RET, CALL }: REG_RSP;
	icode in {IRMOVQ, OPQ} : rB;
	1 : 	REG_NONE;
];


reg_inputE = [
	icode == RRMOVQ : reg_outputA;
	icode == MRMOVQ : mem_output;	
	icode == CALL : valE;
	icode == OPQ : valE;
	icode == PUSHQ : valE;
	icode == POPQ : valE;
	icode == RET : valE;
	icode in {IRMOVQ} : valC;
	1 : 	0xbadbadbadbad;
];

reg_dstM = [
	icode == POPQ : rA;
	1 : 	REG_NONE;
];

reg_inputM = [
	icode == POPQ : mem_output;
	1 : 	0xbadbadbadbad;
];

Stat = [
	icode == HALT : STAT_HLT;
	icode > 0xb : STAT_INS;
	1 : 	STAT_AOK;
];




########## PC Update #############

x_pc = [
	(icode == JXX) && conditionsMet : valC;
	icode == CALL : valC;
	icode == RET : mem_output;
	1 : 	valP;
];

