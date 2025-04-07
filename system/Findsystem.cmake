include_guard(GLOBAL)

set(sel4_project_dir ${CMAKE_CURRENT_LIST_DIR})

macro(build_system)
    add_subdirectory(${sel4_project_dir} sel4_build)
    
    get_property(ROOTSERVER_PATH TARGET rootserver_image PROPERTY IMAGE_NAME)
    set(ROOTSERVER_PATH "${CMAKE_BINARY_DIR}/${ROOTSERVER_PATH}")
    
    get_property(KERNEL_PATH TARGET rootserver_image PROPERTY KERNEL_IMAGE_NAME)
    set(KERNEL_PATH "${CMAKE_BINARY_DIR}/${KERNEL_PATH}")
endmacro()