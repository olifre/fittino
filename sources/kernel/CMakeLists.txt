# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the kernel directory.               #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

ADD_DEFINITIONS(`root-config --cflags`)

INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../interpreters/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../optimizers/include)
INCLUDE_DIRECTORIES(../samplers/include)
#INCLUDE_DIRECTORIES(${SLHAEA_INCLUDE_DIR})

AUX_SOURCE_DIRECTORY(./src sources)

ADD_EXECUTABLE(fittino ${sources})

TARGET_LINK_LIBRARIES(fittino exceptions)
TARGET_LINK_LIBRARIES(fittino interpreters)
TARGET_LINK_LIBRARIES(fittino models)
TARGET_LINK_LIBRARIES(fittino optimizers)
TARGET_LINK_LIBRARIES(fittino samplers)
