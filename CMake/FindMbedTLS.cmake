#***************************************************************************
#                                  _   _ ____  _
#  Project                     ___| | | |  _ \| |
#                             / __| | | | |_) | |
#                            | (__| |_| |  _ <| |___
#                             \___|\___/|_| \_\_____|
#
# Copyright (C) Daniel Stenberg, <daniel@haxx.se>, et al.
#
# This software is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at https://curl.se/docs/copyright.html.
#
# You may opt to use, copy, modify, merge, publish, distribute and/or sell
# copies of the Software, and permit persons to whom the Software is
# furnished to do so, under the terms of the COPYING file.
#
# This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
# KIND, either express or implied.
#
# SPDX-License-Identifier: curl
#
###########################################################################
IF (WIN32)
    SET(EXT_DIR win_x64/release)
ELSEIF (ANDROID)
    SET(EXT_DIR android/${ANDROID_ABI})
ELSEIF (APPLE)
    IF (IOS)
        SET(EXT_DIR ios)
    ELSE ()
        SET(EXT_DIR mac_x64)
    ENDIF ()
ELSE ()
    IF (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64")
        SET(EXT_DIR ubt22_x64)
    ELSEIF (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
        SET(EXT_DIR ubt22_aarch64)
    ELSE ()
        MESSAGE(FATAL_ERROR not support ${CMAKE_SYSTEM_PROCESSOR})
    ENDIF ()
ENDIF ()
SET(MBEDTLS_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/include)
SET(MBEDTLS_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/libmbedtls.a)
SET(MBEDX509_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/libmbedx509.a)
SET(MBEDCRYPTO_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/libmbedcrypto.a)
IF (WIN32)
    SET(MBEDTLS_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/mbedtls.lib)
    SET(MBEDX509_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/mbedx509.lib)
    SET(MBEDCRYPTO_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/mbedcrypto.lib)
ENDIF ()
SET(MBEDTLS_LIBRARIES "${MBEDTLS_LIBRARY}" "${MBEDX509_LIBRARY}" "${MBEDCRYPTO_LIBRARY}")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(MbedTLS DEFAULT_MSG
                                  MBEDTLS_INCLUDE_DIRS MBEDTLS_LIBRARY MBEDX509_LIBRARY MBEDCRYPTO_LIBRARY)

MARK_AS_ADVANCED(MBEDTLS_INCLUDE_DIRS MBEDTLS_LIBRARY MBEDX509_LIBRARY MBEDCRYPTO_LIBRARY)
