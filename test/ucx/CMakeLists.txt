cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../cmake")

project(main)

find_package(ucp REQUIRED)
find_package(uct REQUIRED)
find_package(ucs REQUIRED)

add_executable(${PROJECT_NAME} main.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC ${ucp_INCLUDE_DIRS} ${uct_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} ucp::ucp uct::uct ucs::ucs)
