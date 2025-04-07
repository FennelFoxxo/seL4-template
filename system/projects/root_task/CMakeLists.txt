cmake_minimum_required(VERSION 3.7.2)
project(root_task C CXX ASM)

add_executable(root_task src/main.c)
target_link_libraries(root_task sel4muslcsys)