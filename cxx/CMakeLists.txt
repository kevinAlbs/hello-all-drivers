cmake_minimum_required(VERSION 3.15)
project(hello-cxx CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

find_package(mongocxx REQUIRED)

add_executable(hello hello.cpp monitor.cpp)
target_link_libraries(hello PRIVATE mongo::mongocxx_shared)
