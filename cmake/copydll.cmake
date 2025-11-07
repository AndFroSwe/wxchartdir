# copy_chartdir_dll(<target>)
# Copies the correct ChartDirector runtime library next to the built executable.
function(copydll TARGET)
    if(NOT TARGET ${TARGET})
        message(FATAL_ERROR "copy_chartdir_dll: ${TARGET} is not a valid target")
    endif()

    if(NOT WIN32)
        message(FATAL_ERROR "copy_chartdir_dll: only Windows is implemented")
    endif()

    # Pick the right DLL
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)          # 64-bit
        set(_dll "${CMAKE_SOURCE_DIR}/lib/win64/chartdir70.dll")
    else()                                   # 32-bit
        set(_dll "${CMAKE_SOURCE_DIR}/lib/win32/chartdir70.dll")
    endif()

    # Copy after the executable is created
    add_custom_command(TARGET ${TARGET} POST_BUILD
        COMMAND "${CMAKE_COMMAND}" -E copy_if_different
                "${_dll}"
                "$<TARGET_FILE_DIR:${TARGET}>"
        COMMENT "Copying ChartDirector runtime library next to ${TARGET}"
    )
endfunction()
