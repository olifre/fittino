# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the interpreters directory.         #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

#ADD_DEFINITIONS(`root-config --cflags`)
ADD_DEFINITIONS(-pthread -m32 -I/afs/atlass01.physik.uni-bonn.de/i386_linux24/root/root-5.26.00_sid/root/include)

INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../optimizers/include)

AUX_SOURCE_DIRECTORY(src sources)

ADD_LIBRARY(interpreters ${sources})

#TARGET_LINK_LIBRARIES(interpreters `root-config --libs` -lXMLIO -lXMLParser)
TARGET_LINK_LIBRARIES(interpreters -L/afs/atlass01.physik.uni-bonn.de/i386_linux24/root/root-5.26.00_sid/root/lib -lCore -lCint -lHist -lGraf -lGraf3d -lGpad -lTree -lRint -lPostscript -lMatrix -lPhysics -pthread -lm -ldl -rdynamic -lXMLIO -lXMLParser)
#TARGET_LINK_LIBRARIES(interpreters -L/afs/atlass01.physik.uni-bonn.de/i386_linux24/root/root-5.26.00_sid/root/lib -lCore -lCint -lHist -lGraf -lGraf3d -lGpad -lTree -lRint -lPostscript -lMatrix -lPhysics -pthread -lm -ldl -rdynamic)
