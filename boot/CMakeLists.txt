include("${BOOTLOADER_CMAKE_PATH}/${BOOTLOADER_MODULE}.cmake")
include("${IMAGE_CMAKE_PATH}/${IMAGE_MODULE}.cmake")

if (${BOOTLOADER_RECOMPILE_NEXT_REBUILD})
    bootloader_mark_dirty()
    set(BOOTLOADER_RECOMPILE_NEXT_REBUILD OFF CACHE BOOL "Recompile bootloader on the next rebuild" FORCE)
endif()

add_custom_target(disk_img ALL DEPENDS ${IMAGE_PATH})