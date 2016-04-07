//===-- TGSI.h - Top-level interface for TGSI representation --*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in the LLVM
// TGSI back-end.
//
//===----------------------------------------------------------------------===//

#ifndef TGSI_H
#define TGSI_H

#include "MCTargetDesc/TGSIMCTargetDesc.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Target/TargetMachine.h"
#include <cassert>

namespace llvm {
   class FunctionPass;
   class TGSITargetMachine;

   FunctionPass *createTGSIISelDag(TGSITargetMachine &tm);
   FunctionPass *createTGSIPreEmitImmPass(MachineConstantPool &MCP);

   namespace tgsi {
      enum AddressSpace {
         // Enums corresponding to OpenCL address spaces
         PRIVATE = 0,
         GLOBAL = 1,
         LOCAL = 2,
         CONSTANT = 3,
         // Special address space the arguments of a __kernel function are stored in
         INPUT = 4
      };
   }

   namespace {
      inline const MDNode *getKernelMetadata(const Function *f) {
         const Module *m = f->getParent();
         assert(m);
         NamedMDNode *nmd = m->getNamedMetadata("opencl.kernels");
         assert(nmd);

         for (unsigned i = 0; i < nmd->getNumOperands(); ++i) {
            const MDNode *md = nmd->getOperand(i);
            const Function *md_f = mdconst::dyn_extract<llvm::Function>(
               md->getOperand(0));
            if (md_f == f)
               return md;
         }
         return NULL;
      }

      inline bool isKernelFunction(const Function *f) {
         return getKernelMetadata(f) != NULL;
      }
   }
}
#endif
