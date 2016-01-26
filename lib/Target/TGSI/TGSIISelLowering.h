//===-- TGSIISelLowering.h - TGSI DAG Lowering Interface ------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines the interfaces that TGSI uses to lower LLVM code into a
// selection DAG.
//
//===----------------------------------------------------------------------===//

#ifndef TGSI_ISEL_LOWERING_H
#define TGSI_ISEL_LOWERING_H

#include "llvm/Target/TargetLowering.h"
#include "TGSI.h"

namespace llvm {
   class TGSISubtarget;

   namespace TGSIISD {
      enum {
         FIRST_NUMBER = ISD::BUILTIN_OP_END,
         LOAD_INPUT,
         CALL,
         RET
      };
   }

   class TGSITargetLowering : public TargetLowering {
      const TGSISubtarget *Subtarget;
   public:
      TGSITargetLowering(TargetMachine &TM,
                         const TGSISubtarget &STI);
      SDValue LowerOperation(SDValue Op, SelectionDAG &DAG) const override;

      const char *getTargetNodeName(unsigned Opcode) const override;

      SDValue
      LowerFormalArguments(SDValue Chain,
                           CallingConv::ID CallConv,
                           bool isVarArg,
                           const SmallVectorImpl<ISD::InputArg> &Ins,
                           const SDLoc &dl, SelectionDAG &DAG,
                           SmallVectorImpl<SDValue> &InVals) const override;

      SDValue
      LowerCall(TargetLowering::CallLoweringInfo &CLI,
                SmallVectorImpl<SDValue> &InVals) const override;

      SDValue
      LowerReturn(SDValue Chain,
                  CallingConv::ID CallConv, bool isVarArg,
                  const SmallVectorImpl<ISD::OutputArg> &Outs,
                  const SmallVectorImpl<SDValue> &OutVals,
                  const SDLoc &dl, SelectionDAG &DAG) const override;
   private:
      /// \brief Helper function that adds Reg to the LiveIn list of the DAG's
      /// MachineFunction.
      ///
      /// \returns a RegisterSDNode representing Reg.
      SDValue CreateLiveInRegister(SelectionDAG &DAG,
                                   const TargetRegisterClass *RC,
                                   unsigned Reg, EVT VT) const;
   };
}

#endif
