add_executable(helloworldapp WIN32
  $<$<PLATFORM_ID:Windows>:helloworld.rc sample.ico>
  helloworldapp.cpp 
)
target_link_libraries(helloworldapp
  PUBLIC chartdir wxchartdir ${wxWidgets_LIBRARIES}
  PRIVATE helloworld
)
target_include_directories(helloworldapp PUBLIC ${wxWidgets_INCLUDE_DIRS})

add_library(helloworld helloworld.cpp)
target_link_libraries(helloworld 
  PUBLIC chartdir wxchartdir
)
target_include_directories(helloworld
  PUBLIC ${wxWidgets_INCLUDE_DIRS}
)

include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(helloworld)
