
find_package(libzmq REQUIRED)

include_directories(${LIBZMQ_INCLUDE_DIRS} "${CMAKE_CURRENT_SOURCE_DIR}/../libs/cppzmq")

set(SOURCE_FILES main.cpp)
add_executable(vm ${SOURCE_FILES})

target_link_libraries(vm ${LIBZMQ_LIBRARIES})
