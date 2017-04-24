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
#	      published by the Free Software Foundation; either version 3 of       #
#	      the License, or (at your option) any later version.                  #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_PROGRAM(SPHENO_EXECUTABLE SPheno HINTS ${SPHENO_INSTALLATION_PATH} )

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SPHENO DEFAULT_MSG SPHENO_EXECUTABLE )



