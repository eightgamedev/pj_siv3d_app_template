add_library(app_components STATIC
    hello/hello.cpp
)
target_include_directories(app_components PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/hello"
)
