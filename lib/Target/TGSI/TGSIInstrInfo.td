//===- TGSIInstrInfo.td - Target Description for TGSI Target ------------===//
// 
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
// 
//===----------------------------------------------------------------------===//
//
// This file describes the TGSI instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction format superclass
//===----------------------------------------------------------------------===//

include "TGSIInstrFormats.td"

//===----------------------------------------------------------------------===//
// Instruction Pattern Stuff
//===----------------------------------------------------------------------===//


def load_input : SDNode<"TGSIISD::LOAD_INPUT",
                  SDTypeProfile<1, 1, [SDTCisVT<1, i32>]>,
                  [SDNPHasChain]>;

def call : SDNode<"TGSIISD::CALL",
                  SDTypeProfile<0, -1, [SDTCisVT<0, i32>]>,
                  [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue,
                   SDNPVariadic]>;

def ret : SDNode<"TGSIISD::RET", SDTNone,
                 [SDNPHasChain, SDNPOptInGlue]>;

class pat_ptr<string space> : ComplexPattern<i32, 1,
                              !strconcat("SelectPtr<tgsi::",
					 !strconcat(space, ">")),
                              [imm], [SDNPWantParent]>;

def private_ptr : pat_ptr<"PRIVATE">;
def global_ptr : pat_ptr<"GLOBAL">;
def local_ptr : pat_ptr<"LOCAL">;
def const_ptr : pat_ptr<"CONSTANT">;
def input_ptr : pat_ptr<"INPUT">;

def i32_imm : ComplexPattern<i32, 1, "SelectSrc<false>",
    	      	             [imm, globaladdr, tglobaladdr], []>;
def vi32_imm : ComplexPattern<v4i32, 1, "SelectSrc<false>", [imm], []>;
def f32_imm : ComplexPattern<f32, 1, "SelectSrc<false>", [fpimm], []>;
def vf32_imm : ComplexPattern<v4f32, 1, "SelectSrc<false>", [fpimm], []>;

def i32_src : ComplexPattern<i32, 1, "SelectSrc<true>",
                             [imm, globaladdr, tglobaladdr], []>;
def vi32_src : ComplexPattern<v4i32, 1, "SelectSrc<true>", [imm], []>;
def f32_src : ComplexPattern<f32, 1, "SelectSrc<true>", [fpimm], []>;
def vf32_src : ComplexPattern<v4f32, 1, "SelectSrc<true>", [fpimm], []>;

def brtarget : Operand<OtherVT>;
def calltarget : Operand<iPTR>;

//===----------------------------------------------------------------------===//
// Instruction multiclass Templates
//===----------------------------------------------------------------------===//

multiclass tgsi1p_i32_class<bits<8> instr, PatFrag op, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
              !strconcat(asmstr, " $d, $a"),
	      [(set IRegs:$d, (op i32_src:$a))]>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins IVRegs:$a),
              !strconcat(asmstr, " $d, $a"),
	      [(set IVRegs:$d, (op vi32_src:$a))]>;
}

multiclass tgsi1np_i32_class<bits<8> instr, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
              !strconcat(asmstr, " $d, $a"), []>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins IVRegs:$a),
              !strconcat(asmstr, " $d, $a"), []>;
}

multiclass tgsi2_i32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a, IRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set IRegs:$d, (op i32_src:$a, i32_src:$b))]>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins IVRegs:$a, IVRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set IVRegs:$d, (op vi32_src:$a, vi32_src:$b))]>;
}

multiclass tgsi2p_i32_class<bits<8> instr, PatFrag op, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a, IRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set IRegs:$d, (op i32_src:$a, i32_src:$b))]>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins IVRegs:$a, IVRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set IVRegs:$d, (op vi32_src:$a, vi32_src:$b))]>;
}

multiclass tgsi3_i32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a, IRegs:$b, IRegs:$c),
         !strconcat(asmstr, " $d, $a, $b, $c"),
         [(set IRegs:$d, (op i32_src:$a, i32_src:$b, i32_src:$c))]>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins IVRegs:$a, IVRegs:$b, IVRegs:$c),
         !strconcat(asmstr, " $d, $a, $b, $c"),
         [(set IVRegs:$d, (op vi32_src:$a, vi32_src:$b, vi32_src:$c))]>;
}

