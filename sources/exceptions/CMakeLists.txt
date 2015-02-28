# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the exceptions directory.           #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#             published by the Free Software Foundation; either version 3 of   #
#             the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../kernel/include)

FILE( GLOB includes ./include/*.h )
#LIST( APPEND includes include/Error.h )
LIST( APPEND includes include/LogicException.h )


AUX_SOURCE_DIRECTORY(src sources)
LIST( APPEND sources "src/LogicException.cpp" )

ADD_LIBRARY(exceptions ${includes} ${sources})
