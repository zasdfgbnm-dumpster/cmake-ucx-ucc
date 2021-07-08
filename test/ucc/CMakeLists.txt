set(CMAKE_MODULE_PATH "../../cmake;${CMAKE_MODULE_PATH}")
project(main)
find_package(ucc REQUIRED)
add_executable(${PROJECT_NAME} main.cpp)
