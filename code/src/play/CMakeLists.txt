
find_package(Readline REQUIRED)
find_package(libzmq REQUIRED)

include_directories(${READLINE_INCLUDE_DIR} ${LIBZMQ_INCLUDE_DIRS})
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/../libs/cppzmq")

set(SOURCE_FILES main.cpp)
add_executable(synacor ${SOURCE_FILES})

target_link_libraries(synacor ${READLINE_LIBRARIES} ${LIBZMQ_LIBRARIES})

execute_process(COMMAND codesign -f -s synacor synacor --deep)
