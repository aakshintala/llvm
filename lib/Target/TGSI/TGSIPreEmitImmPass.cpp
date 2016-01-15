//===----------------------- TGSIPreEmitImmPass.cpp -----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// A pass that form early (predicated) returns. If-conversion handles some of
// this, but this pass picks up some remaining cases.
//
//===----------------------------------------------------------------------===//

#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/IR/Constants.h"
#include "llvm/Target/TargetSubtargetInfo.h"
#include "TGSI.h"

using namespace llvm;

#define DEBUG_TYPE "tgsi-preemit-imm"

namespace llvm {
   void initializeTGSIPreEmitImmPass(PassRegistry&);
}

namespace {
   struct TGSIPreEmitImm : public MachineFunctionPass {
      static char ID;
      TGSIPreEmitImm() : MachineFunctionPass(ID) {
         initializeTGSIPreEmitImmPass(*PassRegistry::getPassRegistry());
      }

      const TargetInstrInfo *TII;
      Type *I32Type;
      LLVMContext *LCtx;

protected:
      bool processBlock(MachineFunction &MF, MachineBasicBlock &MBB) {
         MachineConstantPool *MCP = MF.getConstantPool();
         bool Changed = false;

         for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end(); I++) {
            for (unsigned j = 0; j < I->getNumOperands(); j++) {
               const Constant *c;

               switch (I->getOperand(j).getType()) {
               case MachineOperand::MO_Immediate:
                  /* FIXME: what about 64 bit ints ? */
                  c = ConstantInt::get(Type::getInt32Ty(*LCtx),
                                       (int32_t)I->getOperand(j).getImm());
                  break;
               case MachineOperand::MO_FPImmediate:
                  c = I->getOperand(j).getFPImm();
                  /* FIXME */
                  break;
               default:
                  continue;
               }
               unsigned int idx = MCP->getConstantPoolIndex(c, 4);
               /* Store the idx as Immediate the writer will know what todo */
               I->getOperand(j).ChangeToImmediate(idx);
            }
         }

         return Changed;
      }

public:
      virtual bool doInitialization(Module &M) override {
         LCtx = &M.getContext();
         return false;
      }

      bool runOnMachineFunction(MachineFunction &MF) override {
         TII = MF.getSubtarget().getInstrInfo();

         bool Changed = false;

         for (MachineFunction::iterator I = MF.begin(); I != MF.end();) {
            MachineBasicBlock &B = *I++;
            if (processBlock(MF, B))
               Changed = true;
         }

         return Changed;
      }

      void getAnalysisUsage(AnalysisUsage &AU) const override {
         MachineFunctionPass::getAnalysisUsage(AU);
      }
   };
}

INITIALIZE_PASS(TGSIPreEmitImm, DEBUG_TYPE,
                "TGSI Pre-Emit Immediate translation pass", false, false)

char TGSIPreEmitImm::ID = 0;

FunctionPass*
llvm::createTGSIPreEmitImmPass() { return new TGSIPreEmitImm(); }
