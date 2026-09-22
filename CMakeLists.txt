cmake_minimum_required(VERSION 3.16)

project(siv3d_app_template LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(SIV3D_BUILD_FUNCTIONAL_TEST "Build the functional test application" ON)
set(ACTIVE_SOURCE "" CACHE FILEPATH "Source file selected in VS Code")

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

if(ACTIVE_SOURCE)
    if(NOT EXISTS "${ACTIVE_SOURCE}")
        message(FATAL_ERROR "ACTIVE_SOURCE does not exist: ${ACTIVE_SOURCE}")
    endif()

    add_executable(active_source
        "${ACTIVE_SOURCE}"
    )
    target_link_libraries(active_source PRIVATE Siv3D app_components)
    target_include_directories(active_source PRIVATE
        "${CMAKE_SOURCE_DIR}/src/hello"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include/ThirdParty"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src/ThirdParty"
    )
    target_compile_features(active_source PRIVATE cxx_std_20)

    set_target_properties(active_source PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )

    add_custom_command(TARGET active_source POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Linux/App/resources"
            "$<TARGET_FILE_DIR:active_source>/resources"
    )
endif()
