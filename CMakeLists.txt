cmake_minimum_required(VERSION 3.16)

project(siv3d_app_template LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(SIV3D_BUILD_FUNCTIONAL_TEST "Build the functional test application" ON)

# Build the SDK once from the git submodule and reuse it from each application.
set(SIV3D_BUILD_TESTING OFF CACHE BOOL "" FORCE)
add_subdirectory(third_party/OpenSiv3D/Linux third_party/OpenSiv3D-build EXCLUDE_FROM_ALL)

# OpenSiv3D's Linux headers select native intrinsics when SSE4.2 is enabled.
target_compile_options(Siv3D PRIVATE -msse4.2)

add_subdirectory(src)

if(SIV3D_BUILD_FUNCTIONAL_TEST)
    enable_testing()
    add_subdirectory(functional_test)
endif()
