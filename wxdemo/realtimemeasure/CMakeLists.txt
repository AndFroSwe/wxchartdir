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
list(LENGTH SOURCE src_len)
list(LENGTH DEST dest_len)
if(NOT src_len EQUAL dest_len)
  message(FATAL_ERROR "Source and destination for app icons need to be equal")
endif()

add_custom_target(copy)

set(BINDIR $<TARGET_FILE_DIR:realtimemeasureapp>)
foreach(i RANGE 0 3)
  list(GET SOURCE ${i} src_file)
  list(GET DEST ${i} dest_file)

add_custom_command(
  TARGET copy POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_LIST_DIR}/${src_file}" "${BINDIR}/icons/${dest_file}"
COMMENT "Copying files for realtimemeasureapp: ${CMAKE_CURRENT_LIST_DIR}/${src_file} -> ${BINDIR}/icons/${dest_file}"
)
endforeach()
add_dependencies(realtimemeasureapp copy)

include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(realtimemeasureapp)
