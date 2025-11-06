cmake_minimum_required(VERSION 3.31 FATAL_ERROR)

project(wxChartDir LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(wxWidgets 3.3.0 REQUIRED core base)

# OS dependencies
set(wxChartDir_LIB_DIR "${CMAKE_SOURCE_DIR}/lib/win64")

# Interface library for chartdir
add_library(chartdir INTERFACE)
target_include_directories(chartdir 
  INTERFACE ${CMAKE_SOURCE_DIR}/include
)

# Main wxChartDir library
add_library(wxchartdir wxdemo/common/wxchartviewer.cpp)
target_link_libraries(wxchartdir  
  PUBLIC ${wxWidgets_LIBRARIES} $<$<PLATFORM_ID:Windows>:chartdir70>
  PRIVATE
  INTERACE chartdir
)
target_link_directories(wxchartdir  
  PUBLIC ${wxChartDir_LIB_DIR}
  PRIVATE
)
target_include_directories(wxchartdir 
  PUBLIC ${wxWidgets_INCLUDE_DIRS}  ${CMAKE_SOURCE_DIR}/wxdemo/common
  PRIVATE
)

# Cpp Demos
add_executable(cppdemo cppdemo/cppdemo.cpp)
target_include_directories(cppdemo 
  PUBLIC 
  PRIVATE ${CMAKE_SOURCE_DIR}/cppdemo ${CMAKE_SOURCE_DIR}/include
)
target_link_directories(cppdemo  
  PUBLIC ${wxChartDir_LIB_DIR}
  PRIVATE
)
target_link_libraries(cppdemo
  PRIVATE $<$<PLATFORM_ID:Windows>:chartdir70>
  INTERFACE chartdir
)

# Copy the dynamic library file to binary dir
set(wxChartDir_DYN_LIB ${CMAKE_SOURCE_DIR}/lib/win64/chartdir70.dll)
add_custom_command(
  TARGET cppdemo POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E  copy_if_different ${wxChartDir_DYN_LIB} $<TARGET_FILE_DIR:cppdemo>
  COMMENT "Copying dynamic library file to binary dir"
)
