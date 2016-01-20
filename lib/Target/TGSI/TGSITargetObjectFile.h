//===-- TGSITargetObjectFile.h - TGSI Object Info -------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_TGSI_TGSITARGETOBJECTFILE_H
#define LLVM_LIB_TARGET_TGSI_TGSITARGETOBJECTFILE_H

#include "TGSISection.h"
#include "llvm/Target/TargetLoweringObjectFile.h"
#include <string>

namespace llvm {
class GlobalVariable;
class Module;

class TGSITargetObjectFile : public TargetLoweringObjectFile {

public:
  TGSITargetObjectFile() {
    TextSection = nullptr;
    DataSection = nullptr;
    BSSSection = nullptr;
    ReadOnlySection = nullptr;

    StaticCtorSection = nullptr;
    StaticDtorSection = nullptr;
    LSDASection = nullptr;
    EHFrameSection = nullptr;
    DwarfAbbrevSection = nullptr;
    DwarfInfoSection = nullptr;
    DwarfLineSection = nullptr;
    DwarfFrameSection = nullptr;
    DwarfPubTypesSection = nullptr;
    DwarfDebugInlineSection = nullptr;
    DwarfStrSection = nullptr;
    DwarfLocSection = nullptr;
    DwarfARangesSection = nullptr;
    DwarfRangesSection = nullptr;
  }

  virtual ~TGSITargetObjectFile();

  void Initialize(MCContext &ctx, const TargetMachine &TM) override {
    TargetLoweringObjectFile::Initialize(ctx, TM);
    TextSection = new TGSISection(MCSection::SV_ELF, SectionKind::getText());
    DataSection = new TGSISection(MCSection::SV_ELF, SectionKind::getData());
    BSSSection = new TGSISection(MCSection::SV_ELF, SectionKind::getBSS());
    ReadOnlySection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getReadOnly());

    StaticCtorSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    StaticDtorSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    LSDASection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    EHFrameSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfAbbrevSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfInfoSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfLineSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfFrameSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfPubTypesSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfDebugInlineSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfStrSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfLocSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfARangesSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
    DwarfRangesSection =
        new TGSISection(MCSection::SV_ELF, SectionKind::getMetadata());
  }

  MCSection *getSectionForConstant(const DataLayout &DL, SectionKind Kind,
                                   const Constant *C,
                                   unsigned &Align) const override {
    return ReadOnlySection;
  }

  MCSection *getExplicitSectionGlobal(const GlobalValue *GV, SectionKind Kind,
                                      Mangler &Mang,
                                      const TargetMachine &TM) const override {
    return DataSection;
  }

  MCSection *SelectSectionForGlobal(const GlobalValue *GV, SectionKind Kind,
                                    Mangler &Mang,
                                    const TargetMachine &TM) const override;
};

} // end namespace llvm

#endif
