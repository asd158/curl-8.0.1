# This module tries to find miniz library and include files
#
# ZLIB_INCLUDE_DIR, path where to find miniz.h
# ZLIB_LIBRARY_DIR, path where to find libminiz.so
# ZLIB_LIBRARIES, the library to link against
# ZLIB_FOUND, If false, do not try to use miniz
#
# This currently works probably only for Linux
set(ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/include)
if (WIN32)
    set(EXT_DIR win_x64/release)
    set(ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/include/win)
elseif (ANDROID)
    set(EXT_DIR android/${ANDROID_ABI})
    set(ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/include/android)
elseif (APPLE)
    if (IOS)
        set(EXT_DIR ios)
    else ()
        set(EXT_DIR mac_x64)
    endif ()
    set(ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/include/apple)
else ()
    IF (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
        SET(EXT_DIR ubt22_x64)
    ELSEIF (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
        SET(EXT_DIR ubt22_aarch64)
    ELSE ()
        MESSAGE(FATAL_ERROR not support ${CMAKE_SYSTEM_PROCESSOR})
    ENDIF ()
    set(ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/include/linux)
endif ()
list(APPEND ZLIB_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/include)
set(ZLIB_LIBRARIES ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/lib/${EXT_DIR}/libz.a)
if (WIN32)
    set(ZLIB_LIBRARIES ${CMAKE_SOURCE_DIR}/3rd/zlib-1.2.13/_bin/lib/${EXT_DIR}/zlibstatic.lib)
endif ()
IF (ZLIB_LIBRARIES)
    SET(ZLIB_FOUND "YES")
ENDIF (ZLIB_LIBRARIES)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZLIB DEFAULT_MSG
        ZLIB_INCLUDE_DIRS ZLIB_LIBRARIES ZLIB_FOUND)
MARK_AS_ADVANCED(ZLIB_INCLUDE_DIRS ZLIB_LIBRARIES)
