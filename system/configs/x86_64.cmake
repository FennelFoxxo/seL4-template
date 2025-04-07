set(PLATFORM "x86_64" CACHE STRING "")

set(KernelHugePage OFF CACHE BOOL "" FORCE)
set(KernelFSGSBase msr CACHE STRING "")
set(KernelSupportPCID OFF CACHE BOOL "")
set(KernelFPU FXSAVE CACHE STRING "")
set(KernelIRQController "PIC" CACHE STRING "")
