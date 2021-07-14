cmake_minimum_required(VERSION 3.5)

project(TestFinducc)
include(CTest)

find_package(UCC REQUIRED HINTS /opt/ucc/ /opt/ucf/ucc)
add_executable(test_ucc main.cpp)
target_link_libraries(test_ucc ucc::ucc)
add_test(NAME test_ucc COMMAND test_ucc)