multiclass tgsi1_f321n_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a),
          !strconcat(asmstr, " $d, -$a"),
          [(set FRegs:$d, (op f32_src:$a))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins FVRegs:$a),
          !strconcat(asmstr, " $d, -$a"),
          [(set FVRegs:$d, (op vf32_src:$a))]>;
}

multiclass tgsi1_f32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set FRegs:$d, (op f32_src:$a))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins FVRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set FVRegs:$d, (op vf32_src:$a))]>;
}

class tgsi1_sf32_class<bits<8> instr, SDNode op, string asmstr> :
   tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set FRegs:$d, (op f32_src:$a))]>;

multiclass tgsi1np_f32_class<bits<8> instr, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a),
          !strconcat(asmstr, " $d, $a"), []>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins FVRegs:$a),
          !strconcat(asmstr, " $d, $a"), []>;
}

multiclass tgsi2_f321n_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a, FRegs:$b),
         !strconcat(asmstr, " $d, $a, -$b"),
         [(set FRegs:$d, (op f32_src:$a, f32_src:$b))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins FVRegs:$a, FVRegs:$b),
         !strconcat(asmstr, " $d, $a, -$b"),
         [(set FVRegs:$d, (op vf32_src:$a, vf32_src:$b))]>;
}

multiclass tgsi2_f32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a, FRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set FRegs:$d, (op f32_src:$a, f32_src:$b))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins FVRegs:$a, FVRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set FVRegs:$d, (op vf32_src:$a, vf32_src:$b))]>;
}

multiclass tgsi2p_iff32_class<bits<8> instr, PatFrag op, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins FRegs:$a, FRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set IRegs:$d, (op f32_src:$a, f32_src:$b))]>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins FVRegs:$a, FVRegs:$b),
         !strconcat(asmstr, " $d, $a, $b"),
         [(set IVRegs:$d, (op vf32_src:$a, vf32_src:$b))]>;
}

multiclass tgsi3_f32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins FRegs:$a, FRegs:$b, FRegs:$c),
        !strconcat(asmstr, " $d, $a, $b, $c"),
        [(set FRegs:$d, (op f32_src:$a, f32_src:$b, f32_src:$c))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins FVRegs:$a, FVRegs:$b, FVRegs:$c),
        !strconcat(asmstr, " $d, $a, $b, $c"),
        [(set FVRegs:$d, (op vf32_src:$a, vf32_src:$b, vf32_src:$c))]>;
}

multiclass tgsi3_fiff32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins IRegs:$a, FRegs:$b, FRegs:$c),
        !strconcat(asmstr, " $d, $a, $b, $c"),
        [(set FRegs:$d, (op i32_src:$a, f32_src:$b, f32_src:$c))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins IVRegs:$a, FVRegs:$b, FVRegs:$c),
        !strconcat(asmstr, " $d, $a, $b, $c"),
        [(set FVRegs:$d, (op vi32_src:$a, vf32_src:$b, vf32_src:$c))]>;
}

multiclass tgsi1_if32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs IRegs:$d), (ins FRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set IRegs:$d, (op f32_src:$a))]>;

   def v: tgsi_class<instr, (outs IVRegs:$d), (ins FVRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set IVRegs:$d, (op vf32_src:$a))]>;
}

multiclass tgsi1_fi32_class<bits<8> instr, SDNode op, string asmstr> {
   def s: tgsi_class<instr, (outs FRegs:$d), (ins IRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set FRegs:$d, (op i32_src:$a))]>;

   def v: tgsi_class<instr, (outs FVRegs:$d), (ins IVRegs:$a),
          !strconcat(asmstr, " $d, $a"),
          [(set FVRegs:$d, (op vi32_src:$a))]>;
}

