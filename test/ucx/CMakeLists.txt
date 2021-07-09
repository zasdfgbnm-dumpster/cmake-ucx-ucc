cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../cmake")

project(ucx-tests)

find_package(ucx REQUIRED COMPONENTS ucp uct ucs)

add_executable(test_ucp test_ucp.c)
target_include_directories(test_ucp PUBLIC ${ucx_INCLUDE_DIRS})
target_link_libraries(test_ucp ucx::ucp)
add_test(NAME test_ucp COMMAND test_ucp)

# add_executable(ucp_hello_world ucp_hello_world.c)
# target_include_directories(ucp_hello_world PUBLIC ${ucx_INCLUDE_DIRS})
# target_link_libraries(ucp_hello_world ucx::ucp ucx::uct ucx::ucs)

# add_executable(uct_hello_world uct_hello_world.c)
# target_include_directories(uct_hello_world PUBLIC ${ucx_INCLUDE_DIRS})
# target_link_libraries(uct_hello_world ucx::ucp ucx::uct ucx::ucs)
