add_executable(realtimemeasureapp WIN32
  $<$<PLATFORM_ID:Windows>:
    realtimemeasure.rc 
    sample.ico
    >
  realtimemeasureapp.cpp 
)
target_link_libraries(realtimemeasureapp
  PUBLIC chartdir wxchartdir
  PRIVATE realtimemeasure
)
add_library(realtimemeasure realtimemeasure.cpp)
target_link_libraries(realtimemeasure 
  PUBLIC ${wxWidgets_LIBRARIES} chartdir wxchartdir
)
target_include_directories(realtimemeasure
  PUBLIC ${wxWidgets_INCLUDE_DIRS}
)

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
copy_images(realtimemeasureapp ${SOURCE} ${DEST})

include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(realtimemeasureapp)
