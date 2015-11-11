//=====-- TGSISubtarget.h - Define Subtarget for the TGSI ----*- C++ -*-====//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the TGSI specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#ifndef TGSI_SUBTARGET_H
#define TGSI_SUBTARGET_H

#include "TGSIInstrInfo.h"
#include "TGSIISelLowering.h"
#include "TGSIFrameLowering.h"
#include "llvm/CodeGen/SelectionDAGTargetInfo.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include <string>

#define GET_SUBTARGETINFO_HEADER
#include "TGSIGenSubtargetInfo.inc"

namespace llvm {
   class StringRef;

   class TGSISubtarget : public TGSIGenSubtargetInfo {
      TGSIInstrInfo InstrInfo;
      TGSITargetLowering TLInfo;
      SelectionDAGTargetInfo TSInfo;
      TGSIFrameLowering FrameLowering;
   public:
      TGSISubtarget(const Triple &TT, const std::string &CPU,
                    const std::string &FS, TargetMachine &TM);

      void ParseSubtargetFeatures(StringRef CPU, StringRef FS);

      const TGSIInstrInfo *getInstrInfo() const override { return &InstrInfo; }
      const TargetFrameLowering *getFrameLowering() const override {
         return &FrameLowering;
      }
      const TGSIRegisterInfo *getRegisterInfo() const override {
         return &InstrInfo.getRegisterInfo();
      }
      const TGSITargetLowering *getTargetLowering() const override {
         return &TLInfo;
      }
      const SelectionDAGTargetInfo *getSelectionDAGInfo() const override {
         return &TSInfo;
      }
   };

}

#endif
