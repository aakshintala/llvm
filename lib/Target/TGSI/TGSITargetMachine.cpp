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
#include "TGSITargetObjectFile.h"
#include "TGSITargetTransformInfo.h"
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

      void addIRPasses() override {
         // FIXME: Implement a MachineModulePass to find and emit all immediates,
         // before any instructions. Then remove these always inline passes.
         // FIXME: OpenCL files fed to this backend can't have more than one 
         // __kernel__ in them.
         // While TGSI does support function calls, the requirement that all
         // immediate values be declared before the first instructuion in the TGSI
         // code, coupled with the lack of a MachineModulePass (which would be the
         // correct way to extract all Immediate values from a module and then
         // printing it using EmitStartOfAsmFile), means that we have to always 
         // inline all fucntions in an OpenCL file.
         addPass(createTGSIAlwaysInlinePass());
         addPass(createAlwaysInlinerLegacyPass());
         addPass(createBarrierNoopPass());
         TargetPassConfig::addIRPasses();
      }

      void addPreISel() override {
         addPass(createFlattenCFGPass());
         addPass(createStructurizeCFGPass());
         return false;
      }

      virtual bool addInstSelector() {
         addPass(createTGSIISelDag(getTGSITargetMachine()));
         return false;
      }

      void addPreSched2() override {
         addPass(&IfConverterID, false);
      }

      void addPreEmitPass() override {
         addPass(createTGSICFGStructurizerPass(). false);
         addPass(createTGSIPreEmitImmPass(getTGSITargetMachine().MCP), false);
         addPass(createTGSIControlFlowFinalizer(*TM), false);
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
     TLOF(make_unique<TGSITargetObjectFile>()),
     Subtarget(TT, CPU, FS, *this),
     MCP(DL) {
   initAsmInfo();
}

TargetPassConfig *TGSITargetMachine::createPassConfig(PassManagerBase &PM) {
   return new TGSIPassConfig(this, PM);
}

TargetIRAnalysis TGSITargetMachine::getTargetIRAnalysis() {
   return TargetIRAnalysis([this](const Function &F) {
      return TargetTransformInfo(TGSITTIImpl(this, F));
   });
}
