# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindSPHENO.cmake                                                 #
#                                                                              #
# Description This macro tries to find a local SPHENO installation.            #
#             If successful, it adds SPHENO to Fittino as a cmake module.      #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

# The variable SPHENO_EXECUTABLE is set to "SPHENO_EXECUTABLE-NOTFOUND" which is the default value.

SET(SPHENO_EXECUTABLE "SPHENO_EXECUTABLE-NOTFOUND")

# Look for the location of the executable "SPheno".

FIND_PROGRAM(SPHENO_EXECUTABLE SPheno PATHS ${SPHENO_INSTALLATION_PATH} ../SPheno/bin)

IF(${SPHENO_EXECUTABLE} MATCHES "SPHENO_EXECUTABLE-NOTFOUND")

    # If the path to the SPheno installation is not found print this message.

    MESSAGE(WARNING "\nOptional module SPHENO not found.\nIf you want to use SPHENO, please specify the path to your SPheno installation in the file CMakeLists.txt in the Fittino root directory.\nContinuing with the cmake configuration.\n")

ELSE(${SPHENO_EXECUTABLE} MATCHES "SPHENO_EXECUTABLE-NOTFOUND")

    # If the path to the SPheno installation is found create a symbolic link to the executable and
    # print a message.

    EXECUTE_PROCESS(COMMAND ln -s ${SPHENO_INSTALLATION_PATH}/SPheno SPheno)
    MESSAGE(STATUS "SPheno version:")

ENDIF(${SPHENO_EXECUTABLE} MATCHES "SPHENO_EXECUTABLE-NOTFOUND")
