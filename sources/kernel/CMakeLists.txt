# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the kernel directory.               #
#                                                                              #
# Authors     Bjoern Sarrazin     <sarrazin@physik.uni-bonn.de>                #
#             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

IF(LHAPDF_FOUND)
  ADD_DEFINITIONS(-DLHAPDF_FOUND)
ENDIF(LHAPDF_FOUND)
ADD_DEFINITIONS(`root-config --cflags`)

INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../calculators/include)
INCLUDE_DIRECTORIES(../datastorages/include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../optimizers/include)
INCLUDE_DIRECTORIES(../samplers/include)

AUX_SOURCE_DIRECTORY(./src sources)

ADD_EXECUTABLE(fittino ${sources})

TARGET_LINK_LIBRARIES(fittino models)
TARGET_LINK_LIBRARIES(fittino calculators)
TARGET_LINK_LIBRARIES(fittino optimizers)
TARGET_LINK_LIBRARIES(fittino samplers)
TARGET_LINK_LIBRARIES(fittino datastorages)
TARGET_LINK_LIBRARIES(fittino exceptions)
TARGET_LINK_LIBRARIES(fittino ${ROOT_LIBRARIES})
#TARGET_LINK_LIBRARIES(fittino -lgfortran)
#TARGET_LINK_LIBRARIES(fittino ${HIGGSSIGNALS_LIBRARIES})
#TARGET_LINK_LIBRARIES(fittino ${HIGGSBOUNDS_LIBRARIES})
IF(LHAPDF_FOUND)
  TARGET_LINK_LIBRARIES(fittino HDim6)
  # TARGET_LINK_LIBRARIES(fittino -lm)
  # TARGET_LINK_LIBRARIES(fittino -lgslcblas)
  TARGET_LINK_LIBRARIES(fittino -lgsl)
  TARGET_LINK_LIBRARIES(fittino -lLHAPDF)
  # TARGET_LINK_LIBRARIES(fittino -lstdc++)
ENDIF(LHAPDF_FOUND)

INSTALL(TARGETS fittino DESTINATION bin)
