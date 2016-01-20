add_llvm_library(LLVMTGSIDesc
  TGSIASMStreamer.cpp
  TGSIMCInstPrinter.cpp
  TGSIMCTargetDesc.cpp
  TGSITargetStreamer.cpp
  )

add_dependencies(LLVMTGSIDesc LLVMTGSIInfo)

add_dependencies(LLVMTGSIDesc TGSICommonTableGen)
