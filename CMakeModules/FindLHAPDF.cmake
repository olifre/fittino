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
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

# The variable LHAPDF_INCLUDE_DIR is set to "LHAPDF_INCLUDE_DIR-NOTFOUND" which is the default
# value.

SET(LHAPDF_INCLUDE_DIR "LHAPDF_INCLUDE_DIR-NOTFOUND")

# Look for the location of the file "slhaea.h".

FIND_PATH(LHAPDF_INCLUDE_DIR LHAPDF/LHAPDF.h PATHS ${LHAPDF_INSTALLATION_PATH}/include ../lhapdf/include)

IF(${LHAPDF_INCLUDE_DIR} MATCHES "LHAPDF_INCLUDE_DIR-NOTFOUND")

    # If the path to the LHAPDF installation is not found print this message.

    MESSAGE(FATAL_ERROR "\nRequired module LHAPDF not found.\nPlease specify the path to your LHAPDF installation in the file CMakeLists.txt in the Fittino root directory.\n")

ELSE(${LHAPDF_INCLUDE_DIR} MATCHES "LHAPDF_INCLUDE_DIR-NOTFOUND")

    # The following command extracts the LHAPDF version number as the first 5
    # characters in the 5. line of the file ChangeLog located in the LHAPDF
    # installation path.
    # TODO: Make this command more flexible. 

    EXECUTE_PROCESS(COMMAND sed -n 5p ${LHAPDF_INSTALLATION_PATH}/ChangeLog COMMAND cut -c 1-5 OUTPUT_VARIABLE LHAPDF_FOUND_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)

    # If the path to the LHAPDF installation is found print this message.

    MESSAGE(STATUS "LHAPDF version: " ${LHAPDF_FOUND_VERSION})

ENDIF(${LHAPDF_INCLUDE_DIR} MATCHES "LHAPDF_INCLUDE_DIR-NOTFOUND")
