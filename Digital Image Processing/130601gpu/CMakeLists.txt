project(130601gpu)
cmake_minimum_required(VERSION 2.8)
aux_source_directory(. SRC_LIST)
find_package(OpenCV REQUIRED)
add_executable(${PROJECT_NAME} ${SRC_LIST})
target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})

