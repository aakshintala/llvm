//===- TGSIRegisterInfo.td - TGSI Register defs ----------*- tablegen -*-===//
// 
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
// 
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the TGSI register file 
//===----------------------------------------------------------------------===//

let Namespace = "TGSI" in {
    def sub_x  : SubRegIndex<32>;
    def sub_y  : SubRegIndex<32>;
    def sub_z  : SubRegIndex<32>;
    def sub_w  : SubRegIndex<32>;

    class TGSIReg<string n, int id, int c> : Register<n> {
        let HWEncoding{11-0} = id;
        let HWEncoding{15-12} = c;
    }

    class TGSIVReg<string n, int id, list<Register> subregs> :
          RegisterWithSubRegs<n, subregs> {
        let HWEncoding{11-0} = id;
        let HWEncoding{15-12} = 0xf;
        let SubRegIndices = [sub_x, sub_y, sub_z, sub_w];
    }
}

// Temporary registers
def TEMP0x : TGSIReg<"TEMP[0].x", 0, 1>;
def TEMP0y : TGSIReg<"TEMP[0].y", 0, 2>;
def TEMP0z : TGSIReg<"TEMP[0].z", 0, 4>;
def TEMP0w : TGSIReg<"TEMP[0].w", 0, 8>;
def TEMP0 : TGSIVReg<"TEMP[0]", 0, [TEMP0x, TEMP0y, TEMP0z, TEMP0w]>;
def TEMP1x : TGSIReg<"TEMP[1].x", 1, 1>;
def TEMP1y : TGSIReg<"TEMP[1].y", 1, 2>;
def TEMP1z : TGSIReg<"TEMP[1].z", 1, 4>;
def TEMP1w : TGSIReg<"TEMP[1].w", 1, 8>;
def TEMP1 : TGSIVReg<"TEMP[1]", 1, [TEMP1x, TEMP1y, TEMP1z, TEMP1w]>;
def TEMP2x : TGSIReg<"TEMP[2].x", 2, 1>;
def TEMP2y : TGSIReg<"TEMP[2].y", 2, 2>;
def TEMP2z : TGSIReg<"TEMP[2].z", 2, 4>;
def TEMP2w : TGSIReg<"TEMP[2].w", 2, 8>;
def TEMP2 : TGSIVReg<"TEMP[2]", 2, [TEMP2x, TEMP2y, TEMP2z, TEMP2w]>;
def TEMP3x : TGSIReg<"TEMP[3].x", 3, 1>;
def TEMP3y : TGSIReg<"TEMP[3].y", 3, 2>;
def TEMP3z : TGSIReg<"TEMP[3].z", 3, 4>;
def TEMP3w : TGSIReg<"TEMP[3].w", 3, 8>;
def TEMP3 : TGSIVReg<"TEMP[3]", 3, [TEMP3x, TEMP3y, TEMP3z, TEMP3w]>;
def TEMP4x : TGSIReg<"TEMP[4].x", 4, 1>;
def TEMP4y : TGSIReg<"TEMP[4].y", 4, 2>;
def TEMP4z : TGSIReg<"TEMP[4].z", 4, 4>;
def TEMP4w : TGSIReg<"TEMP[4].w", 4, 8>;
def TEMP4 : TGSIVReg<"TEMP[4]", 4, [TEMP4x, TEMP4y, TEMP4z, TEMP4w]>;
def TEMP5x : TGSIReg<"TEMP[5].x", 5, 1>;
def TEMP5y : TGSIReg<"TEMP[5].y", 5, 2>;
def TEMP5z : TGSIReg<"TEMP[5].z", 5, 4>;
def TEMP5w : TGSIReg<"TEMP[5].w", 5, 8>;
def TEMP5 : TGSIVReg<"TEMP[5]", 5, [TEMP5x, TEMP5y, TEMP5z, TEMP5w]>;
def TEMP6x : TGSIReg<"TEMP[6].x", 6, 1>;
def TEMP6y : TGSIReg<"TEMP[6].y", 6, 2>;
def TEMP6z : TGSIReg<"TEMP[6].z", 6, 4>;
def TEMP6w : TGSIReg<"TEMP[6].w", 6, 8>;
def TEMP6 : TGSIVReg<"TEMP[6]", 6, [TEMP6x, TEMP6y, TEMP6z, TEMP6w]>;
def TEMP7x : TGSIReg<"TEMP[7].x", 7, 1>;
def TEMP7y : TGSIReg<"TEMP[7].y", 7, 2>;
def TEMP7z : TGSIReg<"TEMP[7].z", 7, 4>;
def TEMP7w : TGSIReg<"TEMP[7].w", 7, 8>;
def TEMP7 : TGSIVReg<"TEMP[7]", 7, [TEMP7x, TEMP7y, TEMP7z, TEMP7w]>;
def TEMP8x : TGSIReg<"TEMP[8].x", 8, 1>;
def TEMP8y : TGSIReg<"TEMP[8].y", 8, 2>;
def TEMP8z : TGSIReg<"TEMP[8].z", 8, 4>;
def TEMP8w : TGSIReg<"TEMP[8].w", 8, 8>;
def TEMP8 : TGSIVReg<"TEMP[8]", 8, [TEMP8x, TEMP8y, TEMP8z, TEMP8w]>;
def TEMP9x : TGSIReg<"TEMP[9].x", 9, 1>;
def TEMP9y : TGSIReg<"TEMP[9].y", 9, 2>;
def TEMP9z : TGSIReg<"TEMP[9].z", 9, 4>;
def TEMP9w : TGSIReg<"TEMP[9].w", 9, 8>;
def TEMP9 : TGSIVReg<"TEMP[9]", 9, [TEMP9x, TEMP9y, TEMP9z, TEMP9w]>;
def TEMP10x : TGSIReg<"TEMP[10].x", 10, 1>;
def TEMP10y : TGSIReg<"TEMP[10].y", 10, 2>;
def TEMP10z : TGSIReg<"TEMP[10].z", 10, 4>;
def TEMP10w : TGSIReg<"TEMP[10].w", 10, 8>;
def TEMP10 : TGSIVReg<"TEMP[10]", 10, [TEMP10x, TEMP10y, TEMP10z, TEMP10w]>;
def TEMP11x : TGSIReg<"TEMP[11].x", 11, 1>;
def TEMP11y : TGSIReg<"TEMP[11].y", 11, 2>;
def TEMP11z : TGSIReg<"TEMP[11].z", 11, 4>;
def TEMP11w : TGSIReg<"TEMP[11].w", 11, 8>;
def TEMP11 : TGSIVReg<"TEMP[11]", 11, [TEMP11x, TEMP11y, TEMP11z, TEMP11w]>;
def TEMP12x : TGSIReg<"TEMP[12].x", 12, 1>;
def TEMP12y : TGSIReg<"TEMP[12].y", 12, 2>;
def TEMP12z : TGSIReg<"TEMP[12].z", 12, 4>;
def TEMP12w : TGSIReg<"TEMP[12].w", 12, 8>;
def TEMP12 : TGSIVReg<"TEMP[12]", 12, [TEMP12x, TEMP12y, TEMP12z, TEMP12w]>;
def TEMP13x : TGSIReg<"TEMP[13].x", 13, 1>;
def TEMP13y : TGSIReg<"TEMP[13].y", 13, 2>;
def TEMP13z : TGSIReg<"TEMP[13].z", 13, 4>;
def TEMP13w : TGSIReg<"TEMP[13].w", 13, 8>;
def TEMP13 : TGSIVReg<"TEMP[13]", 13, [TEMP13x, TEMP13y, TEMP13z, TEMP13w]>;
def TEMP14x : TGSIReg<"TEMP[14].x", 14, 1>;
def TEMP14y : TGSIReg<"TEMP[14].y", 14, 2>;
def TEMP14z : TGSIReg<"TEMP[14].z", 14, 4>;
def TEMP14w : TGSIReg<"TEMP[14].w", 14, 8>;
def TEMP14 : TGSIVReg<"TEMP[14]", 14, [TEMP14x, TEMP14y, TEMP14z, TEMP14w]>;
def TEMP15x : TGSIReg<"TEMP[15].x", 15, 1>;
def TEMP15y : TGSIReg<"TEMP[15].y", 15, 2>;
def TEMP15z : TGSIReg<"TEMP[15].z", 15, 4>;
def TEMP15w : TGSIReg<"TEMP[15].w", 15, 8>;
def TEMP15 : TGSIVReg<"TEMP[15]", 15, [TEMP15x, TEMP15y, TEMP15z, TEMP15w]>;
def TEMP16x : TGSIReg<"TEMP[16].x", 16, 1>;
def TEMP16y : TGSIReg<"TEMP[16].y", 16, 2>;
def TEMP16z : TGSIReg<"TEMP[16].z", 16, 4>;
def TEMP16w : TGSIReg<"TEMP[16].w", 16, 8>;
def TEMP16 : TGSIVReg<"TEMP[16]", 16, [TEMP16x, TEMP16y, TEMP16z, TEMP16w]>;
def TEMP17x : TGSIReg<"TEMP[17].x", 17, 1>;
def TEMP17y : TGSIReg<"TEMP[17].y", 17, 2>;
def TEMP17z : TGSIReg<"TEMP[17].z", 17, 4>;
def TEMP17w : TGSIReg<"TEMP[17].w", 17, 8>;
def TEMP17 : TGSIVReg<"TEMP[17]", 17, [TEMP17x, TEMP17y, TEMP17z, TEMP17w]>;
def TEMP18x : TGSIReg<"TEMP[18].x", 18, 1>;
def TEMP18y : TGSIReg<"TEMP[18].y", 18, 2>;
def TEMP18z : TGSIReg<"TEMP[18].z", 18, 4>;
def TEMP18w : TGSIReg<"TEMP[18].w", 18, 8>;
def TEMP18 : TGSIVReg<"TEMP[18]", 18, [TEMP18x, TEMP18y, TEMP18z, TEMP18w]>;
def TEMP19x : TGSIReg<"TEMP[19].x", 19, 1>;
def TEMP19y : TGSIReg<"TEMP[19].y", 19, 2>;
def TEMP19z : TGSIReg<"TEMP[19].z", 19, 4>;
def TEMP19w : TGSIReg<"TEMP[19].w", 19, 8>;
def TEMP19 : TGSIVReg<"TEMP[19]", 19, [TEMP19x, TEMP19y, TEMP19z, TEMP19w]>;
def TEMP20x : TGSIReg<"TEMP[20].x", 20, 1>;
def TEMP20y : TGSIReg<"TEMP[20].y", 20, 2>;
def TEMP20z : TGSIReg<"TEMP[20].z", 20, 4>;
def TEMP20w : TGSIReg<"TEMP[20].w", 20, 8>;
def TEMP20 : TGSIVReg<"TEMP[20]", 20, [TEMP20x, TEMP20y, TEMP20z, TEMP20w]>;
def TEMP21x : TGSIReg<"TEMP[21].x", 21, 1>;
def TEMP21y : TGSIReg<"TEMP[21].y", 21, 2>;
def TEMP21z : TGSIReg<"TEMP[21].z", 21, 4>;
def TEMP21w : TGSIReg<"TEMP[21].w", 21, 8>;
def TEMP21 : TGSIVReg<"TEMP[21]", 21, [TEMP21x, TEMP21y, TEMP21z, TEMP21w]>;
def TEMP22x : TGSIReg<"TEMP[22].x", 22, 1>;
def TEMP22y : TGSIReg<"TEMP[22].y", 22, 2>;
def TEMP22z : TGSIReg<"TEMP[22].z", 22, 4>;
def TEMP22w : TGSIReg<"TEMP[22].w", 22, 8>;
def TEMP22 : TGSIVReg<"TEMP[22]", 22, [TEMP22x, TEMP22y, TEMP22z, TEMP22w]>;
def TEMP23x : TGSIReg<"TEMP[23].x", 23, 1>;
def TEMP23y : TGSIReg<"TEMP[23].y", 23, 2>;
def TEMP23z : TGSIReg<"TEMP[23].z", 23, 4>;
def TEMP23w : TGSIReg<"TEMP[23].w", 23, 8>;
def TEMP23 : TGSIVReg<"TEMP[23]", 23, [TEMP23x, TEMP23y, TEMP23z, TEMP23w]>;
def TEMP24x : TGSIReg<"TEMP[24].x", 24, 1>;
def TEMP24y : TGSIReg<"TEMP[24].y", 24, 2>;
def TEMP24z : TGSIReg<"TEMP[24].z", 24, 4>;
def TEMP24w : TGSIReg<"TEMP[24].w", 24, 8>;
def TEMP24 : TGSIVReg<"TEMP[24]", 24, [TEMP24x, TEMP24y, TEMP24z, TEMP24w]>;
def TEMP25x : TGSIReg<"TEMP[25].x", 25, 1>;
def TEMP25y : TGSIReg<"TEMP[25].y", 25, 2>;
def TEMP25z : TGSIReg<"TEMP[25].z", 25, 4>;
def TEMP25w : TGSIReg<"TEMP[25].w", 25, 8>;
def TEMP25 : TGSIVReg<"TEMP[25]", 25, [TEMP25x, TEMP25y, TEMP25z, TEMP25w]>;
def TEMP26x : TGSIReg<"TEMP[26].x", 26, 1>;
def TEMP26y : TGSIReg<"TEMP[26].y", 26, 2>;
def TEMP26z : TGSIReg<"TEMP[26].z", 26, 4>;
def TEMP26w : TGSIReg<"TEMP[26].w", 26, 8>;
def TEMP26 : TGSIVReg<"TEMP[26]", 26, [TEMP26x, TEMP26y, TEMP26z, TEMP26w]>;
def TEMP27x : TGSIReg<"TEMP[27].x", 27, 1>;
def TEMP27y : TGSIReg<"TEMP[27].y", 27, 2>;
def TEMP27z : TGSIReg<"TEMP[27].z", 27, 4>;
def TEMP27w : TGSIReg<"TEMP[27].w", 27, 8>;
def TEMP27 : TGSIVReg<"TEMP[27]", 27, [TEMP27x, TEMP27y, TEMP27z, TEMP27w]>;
def TEMP28x : TGSIReg<"TEMP[28].x", 28, 1>;
def TEMP28y : TGSIReg<"TEMP[28].y", 28, 2>;
def TEMP28z : TGSIReg<"TEMP[28].z", 28, 4>;
def TEMP28w : TGSIReg<"TEMP[28].w", 28, 8>;
def TEMP28 : TGSIVReg<"TEMP[28]", 28, [TEMP28x, TEMP28y, TEMP28z, TEMP28w]>;
def TEMP29x : TGSIReg<"TEMP[29].x", 29, 1>;
def TEMP29y : TGSIReg<"TEMP[29].y", 29, 2>;
def TEMP29z : TGSIReg<"TEMP[29].z", 29, 4>;
def TEMP29w : TGSIReg<"TEMP[29].w", 29, 8>;
def TEMP29 : TGSIVReg<"TEMP[29]", 29, [TEMP29x, TEMP29y, TEMP29z, TEMP29w]>;
def TEMP30x : TGSIReg<"TEMP[30].x", 30, 1>;
def TEMP30y : TGSIReg<"TEMP[30].y", 30, 2>;
def TEMP30z : TGSIReg<"TEMP[30].z", 30, 4>;
def TEMP30w : TGSIReg<"TEMP[30].w", 30, 8>;
def TEMP30 : TGSIVReg<"TEMP[30]", 30, [TEMP30x, TEMP30y, TEMP30z, TEMP30w]>;
def TEMP31x : TGSIReg<"TEMP[31].x", 31, 1>;
def TEMP31y : TGSIReg<"TEMP[31].y", 31, 2>;
def TEMP31z : TGSIReg<"TEMP[31].z", 31, 4>;
def TEMP31w : TGSIReg<"TEMP[31].w", 31, 8>;
def TEMP31 : TGSIVReg<"TEMP[31]", 31, [TEMP31x, TEMP31y, TEMP31z, TEMP31w]>;

