# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindSLHAEA.cmake                                                 #
#                                                                              #
# Description This macro tries to find a local SLHAEA installation.            #
#             If successful, it adds SLHAEA to Fittino as a cmake module.      #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

# The variable SLHAEA_INCLUDE_DIR is set to "SLHAEA_INCLUDE_DIR-NOTFOUND" which is the default
# value.

SET(SLHAEA_INCLUDE_DIR "SLHAEA_INCLUDE_DIR-NOTFOUND")

# Look for the location of the file "slhaea.h".

FIND_PATH(SLHAEA_INCLUDE_DIR slhaea.h PATHS ${SLHAEA_INSTALLATION_PATH} ../slhaea)

IF(${SLHAEA_INCLUDE_DIR} MATCHES "SLHAEA_INCLUDE_DIR-NOTFOUND")

    # If the path to the SLHAea installation is not found print this message.

    MESSAGE(FATAL_ERROR "\nRequired module SLHAEA not found.\nPlease specify the path to your SLHAea installation in the file CMakeLists.txt in the Fittino root directory.\n")

ELSE(${SLHAEA_INCLUDE_DIR} MATCHES "SLHAEA_INCLUDE_DIR-NOTFOUND")

    # If the path to the SLHAea installation is found print this message.

    MESSAGE(STATUS "SLHAea version:")

ENDIF(${SLHAEA_INCLUDE_DIR} MATCHES "SLHAEA_INCLUDE_DIR-NOTFOUND")
