//===- TGSISubtarget.cpp - TGSI Subtarget Information -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the TGSI specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "tgsi-subtarget"
#include "TGSISubtarget.h"
#include "TGSI.h"
#include "llvm/Support/TargetRegistry.h"

#define GET_SUBTARGETINFO_TARGET_DESC
#define GET_SUBTARGETINFO_CTOR
#include "TGSIGenSubtargetInfo.inc"

using namespace llvm;

TGSISubtarget::TGSISubtarget(const Triple &TT, const std::string &CPU,
			     const std::string &FS, TargetMachine &TM) :
   TGSIGenSubtargetInfo(TT, CPU, FS),
   InstrInfo(*this),
   TLInfo(TM, *this),
   FrameLowering(*this) {

   // Determine default and user specified characteristics
   std::string CPUName = CPU.empty() ? "TGSI" : CPU;

   // Parse features string.
   ParseSubtargetFeatures(CPUName, FS);
}
