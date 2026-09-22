add_executable(siv3d_functional_test Main.cpp)
target_link_libraries(siv3d_functional_test PRIVATE Siv3D)
target_include_directories(siv3d_functional_test PRIVATE
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include"
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include/ThirdParty"
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src"
    "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src/ThirdParty"
)
target_compile_features(siv3d_functional_test PRIVATE cxx_std_20)

set_target_properties(siv3d_functional_test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

add_custom_command(TARGET siv3d_functional_test POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Linux/App/resources"
        "$<TARGET_FILE_DIR:siv3d_functional_test>/resources"
)

add_test(NAME siv3d_functional_test COMMAND siv3d_functional_test)
