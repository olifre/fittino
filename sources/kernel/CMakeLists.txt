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

IF(FEYNHIGGS_FOUND)
  ADD_DEFINITIONS(-DFEYNHIGGS)
ENDIF(FEYNHIGGS_FOUND)
IF(HIGGSBOUNDS_FOUND)
  ADD_DEFINITIONS(-DHIGGSBOUNDS_FOUND)
ENDIF(HIGGSBOUNDS_FOUND)
IF(HIGGSSIGNALS_FOUND)
  ADD_DEFINITIONS(-DHIGGSSIGNALS_FOUND)
ENDIF(HIGGSSIGNALS_FOUND)
IF(LHAPDF_FOUND)
  ADD_DEFINITIONS(-DLHAPDF_FOUND)
ENDIF(LHAPDF_FOUND)
IF(GSL_FOUND)
  ADD_DEFINITIONS(-DGSL)
ENDIF()

INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../calculators/include)
INCLUDE_DIRECTORIES(../datastorages/include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../optimizers/include)
INCLUDE_DIRECTORIES(../plotters/include)
INCLUDE_DIRECTORIES(../samplers/include)

AUX_SOURCE_DIRECTORY(./src sources)

ADD_EXECUTABLE(fittino ${sources})

SET_TARGET_PROPERTIES( fittino PROPERTIES COMPILE_FLAGS ${ROOT_COMPILE_FLAGS} LINK_FLAGS ${ROOT_LINK_FLAGS} )

TARGET_LINK_LIBRARIES(fittino models)
TARGET_LINK_LIBRARIES(fittino calculators)
TARGET_LINK_LIBRARIES(fittino optimizers)
TARGET_LINK_LIBRARIES(fittino plotters)
TARGET_LINK_LIBRARIES(fittino samplers)
TARGET_LINK_LIBRARIES(fittino datastorages)
TARGET_LINK_LIBRARIES(fittino exceptions)

IF(FEYNHIGGS_FOUND)
  TARGET_LINK_LIBRARIES(fittino ${FEYNHIGGS_LIBRARIES})
ENDIF(FEYNHIGGS_FOUND)
IF(HIGGSBOUNDS_FOUND)
  TARGET_LINK_LIBRARIES(fittino ${HIGGSBOUNDS_LIBRARIES})
ENDIF(HIGGSBOUNDS_FOUND)
IF(HIGGSSIGNALS_FOUND)
  TARGET_LINK_LIBRARIES(fittino ${HIGGSSIGNALS_LIBRARIES})
ENDIF(HIGGSSIGNALS_FOUND)
IF(LHAPDF_FOUND AND GSL_FOUND)
  TARGET_LINK_LIBRARIES(fittino HDim6)
  TARGET_LINK_LIBRARIES(fittino ${LHAPDF_LIBRARIES})
  SET_TARGET_PROPERTIES(fittino PROPERTIES LINK_FLAGS "${GSL_LINK_FLAGS} ${ROOT_LINK_FLAGS}" )
ENDIF()
TARGET_LINK_LIBRARIES(fittino -lgfortran)

IF(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
  target_link_libraries(fittino ${Boost_LIBRARIES})
ENDIF(Boost_FOUND)

INSTALL(TARGETS fittino DESTINATION bin)
