# $Id: FindFEYNHIGGS.cmake 1549 2013-08-29 19:01:57Z sarrazin $ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindGFORTRANEXE.cmake                                            #
#                                                                              #
# Description This macro tries to find gfortran executable                     #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_PROGRAM(GFORTRAN_EXECUTABLE gfortran PATHS ${GFORTRAN_EXECUTABLE_DIR})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(GFORTRANEXE REQUIRED_VARS GFORTRAN_EXECUTABLE)

