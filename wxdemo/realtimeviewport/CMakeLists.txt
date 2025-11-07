add_executable(realtimeviewportapp WIN32
  $<$<PLATFORM_ID:Windows>:
    realtimeviewport.rc 
    sample.ico
    >
  realtimeviewportapp.cpp 
)
target_link_libraries(realtimeviewportapp
  PUBLIC chartdir wxchartdir
  PRIVATE realtimeviewport
)
add_library(realtimeviewport realtimeviewport.cpp)
target_link_libraries(realtimeviewport 
  PUBLIC ${wxWidgets_LIBRARIES} chartdir wxchartdir realtimeviewport_randomwalk
)
target_include_directories(realtimeviewport
  PUBLIC ${wxWidgets_INCLUDE_DIRS}
)

add_library(realtimeviewport_randomwalk randomwalk.cpp)
target_link_libraries(realtimeviewport_randomwalk PUBLIC ${wxWidgets_LIBRARIES})
target_include_directories(realtimeviewport_randomwalk PUBLIC ${wxWidgets_INCLUDE_DIRS})

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
copy_images(realtimeviewportapp ${SOURCE} ${DEST})

include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(realtimeviewportapp)
