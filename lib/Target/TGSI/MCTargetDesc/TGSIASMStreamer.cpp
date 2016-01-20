//===- lib/MC/TGSIELFStreamer.cpp - ELF Object Output for TGSI --------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "TGSITargetStreamer.h"

#include "llvm/IR/Constants.h"
#include "llvm/Support/FormattedStream.h"
#include "llvm/Support/raw_ostream.h"

namespace llvm {

class TGSITargetAsmStreamer : public TGSITargetStreamer {
   formatted_raw_ostream &OS;
   MCInstPrinter &InstPrinter;
   bool IsVerboseAsm;

public:
   TGSITargetAsmStreamer(MCStreamer &S, formatted_raw_ostream &OS,
                        MCInstPrinter &InstPrinter, bool VerboseAsm);
   virtual void EmitConstantPoolEntry(const MachineConstantPoolEntry &CPE) override;
};

TGSITargetAsmStreamer::TGSITargetAsmStreamer(MCStreamer &S,
                                             formatted_raw_ostream &OS,
                                             MCInstPrinter &InstPrinter,
                                             bool VerboseAsm)
    : TGSITargetStreamer(S), OS(OS), InstPrinter(InstPrinter),
      IsVerboseAsm(VerboseAsm) {}

void TGSITargetAsmStreamer::EmitConstantPoolEntry(
                                       const MachineConstantPoolEntry &CPE) {
   assert(!CPE.isMachineConstantPoolEntry());

   if (const ConstantInt *CI = dyn_cast<ConstantInt>(CPE.Val.ConstVal)) {
      assert(CI->getBitWidth() == 32);
      OS << "IMM UINT32 { " << CI->getZExtValue() << ", 0, 0, 0 }\n";
   }
}

MCTargetStreamer *createTGSITargetAsmStreamer(MCStreamer &S,
                                              formatted_raw_ostream &OS,
                                              MCInstPrinter *InstPrint,
                                              bool isVerboseAsm) {
   return new TGSITargetAsmStreamer(S, OS, *InstPrint, isVerboseAsm);
}

MCTargetStreamer *createTGSINullTargetStreamer(MCStreamer &S) {
   return new TGSITargetStreamer(S);
}

} // namespace llvm.
