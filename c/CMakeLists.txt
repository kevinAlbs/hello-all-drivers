cmake_minimum_required(VERSION 3.15)
project(hello-c C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(mongoc REQUIRED)

add_executable(hello hello.c monitor.c)
target_link_libraries(hello PRIVATE mongoc::shared)
