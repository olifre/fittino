# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindROOT.cmake                                                   #
#                                                                              #
# Description This macro tries to find a local ROOT installation.              #
#             If successful, it adds ROOT to Fittino as a cmake module.        #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

# Requires at least ROOT version 5.20/00.

SET(ROOT_MIN_VERSION "5.20/00")

# The variable ROOT_CONFIG_EXECUTABLE is set to "ROOT_CONFIG_EXECUTABLE-NOTFOUND" which is the
# default value.

SET(ROOT_CONFIG_EXECUTABLE "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

# Look for the executable "root-config".

FIND_PROGRAM(ROOT_CONFIG_EXECUTABLE root-config PATHS ${ROOT_CONFIG_INSTALLATION_PATH} $ENV{ROOTSYS}/bin)

IF(${ROOT_CONFIG_EXECUTABLE} MATCHES "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

    # If the executable "root-config" is not found print this message.

    MESSAGE(FATAL_ERROR "\nRequired module ROOT not found.\nPlease set ROOTSYS or specify the path to your ROOT installation in the file CMakeLists.txt in the Fittino root directory.\n")

ELSE(${ROOT_CONFIG_EXECUTABLE} MATCHES "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

    # If the executable "root-config" is found, check version number.

    EXECUTE_PROCESS(COMMAND root-config --version OUTPUT_VARIABLE ROOT_FOUND_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)

    # Decompose minimal ROOT version into major, minor and patch numbers.

    STRING(REGEX REPLACE "^([0-9]+)\\.[0-9][0-9]+\\/[0-9][0-9]+" "\\1" ROOT_MIN_VERSION_MAJOR "${ROOT_MIN_VERSION}")
    STRING(REGEX REPLACE "^[0-9]+\\.([0-9][0-9])+\\/[0-9][0-9]+.*" "\\1" ROOT_MIN_VERSION_MINOR "${ROOT_MIN_VERSION}")
    STRING(REGEX REPLACE "^[0-9]+\\.[0-9][0-9]+\\/([0-9][0-9]+)" "\\1" ROOT_MIN_VERSION_PATCH "${ROOT_MIN_VERSION}")

    # Decompose found ROOT version into major, minor and patch numbers.

    STRING(REGEX REPLACE "^([0-9]+)\\.[0-9][0-9]+\\/[0-9][0-9]+" "\\1" ROOT_FOUND_VERSION_MAJOR "${ROOT_FOUND_VERSION}")
    STRING(REGEX REPLACE "^[0-9]+\\.([0-9][0-9])+\\/[0-9][0-9]+.*" "\\1" ROOT_FOUND_VERSION_MINOR "${ROOT_FOUND_VERSION}")
    STRING(REGEX REPLACE "^[0-9]+\\.[0-9][0-9]+\\/([0-9][0-9]+)" "\\1" ROOT_FOUND_VERSION_PATCH "${ROOT_FOUND_VERSION}")

    # Translate version numbers into single (easily comparable) numbers.

    MATH(EXPR MIN_VERSION "${ROOT_MIN_VERSION_MAJOR}*10000 + ${ROOT_MIN_VERSION_MINOR}*100 + ${ROOT_MIN_VERSION_PATCH}")
    MATH(EXPR FOUND_VERSION "${ROOT_FOUND_VERSION_MAJOR}*10000 + ${ROOT_FOUND_VERSION_MINOR}*100 + ${ROOT_FOUND_VERSION_PATCH}")

    IF(FOUND_VERSION LESS MIN_VERSION)

        MESSAGE(FATAL_ERROR "\nROOT version too old. At least ${ROOT_MIN_VERSION} needed.\n")

    ELSE(FOUND_VERSION LESS MIN_VERSION)

        MESSAGE(STATUS "ROOT version: ${ROOT_FOUND_VERSION}")

    ENDIF(FOUND_VERSION LESS MIN_VERSION)

    # Look for needed libraries and make them accessible via the ROOT_LIBRARIES cache entry.

    EXECUTE_PROCESS(COMMAND root-config --libdir OUTPUT_VARIABLE ROOT_LIBRARY_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND root-config --libs OUTPUT_VARIABLE ROOT_STANDARD_LIBRARIES OUTPUT_STRIP_TRAILING_WHITESPACE)

    FIND_LIBRARY(ROOT_XMLPARSER_LIBRARY NAMES XMLParser PATHS ${ROOT_LIBRARY_PATH} NO_DEFAULT_PATH)
    FIND_LIBRARY(ROOT_MINUIT2_LIBRARY NAMES Minuit2 PATHS ${ROOT_LIBRARY_PATH} NO_DEFAULT_PATH)

    SET(ROOT_LIBRARIES ${ROOT_STANDARD_LIBRARIES} ${ROOT_XMLPARSER_LIBRARY} ${ROOT_MINUIT2_LIBRARY})

ENDIF(${ROOT_CONFIG_EXECUTABLE} MATCHES "ROOT_CONFIG_EXECUTABLE-NOTFOUND")
