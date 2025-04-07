set(GRUB_DOWNLOAD_PATH "https://ftp.gnu.org/gnu/grub" CACHE STRING "URL to download GRUB bootloader from")
set(GRUB_VERSION "2.06" CACHE STRING "URL to download GRUB bootloader from")

set(GRUB_SRC_PATH "${BOOTLOADERS_PATH}/grub-${GRUB_VERSION}")
set(GRUB_BIN_PATH "${CMAKE_BINARY_DIR}/grub-${GRUB_VERSION}")
set(GRUB_MKIMAGE_PATH ${GRUB_BIN_PATH}/grub-mkimage)

set(GRUB_TARGET x86_64 CACHE STRING "GRUB target")
set(GRUB_PLATFORM efi CACHE STRING "GRUB platform")
set(GRUB_MODULES "configfile;fat;part_gpt;gzio;multiboot;reboot;cpuid;echo;sleep;video;video_bochs;video_cirrus;efi_gop;efi_uga;normal;chain;boot;multiboot2" CACHE STRING "GRUB Modules")
set(GRUB_CONFIG_PATH "${BOOTLOADER_CONFIGS_PATH}/grub.cfg" CACHE PATH "GRUB configuration file path")

set(BOOTLOADER_CONFIG_PATH "${CMAKE_CURRENT_BINARY_DIR}/grub.cfg")
set(BOOTLOADER_BIN_PATH "${CMAKE_CURRENT_BINARY_DIR}/grub")

if (NOT EXISTS "${GRUB_SRC_PATH}/configure")
    include(FetchContent)
    
    # This might take a while to download
    Set(FETCHCONTENT_QUIET FALSE)

    FetchContent_Declare(
        grub
        URL "${GRUB_DOWNLOAD_PATH}/grub-${GRUB_VERSION}.tar.xz"
        SOURCE_DIR "${GRUB_SRC_PATH}"
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
    )
    FetchContent_MakeAvailable(grub)
endif()

file(MAKE_DIRECTORY "${GRUB_BIN_PATH}")

add_custom_command(
    OUTPUT  "${GRUB_BIN_PATH}/Makefile"
    COMMAND "${GRUB_SRC_PATH}/configure" --target=${GRUB_TARGET} --with-platform=${GRUB_PLATFORM} --disable-werror --enable-silent-rules
    WORKING_DIRECTORY ${GRUB_BIN_PATH}
    DEPENDS "${GRUB_SRC_PATH}/configure"
    COMMENT "Configuring GRUB for compilation"
    VERBATIM USES_TERMINAL
)

add_custom_command(
    OUTPUT  "${GRUB_MKIMAGE_PATH}"
    COMMAND make
    WORKING_DIRECTORY ${GRUB_BIN_PATH}
    DEPENDS "${GRUB_BIN_PATH}/Makefile"
    COMMENT "Compiling GRUB"
    VERBATIM USES_TERMINAL
)

add_custom_command(
    OUTPUT "${BOOTLOADER_BIN_PATH}"
    COMMAND ${GRUB_MKIMAGE_PATH} -d ${GRUB_BIN_PATH}/grub-core -o ${BOOTLOADER_BIN_PATH} -O x86_64-efi -p "\"\"" ${GRUB_MODULES}
    DEPENDS "${GRUB_MKIMAGE_PATH}"
    COMMAND_EXPAND_LISTS
)

configure_file("${GRUB_CONFIG_PATH}" "${BOOTLOADER_CONFIG_PATH}")

macro(bootloader_mark_dirty)
    file(TOUCH_NOCREATE "${GRUB_SRC_PATH}/configure")
endmacro()
