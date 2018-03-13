# $Id$ #

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

INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${ROOT_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../exceptions/include)

FILE( GLOB includes ./include/*.h )
AUX_SOURCE_DIRECTORY(src sources)

list( APPEND includes "include/Plotter.h" )
list( APPEND includes "include/Plot.h" )
list( APPEND includes "include/PlotData.h" )
list( APPEND includes "include/ScatterData.h" )



LIST( APPEND sources "src/ToyFitPlotter.cpp" )
LIST( APPEND sources "src/Plot.cpp" )
LIST( APPEND sources "src/Plotter.cpp" )
LIST( APPEND sources "src/PlotData.cpp" )
LIST( APPEND sources "src/ScatterData.cpp" )




ADD_LIBRARY(plotters ${includes} ${sources})
SET_TARGET_PROPERTIES(plotters PROPERTIES CXX_STANDARD 11 CXX_STANDARD_REQUIRED ON  )
