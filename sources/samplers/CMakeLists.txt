# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the samplers directory.             #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../optimizers/include)
INCLUDE_DIRECTORIES(../calculators/include)
INCLUDE_DIRECTORIES(../datastorages/include)

AUX_SOURCE_DIRECTORY(src sources)

ADD_LIBRARY(samplers ${sources})
SET_TARGET_PROPERTIES(samplers PROPERTIES COMPILE_FLAGS ${ROOT_COMPILE_FLAGS})
