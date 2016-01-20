//===-------------------- TGSIASMStreamer.h -------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_TGSI_MCTARGETDESC_TGSIASMSTREAMER_H
#define LLVM_LIB_TARGET_TGSI_MCTARGETDESC_TGSIASMSTREAMER_H

#include "llvm/MC/MCELFStreamer.h"

namespace llvm {

MCTargetStreamer *createTGSITargetAsmStreamer(MCStreamer &S,
                                             formatted_raw_ostream &OS,
                                             MCInstPrinter *InstPrint,
                                             bool isVerboseAsm);
                                             
MCTargetStreamer *createTGSINullTargetStreamer(MCStreamer &S);

} // namespace llvm.

#endif
