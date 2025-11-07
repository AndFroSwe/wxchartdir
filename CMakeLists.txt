cmake_minimum_required(VERSION 3.31 FATAL_ERROR)

project(wxChartDir LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(wxWidgets 3.3.0 REQUIRED core base)

# Chartdir imported files
add_library(chartdir STATIC IMPORTED)
set_target_properties(chartdir PROPERTIES
  IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/lib/win64/chartdir70.lib
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_SOURCE_DIR}/include
)

# wxChartDir
add_library(wxchartdir wxdemo/common/wxchartviewer.cpp)
target_link_libraries(wxchartdir  
  PUBLIC ${wxWidgets_LIBRARIES} chartdir
)
target_include_directories(wxchartdir 
  PUBLIC ${wxWidgets_INCLUDE_DIRS}  ${CMAKE_SOURCE_DIR}/wxdemo/common
)

add_subdirectory(cppdemo)
add_subdirectory(wxdemo)
