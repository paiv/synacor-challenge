cmake_minimum_required(VERSION 3.1)
project(teleport)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# include_directories("${CMAKE_CURRENT_SOURCE_DIR}/bigdigits")

set(SOURCE_FILES flash.asm main.cpp)
add_executable(teleport ${SOURCE_FILES})

# set_target_properties(teleport PROPERTIES COMPILE_FLAGS "-save-temps")
# execute_process(COMMAND yasm -f macho64 flash.asm)
# target_link_libraries(teleport "${CMAKE_CURRENT_SOURCE_DIR}/flash.o")

# set(BD_SOURCE_FILES "bigdigits/bigdigits.c" "bigdigits/bigd.c")
# add_library(bigdigits ${BD_SOURCE_FILES})
# target_link_libraries(teleport bigdigits)
