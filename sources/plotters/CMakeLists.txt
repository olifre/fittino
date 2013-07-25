# $Id: CMakeLists.txt 1280 2013-03-28 11:23:49Z uhlenbrock@PHYSIK.UNI-BONN.DE $ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the plotters directory.             #
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
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(../models/include)

AUX_SOURCE_DIRECTORY(src sources)

ADD_LIBRARY(plotters ${sources})
