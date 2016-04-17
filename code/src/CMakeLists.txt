cmake_minimum_required(VERSION 3.1)
project(synacor)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_subdirectory("main")
add_subdirectory("test")

enable_testing()
add_test(NAME test COMMAND test_synacor)
