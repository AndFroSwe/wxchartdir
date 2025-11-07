# Copy images from the current dir to the icons folder in the binary dir
function(copy_images tgt img_sources img_dests)
  list(LENGTH img_sources src_len)
  list(LENGTH img_dests dest_len)
  if(NOT src_len EQUAL dest_len)
    message(FATAL_ERROR "Source and destination lists must be equal")
  endif()

  # unique target name so the function can be called more than once
  set(_tgt _copy_${tgt})
  add_custom_target(${_tgt} ALL)

  set(bindir "$<TARGET_FILE_DIR:${tgt}>")
  math(EXPR last_idx "${src_len} - 1")

  foreach(i RANGE 0 ${last_idx})
    list(GET img_sources ${i} src_file)
    list(GET img_dests   ${i} dest_file)

    add_custom_command(
      TARGET ${_tgt} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_if_different
              "${CMAKE_CURRENT_LIST_DIR}/${src_file}"
              "${bindir}/icons/${dest_file}"
      COMMENT "Copying icon: ${src_file} -> ${dest_file}"
    )
  endforeach()

  add_dependencies(${tgt} ${_tgt})
endfunction()
