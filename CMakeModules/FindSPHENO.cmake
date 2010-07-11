# $Id: FindSPHENO.cmake 669 2010-06-25 09:41:37Z uhlenbrock $ #

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

# Specify the installation path of the executable "SPheno".

SET(SPHENO_PATH ../SPheno3.0.beta50/bin)

# Look for the executable "SPheno" in the specified path. If the executable is not found there, the
# variable SPHENO_EXECUTABLE is set to "SPHENO_EXECUTABLE-NOTFOUND" which is the default value.

SET(SPHENO_EXECUTABLE "SPHENO_EXECUTABLE-NOTFOUND")

FIND_PROGRAM(SPHENO_EXECUTABLE SPheno PATHS ${SPHENO_PATH} NO_DEFAULT_PATH)

IF(${SPHENO_EXECUTABLE} MATCHES "SPHENO_EXECUTABLE-NOTFOUND")

    MESSAGE(FATAL_ERROR "\nModule SPHENO not found.\nPlease add the path to your SPHENO installation to the macro FindSPHENO.cmake in the subdirectory CMakeModules.\n") 

ELSE(${SPHENO_EXECUTABLE} MATCHES "SPHENO_EXECUTABLE-NOTFOUND")

    MESSAGE(STATUS "Module SPHENO found")

ENDIF(${SPHENO_EXECUTABLE} MATCHES "SPHENO_EXECUTABLE-NOTFOUND")
