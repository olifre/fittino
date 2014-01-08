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

INCLUDE(FindPackageHandleStandardArgs)

FIND_PROGRAM(LHAPDF_CONFIG_EXECUTABLE lhapdf-config PATHS ${LHAPDF_INSTALLATION_PATH}/bin)

IF(LHAPDF_CONFIG_EXECUTABLE) 

    EXECUTE_PROCESS(COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --incdir OUTPUT_VARIABLE LHAPDF_CONFIG_INCLUDE_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
    FIND_PATH(LHAPDF_INCLUDE_DIR NAMES LHAPDF/LHAPDF.h HINTS ${LHAPDF_CONFIG_INCLUDE_DIR} NO_DEFAULT_PATH)
    SET(LHAPDF_INCLUDE_DIRS ${LHAPDF_INCLUDE_DIR})

    EXECUTE_PROCESS(COMMAND ${LHAPDF_CONFIG_EXECUTABLE} --libdir OUTPUT_VARIABLE LHAPDF_CONFIG_LIBRARY_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
    FIND_LIBRARY(LHAPDF_LIBRARY NAMES LHAPDF PATHS ${LHAPDF_CONFIG_LIBRARY_DIR} NO_DEFAULT_PATH)
    SET(LHAPDF_LIBRARIES ${LHAPDF_LIBRARY})	

ELSE(LHAPDF_CONFIG_EXECUTABLE)

    MESSAGE(STATUS "lhapdf-config not found.")

ENDIF(LHAPDF_CONFIG_EXECUTABLE)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(LHAPDF DEFAULT_MSG LHAPDF_INCLUDE_DIRS LHAPDF_LIBRARIES)
