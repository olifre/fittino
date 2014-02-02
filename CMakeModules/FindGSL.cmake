# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindGSL.cmake                                                    #
#                                                                              #
# Description This macro tries to find a local GSL installation.               #
#                                                                              #
# Authors     Bjoern Sarrazin    <sarrazin@physik.uni-bonn.de>                 #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE( FindPackageHandleStandardArgs )

FIND_PROGRAM( GSL_CONFIG_EXECUTABLE gsl-config PATHS ${GSL_CONFIG_DIR} )

IF( GSL_CONFIG_EXECUTABLE )

    EXECUTE_PROCESS( COMMAND ${GSL_CONFIG_EXECUTABLE} --version OUTPUT_VARIABLE GSL_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${GSL_CONFIG_EXECUTABLE} --prefix  OUTPUT_VARIABLE GSL_PREFIX  OUTPUT_STRIP_TRAILING_WHITESPACE )
    # EXECUTE_PROCESS( COMMAND ${GSL_CONFIG_EXECUTABLE} --cflags  OUTPUT_VARIABLE GSL_CFLAGS  OUTPUT_STRIP_TRAILING_WHITESPACE )
    # EXECUTE_PROCESS( COMMAND ${GSL_CONFIG_EXECUTABLE} --libs    OUTPUT_VARIABLE GSL_LIBS    OUTPUT_STRIP_TRAILING_WHITESPACE )

    FIND_PATH(GSL_INCLUDE_DIR gsl/gsl_math.h PATHS ${GSL_PREFIX}/include NO_DEFAULT_PATH)

    FIND_LIBRARY( GSL_LIBRARY Names gsl PATHS ${GSL_PREFIX}/lib ${GSL_PREFIX}/lib64 NO_DEFAULT_PATH )
    FIND_LIBRARY( GSL_CBLAS_LIBRARY Names gsl PATHS ${GSL_PREFIX}/lib ${GSL_PREFIX}/lib64 NO_DEFAULT_PATH )

    SET( GSL_VERSION_STRING "${GSL_VERSION}" ) 
    SET( GSL_LIBRARIES ${GSL_LIBRARY} ${GSL_CBLAS_LIBRARY} )
    SET( GSL_INCLUDE_DIRS ${GSL_INCLUDE_DIR} )
    # SET( GSL_COMPILE_FLAGS  "${GSL_CFLAGS}"  )
    # SET( GSL_LINK_FLAGS     "${GSL_LIBS}"    )


ENDIF()

FIND_PACKAGE_HANDLE_STANDARD_ARGS( GSL REQUIRED_VARS GSL_CONFIG_EXECUTABLE GSL_INCLUDE_DIRS GSL_LIBRARY GSL_CBLAS_LIBRARY VERSION_VAR GSL_VERSION_STRING )

