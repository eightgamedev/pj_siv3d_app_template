#include "hello.h"

#include <iostream>
#include <string>

int main() {
    const std::string result = hello::hello();
    std::cout << result << '\n';

    return 0;
}
