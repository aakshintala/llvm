//===--------------------- TGSITargetStreamer.h ---------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_TGSI_MCTARGETDESC_TGSITARGETSTREAMER_H
#define LLVM_LIB_TARGET_TGSI_MCTARGETDESC_TGSITARGETSTREAMER_H

#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/MC/MCStreamer.h"

namespace llvm {

class TGSITargetStreamer : public MCTargetStreamer {
public:
   TGSITargetStreamer(MCStreamer &S);
   ~TGSITargetStreamer() override;

   virtual void EmitConstantPoolEntry(const MachineConstantPoolEntry &CPE);
   virtual void EmitStartOfAsmFile();
   virtual void EmitInstructionLabel(unsigned val);
};

} // namespace llvm.

#endif
