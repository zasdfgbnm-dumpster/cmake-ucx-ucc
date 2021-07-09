cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../cmake")

project(TestFinducx)

find_package(ucx REQUIRED COMPONENTS ucp uct ucs)

add_executable(test_ucp test_ucp.c)
target_include_directories(test_ucp PUBLIC ${ucx_INCLUDE_DIRS})
target_link_libraries(test_ucp ucx::ucp)
add_test(NAME test_ucp COMMAND test_ucp)

# add_executable(test_uct test_uct.c)
# target_include_directories(test_uct PUBLIC ${ucx_INCLUDE_DIRS})
# target_link_libraries(test_ucp ucx::uct ucx::ucs)
# add_test(NAME test_uct COMMAND test_uct)