// SV registers
def SV0x : TGSIReg<"SV[0].x", 0, 1>;
def SV0y : TGSIReg<"SV[0].y", 0, 2>;
def SV0z : TGSIReg<"SV[0].z", 0, 4>;
def SV0w : TGSIReg<"SV[0].w", 0, 8>;
def SV0 : TGSIVReg<"SV[0]", 0, [SV0x, SV0y, SV0z, SV0w]>;
def SV1x : TGSIReg<"SV[1].x", 1, 1>;
def SV1y : TGSIReg<"SV[1].y", 1, 2>;
def SV1z : TGSIReg<"SV[1].z", 1, 4>;
def SV1w : TGSIReg<"SV[1].w", 1, 8>;
def SV1 : TGSIVReg<"SV[1]", 1, [SV1x, SV1y, SV1z, SV1w]>;
def SV2x : TGSIReg<"SV[2].x", 2, 1>;
def SV2y : TGSIReg<"SV[2].y", 2, 2>;
def SV2z : TGSIReg<"SV[2].z", 2, 4>;
def SV2w : TGSIReg<"SV[2].w", 2, 8>;
def SV2 : TGSIVReg<"SV[2]", 2, [SV2x, SV2y, SV2z, SV2w]>;
def SV3x : TGSIReg<"SV[3].x", 3, 1>;
def SV3y : TGSIReg<"SV[3].y", 3, 2>;
def SV3z : TGSIReg<"SV[3].z", 3, 4>;
def SV3w : TGSIReg<"SV[3].w", 3, 8>;
def SV3 : TGSIVReg<"SV[3]", 3, [SV3x, SV3y, SV3z, SV3w]>;
def SV4x : TGSIReg<"SV[4].x", 4, 1>;
def SV4y : TGSIReg<"SV[4].y", 4, 2>;
def SV4z : TGSIReg<"SV[4].z", 4, 4>;
def SV4w : TGSIReg<"SV[4].w", 4, 8>;
def SV4 : TGSIVReg<"SV[4]", 4, [SV4x, SV4y, SV4z, SV4w]>;

