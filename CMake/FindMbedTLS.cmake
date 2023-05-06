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
if (WIN32)
    set(EXT_DIR win_x64/release)
elseif (ANDROID)
    set(EXT_DIR android/${ANDROID_ABI})
elseif (APPLE)
    if (IOS)
        set(EXT_DIR ios)
    else ()
        set(EXT_DIR mac_x64)
    endif ()
else ()
    set(EXT_DIR ubt22_x64)
endif ()
set(MBEDTLS_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/include)
set(MBEDTLS_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/libmbedtls.a)
set(MBEDX509_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/libmbedx509.a)
set(MBEDCRYPTO_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/libmbedcrypto.a)
if (WIN32)
    set(MBEDTLS_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/mbedtls.lib)
    set(MBEDX509_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/mbedx509.lib)
    set(MBEDCRYPTO_LIBRARY ${CMAKE_SOURCE_DIR}/3rd/mbedtls-3.4.0/_bin/lib/${EXT_DIR}/mbedcrypto.lib)
endif ()
set(MBEDTLS_LIBRARIES "${MBEDTLS_LIBRARY}" "${MBEDX509_LIBRARY}" "${MBEDCRYPTO_LIBRARY}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MbedTLS DEFAULT_MSG
    MBEDTLS_INCLUDE_DIRS MBEDTLS_LIBRARY MBEDX509_LIBRARY MBEDCRYPTO_LIBRARY)

mark_as_advanced(MBEDTLS_INCLUDE_DIRS MBEDTLS_LIBRARY MBEDX509_LIBRARY MBEDCRYPTO_LIBRARY)
