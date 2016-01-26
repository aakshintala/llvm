//===---- TGSITargetTransformInfo.h - TGSI specific TTI ---------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
/// \file
/// This file a TargetTransformInfo::Concept conforming object specific to the
/// TGSI target machine. It uses the target's detailed information to
/// provide more precise answers to certain TTI queries, while letting the
/// target independent and default TTI implementations handle the rest.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_TGSI_TGSITARGETTRANSFORMINFO_H
#define LLVM_LIB_TARGET_TGSI_TGSITARGETTRANSFORMINFO_H

#include "TGSI.h"
#include "TGSITargetMachine.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/CodeGen/BasicTTIImpl.h"
#include "llvm/Target/TargetLowering.h"

namespace llvm {

class TGSITTIImpl : public BasicTTIImplBase<TGSITTIImpl> {
  typedef BasicTTIImplBase<TGSITTIImpl> BaseT;
  typedef TargetTransformInfo TTI;
  friend BaseT;

  const TGSISubtarget *ST;
  const TGSITargetLowering *TLI;

  const TGSISubtarget *getST() const { return ST; };
  const TGSITargetLowering *getTLI() const { return TLI; };

public:
  explicit TGSITTIImpl(const TGSITargetMachine *TM, const Function &F)
      : BaseT(TM, F.getParent()->getDataLayout()), ST(TM->getSubtargetImpl(F)),
        TLI(ST->getTargetLowering()) {}

  // Provide value semantics. MSVC requires that we spell all of these out.
  TGSITTIImpl(const TGSITTIImpl &Arg)
      : BaseT(static_cast<const BaseT &>(Arg)), ST(Arg.ST), TLI(Arg.TLI) {}
  TGSITTIImpl(TGSITTIImpl &&Arg)
      : BaseT(std::move(static_cast<BaseT &>(Arg))), ST(std::move(Arg.ST)),
        TLI(std::move(Arg.TLI)) {}

  bool hasBranchDivergence() { return true; }

  bool isSourceOfDivergence(const Value *V);
};

} // end namespace llvm

#endif
