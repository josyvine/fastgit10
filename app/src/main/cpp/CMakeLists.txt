cmake_minimum_required(VERSION 3.22.1)

project("fastgit_native")

add_library(
    fastgit_native
    SHARED
    native-lib.cpp
)

target_compile_options(
    fastgit_native
    PRIVATE
    -fvisibility=hidden
    -ffunction-sections
    -fdata-sections
)

target_link_options(
    fastgit_native
    PRIVATE
    "-Wl,--gc-sections"
    "-Wl,-z,max-page-size=16384"
    $<$<CONFIG:Release>:-s>
)