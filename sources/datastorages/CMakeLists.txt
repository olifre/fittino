# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the datastorages directory.         #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../optimizers/include)
INCLUDE_DIRECTORIES(../samplers/include)
INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})

FILE( GLOB includes ./include/*.h )
AUX_SOURCE_DIRECTORY(src sources)

IF(SLHAEA_FOUND)
  INCLUDE_DIRECTORIES(${SLHAEA_INCLUDE_DIR})
ELSE()
  LIST(REMOVE_ITEM sources "src/SLHAeaSLHADataStorage.cpp")
ENDIF()

ADD_LIBRARY(datastorages ${includes} ${sources})

