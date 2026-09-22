function(add_gtest_executable target)
    add_executable(${target} ${target}.cpp)
    target_link_libraries(${target} PRIVATE
        app_components
        GTest::gtest_main
    )
    target_compile_features(${target} PRIVATE cxx_std_20)

    include(GoogleTest)
    gtest_discover_tests(${target} PROPERTIES LABELS unit_test)
endfunction()