// Address register
def ADDR0x : TGSIReg<"ADDR0x", 0, 1>;
def ADDR0y : TGSIReg<"ADDR0y", 0, 2>;
def ADDR0z : TGSIReg<"ADDR0z", 0, 4>;
def ADDR0w : TGSIReg<"ADDR0w", 0, 8>;
def ADDR0 : TGSIVReg<"ADDR0", 0, [ADDR0x, ADDR0y, ADDR0z, ADDR0w]>;

// Register classes.
//
def IRegs : RegisterClass<"TGSI", [i32], 32,
            (add (sequence "TEMP%ux", 0, 31), (sequence "TEMP%uy", 0, 31),
                 (sequence "TEMP%uz", 0, 31), (sequence "TEMP%uw", 0, 31),
                 (sequence "SV%ux", 0, 4), (sequence "SV%uy", 0, 4),
                 (sequence "SV%uz", 0, 4), (sequence "SV%uw", 0, 4))>;
def IVRegs : RegisterClass<"TGSI", [v4i32], 128,
            (add (sequence "TEMP%u", 0, 31), (sequence "SV%u", 0, 4))>;
def FRegs : RegisterClass<"TGSI", [f32], 32,
            (add (sequence "TEMP%ux", 0, 31), (sequence "TEMP%uy", 0, 31),
                 (sequence "TEMP%uz", 0, 31), (sequence "TEMP%uw", 0, 31))>;
def FVRegs : RegisterClass<"TGSI", [v4f32], 128, (sequence "TEMP%u", 0, 31)>;
def ARegs : RegisterClass<"TGSI", [i32], 32,
            (add (sequence "ADDR%ux", 0, 0), (sequence "ADDR%uy", 0, 0),
                 (sequence "ADDR%uz", 0, 0), (sequence "ADDR%uw", 0, 0))>;
def AVRegs : RegisterClass<"TGSI", [i32], 128, (sequence "ADDR%u", 0, 0)>;
