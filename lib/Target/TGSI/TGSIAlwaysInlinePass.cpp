//===-- TGSIAlwaysInlinePass.cpp - Promote Allocas ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
/// \file
/// This pass marks all internal functions as always_inline, creates
/// duplicates of all other functions and marks the duplicates as always_inline.
//
//===----------------------------------------------------------------------===//

#include "TGSI.h"
#include "llvm/IR/Module.h"
#include "llvm/Transforms/Utils/Cloning.h"

using namespace llvm;

namespace {

class TGSIAlwaysInline : public ModulePass {
  static char ID;

public:
  TGSIAlwaysInline() : ModulePass(ID) { }
  bool runOnModule(Module &M) override;
  StringRef getPassName() const override { return "TGSI Always Inline Pass"; }
};

} // End anonymous namespace

char TGSIAlwaysInline::ID = 0;

bool TGSIAlwaysInline::runOnModule(Module &M) {
  std::vector<GlobalAlias*> AliasesToRemove;
  std::vector<Function *> FuncsToClone;

  for (GlobalAlias &A : M.aliases()) {
    if (Function* F = dyn_cast<Function>(A.getAliasee())) {
      A.replaceAllUsesWith(F);
      AliasesToRemove.push_back(&A);
    }
  }

  for (GlobalAlias* A : AliasesToRemove) {
    A->eraseFromParent();
  }

  for (Function &F : M) {
    if (!F.hasLocalLinkage() && !F.isDeclaration() && !F.use_empty() &&
        !F.hasFnAttribute(Attribute::NoInline))
      FuncsToClone.push_back(&F);
  }

  for (Function *F : FuncsToClone) {
    ValueToValueMapTy VMap;
    Function *NewFunc = CloneFunction(F, VMap);
    NewFunc->setLinkage(GlobalValue::InternalLinkage);
    F->replaceAllUsesWith(NewFunc);
  }

  for (Function &F : M) {
    if (F.hasLocalLinkage() && !F.hasFnAttribute(Attribute::NoInline)) {
      F.addFnAttr(Attribute::AlwaysInline);
    }
  }
  return false;
}

ModulePass *llvm::createTGSIAlwaysInlinePass() {
  return new TGSIAlwaysInline();
}
