cmake_minimum_required(VERSION 3.7.2)
project(tailspring_get_sel4_info C CXX ASM)

macro(include_sel4_configuration config_path)
    include("${CMAKE_CURRENT_LIST_DIR}/configs/${config_path}.cmake")
endmacro()

macro(finalize_sel4_configuration)
    include(${CMAKE_CURRENT_LIST_DIR}/settings.cmake)
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/core)
    include(rootserver)
endmacro()

macro(finalize_sel4_build)
    if(SIMULATION)
        include(simulation)
        if(KernelSel4ArchX86_64)
            SetSimulationScriptProperty(MEM_SIZE "3G")
        endif()
        if(KernelPlatformQEMUArmVirt)
            SetSimulationScriptProperty(MEM_SIZE "2G")
        endif()
        GenerateSimulateScript()
    endif()
endmacro()

include_sel4_configuration("common")
include_sel4_configuration("x86_64")
finalize_sel4_configuration()


find_package(root_task REQUIRED)


DeclareRootserver(root_task)
finalize_sel4_build()