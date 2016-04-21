cmake_minimum_required(VERSION 3.1)
project(synacor)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_subdirectory("vm")
add_subdirectory("ida")
# add_subdirectory("test")
add_subdirectory("mapper")
add_subdirectory("play")

# enable_testing()
# add_test(NAME test COMMAND test_synacor)
