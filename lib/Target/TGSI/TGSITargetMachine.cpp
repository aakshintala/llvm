//===-- TGSITargetMachine.cpp - Define TargetMachine for TGSI -----------===//
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

#include "TGSI.h"
#include "TGSITargetMachine.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

namespace {
   class TGSIPassConfig : public TargetPassConfig {
   public:
      TGSIPassConfig(TGSITargetMachine *TM, PassManagerBase &PM)
         : TargetPassConfig(TM, PM) {}

      TGSITargetMachine &getTGSITargetMachine() const {
         return getTM<TGSITargetMachine>();
      }

      virtual bool addInstSelector() {
         addPass(createTGSIISelDag(getTGSITargetMachine()));
         return false;
      }

      void addPreEmitPass() override {
         addPass(createTGSIPreEmitImmPass(), false);
      }
   };
}

extern "C" void LLVMInitializeTGSITarget() {
   RegisterTargetMachine<TGSITargetMachine> X(TheTGSITarget);
}

static std::string computeDataLayout(const Triple &TT, StringRef CPU,
                                     const TargetOptions &Options) {
   return std::string("E-p:32:32-i64:64:64-f32:32:32-n32");
}

TGSITargetMachine::TGSITargetMachine(const Target &T, const Triple &TT,
                                     StringRef CPU, StringRef FS,
                                     const TargetOptions &Options,
                                     Optional<llvm::Reloc::Model> RM,
                                     CodeModel::Model CM,
                                     CodeGenOpt::Level OL)
   // TGSI does not support linking (only supports building a single file)
   // So we always use Reloc::Static
   : LLVMTargetMachine(T, computeDataLayout(TT, CPU, Options),
                       TT, CPU, FS, Options, Reloc::Static, CM, OL),
     TLOF(make_unique<TargetLoweringObjectFileELF>()),
     Subtarget(TT, CPU, FS, *this) {
   initAsmInfo();
}

TargetPassConfig *TGSITargetMachine::createPassConfig(PassManagerBase &PM) {
   return new TGSIPassConfig(this, PM);
}
