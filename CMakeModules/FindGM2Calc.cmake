
################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindGM2Calc.cmake                                                #
#                                                                              #
# Description This macro tries to find a local GM2Calc installation            #
#                                                                              #
# Authors     Bjoern   Sarrazin    <sarrazin@physik.uni-bonn.de>               #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	          published by the Free Software Foundation; either version 3 of   #
#	          the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE( FindPackageHandleStandardArgs )

FIND_PATH( GM2CALC_ROOT_DIR src/gm2calc.cpp )
FIND_PATH( GM2CALC_INCLUDE_DIR gm2calc.cpp HINTS ${GM2CALC_ROOT_DIR}/src )
FIND_LIBRARY( GM2CALC_LIBRARY NAMES gm2calc HINTS ${GM2CALC_ROOT_DIR}/src )

SET( GM2CALC_LIBRARIES ${GM2CALC_LIBRARY} )
SET( GM2CALC_INCLUDE_DIRS ${GM2CALC_INCLUDE_DIR} )

FIND_PACKAGE_HANDLE_STANDARD_ARGS( GM2CALC REQUIRED_VARS GM2CALC_LIBRARY GM2CALC_INCLUDE_DIR )
