add_executable(realtimesweepapp WIN32
  $<$<PLATFORM_ID:Windows>:
    realtimedemo.rc 
    sample.ico
    >
  realtimesweepapp.cpp 
)
target_link_libraries(realtimesweepapp
  PUBLIC chartdir wxchartdir
  PRIVATE realtimesweep
)

add_library(realtimesweep realtimesweep.cpp)
target_link_libraries(realtimesweep 
  PUBLIC ${wxWidgets_LIBRARIES} chartdir wxchartdir randomwave
)
target_include_directories(realtimesweep
  PUBLIC ${wxWidgets_INCLUDE_DIRS}
)

add_library(randomwave randomwave.cpp)
target_link_libraries(randomwave PUBLIC ${wxWidgets_LIBRARIES})
target_include_directories(randomwave PUBLIC ${wxWidgets_INCLUDE_DIRS})

include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(realtimesweepapp)
