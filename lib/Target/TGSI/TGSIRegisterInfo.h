//===- TGSIRegisterInfo.h - TGSI Register Information Impl ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the TGSI implementation of the TargetRegisterInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef TGSI_REGISTER_INFO_H
#define TGSI_REGISTER_INFO_H

#define GET_REGINFO_HEADER
#include "TGSIGenRegisterInfo.inc"

// These need to be kept in sync, so we keep them together here

#define TGSI_SV_REGISTER_DECL   \
   "DCL SV[0], BLOCK_ID[0]\n"   \
   "DCL SV[1], BLOCK_SIZE[0]\n" \
   "DCL SV[2], GRID_SIZE[0]\n"  \
   "DCL SV[3], THREAD_ID[0]\n"  \
   "DCL SV[4], WORK_DIM[0]\n"

#define TGSI_BLOCK_ID(suffix) TGSI::SV0 ## suffix
#define TGSI_BLOCK_SIZE(suffix) TGSI::SV1 ## suffix
#define TGSI_GRID_SIZE(suffix) TGSI::SV2 ## suffix
#define TGSI_THREAD_ID(suffix) TGSI::SV3 ## suffix
#define TGSI_WORK_DIM TGSI::SV4x

// These needs to be kept in sync with the LD/ST definitions in TGSIInstrInfo.td
#define TGSI_MEM_DECL           \
   "DCL MEMORY[0], GLOBAL\n"    \
   "DCL MEMORY[1], SHARED\n"    \
   "DCL MEMORY[2], PRIVATE\n"   \
   "DCL MEMORY[3], INPUT\n"

namespace llvm {
   class TGSISubtarget;
   class TargetInstrInfo;
   class Type;

   namespace TGSIRF {
      enum {
         INDEX = 0xfff,
         COMPONENT = 0xf000,
         COMPONENT_X = 0x1000,
         COMPONENT_Y = 0x2000,
         COMPONENT_Z = 0x4000,
         COMPONENT_W = 0x8000,
         COMPONENT_XYZW = 0xf000
      };
   }

   struct TGSIRegisterInfo : public TGSIGenRegisterInfo {
      TGSISubtarget &Subtarget;
      const TargetInstrInfo &TII;

      TGSIRegisterInfo(TGSISubtarget &st, const TargetInstrInfo &tii);

      const MCPhysReg *getCalleeSavedRegs(const MachineFunction *MF = 0) const;

      BitVector getReservedRegs(const MachineFunction &MF) const;

      void eliminateFrameIndex(MachineBasicBlock::iterator II,
                               int SPAdj, unsigned FIOperandNum,
                               RegScavenger *RS = NULL) const;

      unsigned getFrameRegister(const MachineFunction &MF) const;

      unsigned getEHExceptionRegister() const;
      unsigned getEHHandlerRegister() const;
   };

}

#endif
