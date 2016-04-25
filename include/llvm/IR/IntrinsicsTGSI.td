//===--- IntrinsicsTGSI.td - Defines TGSI intrinsics -----*- tablegen -*---===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines all of the TGSI-specific intrinsics.
//
//===----------------------------------------------------------------------===//

let TargetPrefix = "tgsi" in {

class TGSIReadPreloadRegisterIntrinsic<string name>
  : Intrinsic<[llvm_i32_ty], [], [IntrNoMem]>,
    GCCBuiltin<name>;

multiclass TGSIReadPreloadRegisterIntrinsic_xyz<string prefix> {
  def _x : TGSIReadPreloadRegisterIntrinsic<!strconcat(prefix, "_x")>;
  def _y : TGSIReadPreloadRegisterIntrinsic<!strconcat(prefix, "_y")>;
  def _z : TGSIReadPreloadRegisterIntrinsic<!strconcat(prefix, "_z")>;
}

defm int_tgsi_read_blockid : TGSIReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_tgsi_read_blockid">;
defm int_tgsi_read_blocksize : TGSIReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_tgsi_read_blocksize">;
defm int_tgsi_read_gridsize : TGSIReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_tgsi_read_gridsize">;
defm int_tgsi_read_threadid : TGSIReadPreloadRegisterIntrinsic_xyz <
                                       "__builtin_tgsi_read_threadid">;
def int_tgsi_read_workdim : TGSIReadPreloadRegisterIntrinsic <
                                       "__builtin_tgsi_read_workdim">;

} // End TargetPrefix = "tgsi"
