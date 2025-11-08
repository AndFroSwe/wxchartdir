add_executable(wxdemoapp WIN32
  $<$<PLATFORM_ID:Windows>:
    wxdemo.rc 
    sample.ico
    >
  wxdemoapp.cpp 
)
target_link_libraries(wxdemoapp PUBLIC wxdemo)
target_include_directories(wxdemoapp PUBLIC ${wxWidgets_INCLUDE_DIRS})

add_library(wxdemo wxdemo.cpp)
target_link_libraries(wxdemo
  PUBLIC chartdir wxchartdir ${wxWidgets_LIBRARIES}
  PRIVATE hotspotdialog democharts 
)
target_include_directories(wxdemo PRIVATE ${wxWidgets_INCLUDE_DIRS})

add_library(hotspotdialog hotspotdialog.cpp)
target_link_libraries(hotspotdialog PUBLIC ${wxWidgets_LIBRARIES} chartdir)
target_include_directories(hotspotdialog PRIVATE ${wxWidgets_INCLUDE_DIRS})


set(DEMO_SOURCES
  contourcrosssection.cpp
  financedemo.cpp
  threedchartrotation.cpp
  tracklegend.cpp
  tracklabel.cpp
  trackaxis.cpp
  trackbox.cpp
  trackfinance.cpp
  crosshair.cpp
  simplezoomscroll.cpp
  zoomscrolltrack.cpp
  zoomscrolltrack2.cpp
  zoomscrollpdf.cpp
  megazoomscroll.cpp
  viewportcontroldemo.cpp
  xyzoomscroll.cpp
  contourzoomscroll.cpp
  realtimedemo.cpp
  realtimetrack.cpp
  realtimezoomscroll.cpp
  megarealtimezoomscroll.cpp
  realtimemultichart.cpp
)

add_library(democharts ${DEMO_SOURCES} democharts.cpp)
target_link_libraries(democharts
  PRIVATE ${wxWidgets_LIBRARIES} chartdir wxchartdir 
)
target_include_directories(democharts 
  PRIVATE ${wxWidgets_INCLUDE_DIRS}
)
target_compile_options(democharts PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/FS>)


include("${CMAKE_SOURCE_DIR}/cmake/copydll.cmake")
copydll(wxdemo)

add_custom_command(
  TARGET wxdemoapp POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different ${CMAKE_CURRENT_LIST_DIR}/images/ $<TARGET_FILE_DIR:wxdemoapp>/images/
  COMMENT "Copying images for wxdemoapp"
)

add_custom_command(
  TARGET wxdemoapp POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different ${CMAKE_CURRENT_LIST_DIR}/icons/ $<TARGET_FILE_DIR:wxdemoapp>/icons/
  COMMENT "Copying icons for wxdemoapp"
)
