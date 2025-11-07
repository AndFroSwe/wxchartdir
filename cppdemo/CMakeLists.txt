# Cpp Demos
add_executable(cppdemo cppdemo.cpp)
target_link_libraries(cppdemo
  PRIVATE chartdir 
)

# Copy the dynamic library file to binary dir
set(wxChartDir_DYN_LIB ${CMAKE_SOURCE_DIR}/lib/win64/chartdir70.dll)
add_custom_command(
  TARGET cppdemo POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E  copy_if_different ${wxChartDir_DYN_LIB} $<TARGET_FILE_DIR:cppdemo>
  COMMENT "Copying dynamic library file to binary dir"
)
