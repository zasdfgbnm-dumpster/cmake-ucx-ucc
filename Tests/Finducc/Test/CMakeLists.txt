cmake_minimum_required(VERSION 3.5)

project(TestFinducc)

find_package(ucc REQUIRED)

add_executable(test_ucc main.cpp)
target_include_directories(test_ucc PUBLIC ${ucc_INCLUDE_DIRS})
target_link_libraries(test_ucc ucc::ucc)
add_test(NAME test_ucc COMMAND test_ucc)