multiclass ld_class<bits<8> instr, ComplexPattern pat_ptr, string addrspace> {
   def is: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ".xxxx, $a")),
	        [(set IRegs:$d, (load pat_ptr:$a))]>, tgsi_src_resource_class;

   def isz8: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ".xxxx, $a")),
	        [(set IRegs:$d, (zextloadi8 pat_ptr:$a))]>, tgsi_src_resource_class;

   def isz16: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ".xxxx, $a")),
	        [(set IRegs:$d, (zextloadi16 pat_ptr:$a))]>, tgsi_src_resource_class;

   def iss8: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ".xxxx, $a")),
	        [(set IRegs:$d, (sextloadi8 pat_ptr:$a))]>, tgsi_src_resource_class;

   def iss16: tgsi_class<instr, (outs IRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ".xxxx, $a")),
	        [(set IRegs:$d, (sextloadi16 pat_ptr:$a))]>, tgsi_src_resource_class;
   
   def fs: tgsi_class<instr, (outs FRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ".xxxx, $a")),
	        [(set FRegs:$d, (load pat_ptr:$a))]>, tgsi_src_resource_class;

   def iv: tgsi_class<instr, (outs IVRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ", $a")),
	        [(set IVRegs:$d, (load pat_ptr:$a))]>, tgsi_src_resource_class;

   def fv: tgsi_class<instr, (outs FVRegs:$d), (ins IRegs:$a),
                !strconcat("LOAD $d, ", !strconcat(addrspace, ", $a")),
	        [(set FVRegs:$d, (load pat_ptr:$a))]>, tgsi_src_resource_class;
}

multiclass st_class<bits<8> instr, ComplexPattern pat_ptr, string addrspace> {
   def is: tgsi_class<instr, (outs), (ins IRegs:$d, IRegs:$a),
                !strconcat("STORE ", !strconcat(addrspace, ".x, $d, $a")),
	        [(store i32_src:$a, pat_ptr:$d)]>, tgsi_dst_resource_class;

   def ist8: tgsi_class<instr, (outs), (ins IRegs:$d, IRegs:$a),
                !strconcat("STORE ", !strconcat(addrspace, ".x, $d, $a")),
	        [(truncstorei8 i32_src:$a, pat_ptr:$d)]>, tgsi_dst_resource_class;

   def ist16: tgsi_class<instr, (outs), (ins IRegs:$d, IRegs:$a),
                !strconcat("STORE ", !strconcat(addrspace, ".x, $d, $a")),
	        [(truncstorei16 i32_src:$a, pat_ptr:$d)]>, tgsi_dst_resource_class;

   def fs: tgsi_class<instr, (outs), (ins IRegs:$d, FRegs:$a),
                !strconcat("STORE ", !strconcat(addrspace, ".x, $d, $a")),
	        [(store f32_src:$a, pat_ptr:$d)]>, tgsi_dst_resource_class;

   def iv: tgsi_class<instr, (outs), (ins IRegs:$d, IVRegs:$a),
                !strconcat("STORE ", !strconcat(addrspace, ", $d, $a")),
	        [(store vi32_src:$a, pat_ptr:$d)]>, tgsi_dst_resource_class;

   def fv: tgsi_class<instr, (outs), (ins IRegs:$d, FVRegs:$a),
                !strconcat("STORE ", !strconcat(addrspace, ", $d, $a")),
	        [(store vf32_src:$a, pat_ptr:$d)]>, tgsi_dst_resource_class;
}


//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// Note MEMORY[x] needs to be in sync with TGSI_MEM_DECL in TGSIRegisterInfo.h
defm LDg : ld_class<145, global_ptr, "MEMORY[0]">, tgsi_addr_space_global_class;
defm STg : st_class<159, global_ptr, "MEMORY[0]">, tgsi_addr_space_global_class;
defm LDl : ld_class<145, local_ptr, "MEMORY[1]">, tgsi_addr_space_local_class;
defm STl : st_class<159, local_ptr, "MEMORY[1]">, tgsi_addr_space_local_class;
defm LDp : ld_class<145, private_ptr, "MEMORY[2]">, tgsi_addr_space_private_class;
defm STp : st_class<159, private_ptr, "MEMORY[2]">, tgsi_addr_space_private_class;
defm LDi : ld_class<145, input_ptr, "MEMORY[3]">, tgsi_addr_space_input_class;
// There is no special const mem, use global
defm LDc : ld_class<145, const_ptr, "MEMORY[0]">, tgsi_addr_space_constant_class;

