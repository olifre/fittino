# $Id: FindLHAPDF.cmake 1280 2013-03-28 11:23:49Z uhlenbrock@PHYSIK.UNI-BONN.DE $ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindLHAPDF.cmake                                                 #
#                                                                              #
# Description This macro tries to find a local LHAPDF installation.            #
#             If successful, it adds LHAPDF to Fittino as a cmake module.      #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #    
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE( FindPackageHandleStandardArgs )

FIND_PROGRAM( LHAPDF_CONFIG_EXECUTABLE lhapdf-config PATHS ${LHAPDF_INSTALLATION_PATH}/bin )

IF( LHAPDF_CONFIG_EXECUTABLE ) 

    EXECUTE_PROCESS( COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --version  OUTPUT_VARIABLE LHAPDF_VERSION     OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --incdir   OUTPUT_VARIABLE LHAPDF_INCLUDE_DIR OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --libdir   OUTPUT_VARIABLE LHAPDF_LIBRARY_DIR OUTPUT_STRIP_TRAILING_WHITESPACE )
    # EXECUTE_PROCESS( COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --cppflags OUTPUT_VARIABLE LHAPDF_CPPFLAGS    OUTPUT_STRIP_TRAILING_WHITESPACE )
    # EXECUTE_PROCESS( COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --ldflags  OUTPUT_VARIABLE LHAPDF_LDFLAGS     OUTPUT_STRIP_TRAILING_WHITESPACE )


    FIND_LIBRARY( LHAPDF_LIBRARY Names LHAPDF PATHS ${LHAPDF_LIBRARY_DIR} NO_DEFAULT_PATH  )

    SET( LHAPDF_VERSION_STRING  ${LHAPDF_VERSION}     )
    SET( LHAPDF_INCLUDE_DIRS    ${LHAPDF_INCLUDE_DIR} )
    SET( LHAPDF_LIBRARIES       ${LHAPDF_LIBRARY}     )
    # SET( LHAPDF_COMPILE_FLAGS   ${LHAPDF_CPPFLAGS}    )	
    # SET( LHAPDF_LINK_FLAGS      ${LHAPDF_LDFLAGS}     )

ENDIF()

FIND_PACKAGE_HANDLE_STANDARD_ARGS( LHAPDF REQUIRED_VARS LHAPDF_CONFIG_EXECUTABLE LHAPDF_INCLUDE_DIRS LHAPDF_LIBRARIES VERSION_VAR LHAPDF_VERSION_STRING )
