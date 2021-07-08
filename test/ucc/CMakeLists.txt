cmake_minimum_required(VERSION 3.5)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../cmake")
project(main)
find_package(ucc REQUIRED)

add_executable(${PROJECT_NAME} main.cpp)

# include_directories(${ucc_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} ucc)
