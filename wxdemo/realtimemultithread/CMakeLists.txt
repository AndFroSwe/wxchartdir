add_executable(realtimemultithreadapp WIN32
  $<$<PLATFORM_ID:Windows>:
    realtimemultithread.rc 
    sample.ico
    >
  realtimemultithreadapp.cpp 
)
target_link_libraries(realtimemultithreadapp
  PUBLIC chartdir wxchartdir
  PRIVATE realtimemultithread
)

add_library(realtimemultithread realtimemultithread.cpp)
target_link_libraries(realtimemultithread 
  PUBLIC ${wxWidgets_LIBRARIES} chartdir wxchartdir randomwalk
)
target_include_directories(realtimemultithread
  PUBLIC ${wxWidgets_INCLUDE_DIRS}
)

add_library(randomwalk randomwalk.cpp)
target_link_libraries(randomwalk PUBLIC ${wxWidgets_LIBRARIES})
target_include_directories(randomwalk PUBLIC ${wxWidgets_INCLUDE_DIRS})

# Due to the implementation, png names are mapped to other names
# Set those here
set(SOURCE
  "pointer.png"
  "save.png"
  "zoomin.png"
  "zoomout.png"
)
set(DEST
  "scroll_icon.png"
  "save_icon.png"
  "zoomin_icon.png"
  "zoomout_icon.png"
)
include("${CMAKE_SOURCE_DIR}/cmake/copyimages.cmake")
copy_images(realtimemultithreadapp ${SOURCE} ${DEST})

include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(realtimemultithreadapp)
