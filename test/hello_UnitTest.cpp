#include "hello.h"

#include <gtest/gtest.h>

TEST(HelloTest, ReturnValueTest)
{
    EXPECT_EQ(hello::hello(), "Hello, Siv3D!");
}