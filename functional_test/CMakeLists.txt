add_executable(siv3d_app main.cpp)
target_link_libraries(siv3d_app PRIVATE Siv3D)
target_include_directories(siv3d_app PRIVATE
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include"
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include/ThirdParty"
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src"
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src/ThirdParty"
)
target_compile_features(siv3d_app PRIVATE cxx_std_20)

set_target_properties(siv3d_app PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

add_custom_command(TARGET siv3d_app POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Linux/App/resources"
        "$<TARGET_FILE_DIR:siv3d_app>/resources"
)

add_test(NAME siv3d_app COMMAND siv3d_app)

include(${CMAKE_SOURCE_DIR}/cmake/add_default_build.cmake)

add_subdirectory(hello)
