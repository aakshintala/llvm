//===- TGSITargetStreamer.cpp - TGSITargetStreamer class --*- C++ -*---------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements the TGSITargetStreamer class.
//
//===----------------------------------------------------------------------===//
#include "TGSITargetStreamer.h"

using namespace llvm;

TGSITargetStreamer::TGSITargetStreamer(MCStreamer &S)
    : MCTargetStreamer(S) {}

TGSITargetStreamer::~TGSITargetStreamer() {}

void TGSITargetStreamer::EmitConstantPoolEntry(
                                  const MachineConstantPoolEntry &CPE) {}
void TGSITargetStreamer::EmitStartOfAsmFile() {}
