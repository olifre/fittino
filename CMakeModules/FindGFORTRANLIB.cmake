# $Id: FindFEYNHIGGS.cmake 1549 2013-08-29 19:01:57Z sarrazin $ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindGFORTRANLIB.cmake                                            #
#                                                                              #
# Description This macro tries to find gfortran library                        #
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

FIND_LIBRARY(GFORTRAN_LIBRARY NAMES gfortran PATHS ${GFORTRAN_LIBRARY_DIR})

SET(GFORTRAN_LIBRARIES ${GFORTRAN_LIBRARY})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(GFORTRANLIB REQUIRED_VARS GFORTRAN_LIBRARIES)


