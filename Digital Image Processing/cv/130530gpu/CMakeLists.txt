project(GpuImgFeature)
find_package(OpenCV REQUIRED)
add_executable(f main.cpp)
target_link_libraries(f ${OpenCV_LIBS})
