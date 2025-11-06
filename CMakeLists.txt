cmake_minimum_required(VERSION 3.31 FATAL_ERROR)

project(wxChartDir LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(wxWidgets 3.3.0 REQUIRED core base)

set(wxChartDir_LIB_DIR "${CMAKE_SOURCE_DIR}/lib/win64")

add_library(wxchartdir wxdemo/common/wxchartviewer.cpp)
target_link_libraries(wxchartdir  
  PUBLIC ${wxWidgets_LIBRARIES} $<$<PLATFORM_ID:Windows>:chartdir70>>
  PRIVATE
)
target_link_directories(wxchartdir  
  PUBLIC ${wxChartDir_LIB_DIR}
  PRIVATE
)
target_include_directories(wxchartdir 
  PUBLIC ${wxWidgets_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR}/include ${CMAKE_SOURCE_DIR}/wxdemo/common
  PRIVATE
)
