include_guard(GLOBAL)

set(BOOT_SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}")

set(BOOTLOADER_CMAKE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/bootloader" CACHE PATH "Folder containing .cmake files that drive bootloader builds")
set(IMAGE_CMAKE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/image" CACHE PATH "Folder containing .cmake files that drive image builds")
set(BOOTLOADER_CONFIGS_PATH "${CMAKE_CURRENT_LIST_DIR}/configs" CACHE PATH "Folder containing bootloader config files")
set(BOOTLOADERS_PATH "${CMAKE_CURRENT_LIST_DIR}/bootloaders" CACHE PATH "Folder containing bootloaders")
set(BOOTLOADER_FORCE_RECOMPILE OFF CACHE BOOL "Recompile bootloader on the next rebuild")

file(MAKE_DIRECTORY "${BOOTLOADERS_PATH}")

macro(set_bootloader_module bootloader_module_name)
    set(BOOTLOADER_MODULE ${bootloader_module_name})
endmacro()

macro(set_image_module image_module_name)
    set(IMAGE_MODULE ${image_module_name})
endmacro()

macro(build_image)
    add_subdirectory("${BOOT_SOURCE_PATH}")
endmacro()