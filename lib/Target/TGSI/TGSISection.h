//===- TGSISection.h - TGSI-specific section representation -*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the TGSISection class.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_TGSI_TGSISECTION_H
#define LLVM_LIB_TARGET_TGSI_TGSISECTION_H

#include "llvm/IR/GlobalVariable.h"
#include "llvm/MC/MCSection.h"
#include <vector>

namespace llvm {
/// Represents a section in PTX PTX does not have sections. We create this class
/// in order to use the ASMPrint interface.
///
class TGSISection final : public MCSection {
  virtual void anchor();
public:
  TGSISection(SectionVariant V, SectionKind K) : MCSection(V, K, nullptr) {}
  ~TGSISection() {}

  /// Override this as TGSI has its own way of printing switching
  /// to a section.
  void PrintSwitchToSection(const MCAsmInfo &MAI,
                            raw_ostream &OS,
                            const MCExpr *Subsection) const override {}

  /// Base address of PTX sections is zero.
  bool UseCodeAlign() const override { return false; }
  bool isVirtualSection() const override { return false; }
};

} // end namespace llvm

#endif