defm MOVi : tgsi1np_i32_class<1, "MOV">;
defm INEG : tgsi1np_i32_class<123, "INEG">;
defm NOT : tgsi1p_i32_class<85, not, "NOT">;
defm UADD : tgsi2_i32_class<129, add, "UADD">;
defm UMUL : tgsi2_i32_class<135, mul, "UMUL">;
defm UDIV : tgsi2_i32_class<130, udiv, "UDIV">;
defm IDIV : tgsi2_i32_class<120, sdiv, "IDIV">;
defm UMOD : tgsi2_i32_class<134, urem, "UMOD">;
defm MOD : tgsi2_i32_class<91, srem, "MOD">;
defm SHL : tgsi2_i32_class<87, shl, "SHL">;
defm USHR : tgsi2_i32_class<138, srl, "USHR">;
defm ISHR : tgsi2_i32_class<125, sra, "ISHR">;
defm AND : tgsi2_i32_class<89, and, "AND">;
defm OR : tgsi2_i32_class<90, or, "OR">;
defm XOR : tgsi2_i32_class<92, xor, "XOR">;

// Floating point SetCCs
defm SEQ : tgsi2p_iff32_class<45, setueq, "SEQ">;
defm FSEQ : tgsi2p_iff32_class<46, seteq, "FSEQ">;
defm SGT : tgsi2p_iff32_class<47, setogt, "SGT">;
defm FSGE : tgsi2p_iff32_class<15, setoge, "FSGE">;
defm SGE  : tgsi2p_iff32_class<141, setge, "SGE">;
defm SLT : tgsi2p_iff32_class<14, setlt, "SLT">;
defm FSLT : tgsi2p_iff32_class<18, setolt, "FSLT">;
defm SLE : tgsi2p_iff32_class<49, setole, "SLE">;
defm SNE : tgsi2p_iff32_class<50, setne, "SNE">;
defm FSNE : tgsi2p_iff32_class<142, setune, "FSNE">;

//Integer SetCCs
defm USEQ : tgsi2p_i32_class<136, seteq, "USEQ">;
defm USNE : tgsi2p_i32_class<140, setne, "USNE">;
defm ISLT : tgsi2p_i32_class<126, setlt, "ISLT">;
defm ISGE : tgsi2p_i32_class<124, setge, "ISGE">;
defm USLT : tgsi2p_i32_class<139, setult, "USLT">;
defm USGE : tgsi2p_i32_class<137, setuge, "USGE">;

defm UCMPi : tgsi3_i32_class<158, select, "UCMP">;
defm CMP : tgsi3_fiff32_class<160, select, "CMP">;

defm MOVf : tgsi1np_f32_class<1, "MOV">;
defm SSG : tgsi1np_f32_class<65, "SSG">;
defm MOVfn : tgsi1_f321n_class<1, fneg, "MOV">;
defm ABS : tgsi1_f32_class<33, fabs, "ABS">;
def SIN : tgsi1_sf32_class<48, fsin, "SIN">;
def COS : tgsi1_sf32_class<36, fcos, "COS">;
def LG2 : tgsi1_sf32_class<29, flog2, "LG2">;
def EX2 : tgsi1_sf32_class<28, fexp2, "EX2">;
defm CEIL : tgsi1_f32_class<83, fceil, "CEIL">;
defm TRUNC : tgsi1_f32_class<86, ftrunc, "TRUNC">;
defm ROUND : tgsi1_f32_class<27, fnearbyint, "ROUND">;
defm FLR : tgsi1_f32_class<26, ffloor, "FLR">;
defm ADD : tgsi2_f32_class<8, fadd, "ADD">;
defm SUB : tgsi2_f321n_class<17, fsub, "ADD">;
defm MUL : tgsi2_f32_class<7, fmul, "MUL">;
defm DIV : tgsi2_f32_class<70, fdiv, "DIV">;
defm MAD : tgsi3_f32_class<16, fma, "MAD">;
defm SQRT: tgsi1_f32_class<222, fsqrt, "SQRT">;

defm I2F : tgsi1_fi32_class<84, sint_to_fp, "I2F">;
defm U2F : tgsi1_fi32_class<128, uint_to_fp, "U2F">;
defm F2I : tgsi1_if32_class<119, fp_to_sint, "F2I">;
defm F2U : tgsi1_if32_class<127, fp_to_uint, "F2U">;

let isBranch = 1, isTerminator = 1, isBarrier = 1 in {
   def IF_LOGICALNZ : tgsi_class<74, (outs), (ins IRegs:$s), "UIF $s : 0", []>;
   def ELSE : tgsi_class<77, (outs), (ins), "ELSE: 0", []>;
   def ENDIF : tgsi_class<78, (outs), (ins), "ENDIF", []>;
   def ENDLOOP : tgsi_class<101, (outs), (ins), "ENDLOOP: 0", []>;
   def CONT : tgsi_class<96, (outs), (ins), "CONT", []>;
   def BRK : tgsi_class<73, (outs), (ins), "BRK", []>;
}

