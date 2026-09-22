function(add_default_build target)
    add_executable(${target} ${target}.cpp)
    target_link_libraries(${target} PRIVATE Siv3D app_components)
    target_include_directories(${target} PRIVATE
        "${CMAKE_SOURCE_DIR}/src/hello"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/include/ThirdParty"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src"
        "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Siv3D/src/ThirdParty"
    )
    target_compile_features(${target} PRIVATE cxx_std_20)

    set_target_properties(${target} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )

    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CMAKE_SOURCE_DIR}/third_party/OpenSiv3D/Linux/App/resources"
            "$<TARGET_FILE_DIR:${target}>/resources"
    )

    add_test(NAME ${target} COMMAND ${target})
endfunction()
