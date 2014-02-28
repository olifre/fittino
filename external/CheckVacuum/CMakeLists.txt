# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the CheckVacuum directory.          #
#                                                                              #
# Authors     Bjoern Sarrazin <sarrazin@physik.uni-bonn.de>                    #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

FILE( GLOB includes includes *.h )

ADD_LIBRARY(checkvacuum ${includes} CheckVacuum.cpp)
SET_TARGET_PROPERTIES(checkvacuum PROPERTIES LINKER_LANGUAGE CXX)