let isBarrier = 1 in
    def BGNLOOP : tgsi_class<99, (outs), (ins), "BGNLOOP: 0", []>;

let isReturn = 1, isTerminator = 1, isBarrier = 1 in
    def RET : tgsi_class<64, (outs), (ins), "RET", [(ret)]>;

let isCall = 1, Defs = [TEMP1] in
    def CALL : tgsi_class<63, (outs), (ins calltarget:$d, variable_ops),
                          "CAL $d", [(call i32_imm:$d)]>;

def BGNSUB : tgsi_class<100, (outs), (ins), "BGNSUB", []>;
def ENDSUB : tgsi_class<102, (outs), (ins), "ENDSUB", []>;

//===----------------------------------------------------------------------===//
// Pseudo-Instructions
//===----------------------------------------------------------------------===//

let isPseudo = 1 in {
   let isBranch = 1, isTerminator = 1, isBarrier = 1 in
    def BRA : tgsi_class<62, (outs), (ins brtarget:$d), "BRA $d", [(br bb:$d)]>;

   let isBranch = 1, isTerminator = 1, isBarrier = 1 in
   def P_BRCOND : tgsi_class<-1, (outs), (ins IRegs:$c, brtarget:$d),
                          "P_BRCOND $c, $d", [(brcond IRegs:$c, bb:$d)]>;
}

//===----------------------------------------------------------------------===//
// Intrinsics - Barriers and Membars
//===----------------------------------------------------------------------===//
let isConvergent=1, isBarrier = 1  in {
    def INT_BARRIER : tgsi_class<253, (outs), (ins), "BARRIER", [(int_tgsi_barrier)]>;
    def INT_MEMBAR: tgsi_class<255, (outs), (ins i32imm:$a),"MEMBAR $a", [(int_tgsi_membar imm:$a)]>;
}


//===----------------------------------------------------------------------===//
// Non-Instruction Patterns
//===----------------------------------------------------------------------===//

def : Pat<(i32 imm:$a), (MOVis imm:$a)>;
def : Pat<(f32 (bitconvert (i32 IRegs:$a))), (f32 FRegs:$a)>;
def : Pat<(i32 (load_input i32_imm:$a)), (i32 (LDiis i32_imm:$a))>;
def : Pat<(sub i32_src:$a, i32_src:$b), (UADDs (INEGs i32_src:$b), i32_src:$a)>;

def : Pat<(f32 fpimm:$a), (MOVfs fpimm:$a)>;
def : Pat<(i32 (bitconvert (f32 FRegs:$a))), (i32 IRegs:$a)>;
def : Pat<(f32 (load_input i32_src:$a)), (f32 (LDifs i32_src:$a))>;
def : Pat<(fgetsign f32_src:$a), (F2Is (SSGs f32_src:$a))>;

def : Pat<(setgt f32_src:$a, f32_src:$b), (SGTs f32_src:$a, f32_src:$b)>;
def : Pat<(seteq f32_src:$a, f32_src:$b), (SEQs f32_src:$a, f32_src:$b)>;
def : Pat<(setne f32_src:$a, f32_src:$b), (SNEs f32_src:$a, f32_src:$b)>;
def : Pat<(setlt f32_src:$a, f32_src:$b), (SLTs f32_src:$a, f32_src:$b)>;
def : Pat<(setle f32_src:$a, f32_src:$b), (SLEs f32_src:$a, f32_src:$b)>;
def : Pat<(setgt f32_src:$a, f32_src:$b), (SGTs f32_src:$a, f32_src:$b)>;
def : Pat<(setge f32_src:$a, f32_src:$b), (SGEs f32_src:$a, f32_src:$b)>;

def : Pat<(v4f32 (bitconvert (v4i32 IVRegs:$a))), (v4f32 FVRegs:$a)>;
def : Pat<(v4i32 (load_input i32_src:$a)), (v4i32 (LDiiv i32_src:$a))>;
def : Pat<(v4i32 (bitconvert (v4f32 FVRegs:$a))), (v4i32 IVRegs:$a)>;
def : Pat<(v4f32 (load_input i32_src:$a)), (v4f32 (LDifv i32_src:$a))>;
