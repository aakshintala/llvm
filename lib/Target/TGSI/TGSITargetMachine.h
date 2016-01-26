//===-- TGSITargetMachine.h - Define TargetMachine for TGSI ---*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the TGSI specific subclass of TargetMachine.
//
//===----------------------------------------------------------------------===//

#ifndef TGSI_TARGET_MACHINE_H
#define TGSI_TARGET_MACHINE_H

#include "TGSISubtarget.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/Target/TargetMachine.h"

namespace llvm {
   class TGSITargetMachine : public LLVMTargetMachine {
      std::unique_ptr<TargetLoweringObjectFile> TLOF;
      TGSISubtarget Subtarget;
   public:
      TGSITargetMachine(const Target &T, const Triple &TT,
                        StringRef CPU, StringRef FS,
                        const TargetOptions &Options,
                        Optional<llvm::Reloc::Model> RM,
                        CodeModel::Model CM,
                        CodeGenOpt::Level OL);

      const TGSISubtarget *getSubtargetImpl(const Function &) const override {
         return &Subtarget;
      }

      TargetPassConfig *createPassConfig(PassManagerBase &PM);
      TargetLoweringObjectFile *getObjFileLowering() const override {
         return TLOF.get();
      }

      TargetIRAnalysis getTargetIRAnalysis() override;
   };

}

#endif
