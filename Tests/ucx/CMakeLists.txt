cmake_minimum_required(VERSION 3.5)

project(TestFinducx)
include(CTest)

find_package(UCX REQUIRED COMPONENTS ucp uct ucs HINTS /opt/ucx)

add_executable(test_ucp test_ucp.c)
target_link_libraries(test_ucp ucx::ucp)
add_test(NAME test_ucp COMMAND test_ucp)

add_executable(test_uct test_uct.c)
target_link_libraries(test_uct ucx::uct ucx::ucs)
add_test(NAME test_uct COMMAND test_uct)
