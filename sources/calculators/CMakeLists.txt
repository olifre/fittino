# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the calculators directory.          #
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

INCLUDE_DIRECTORIES(../../external)
INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../datastorages/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})
INCLUDE_DIRECTORIES(${LHAPDF_INCLUDE_DIRS})

AUX_SOURCE_DIRECTORY(src sources)

IF(FEYNHIGGS_FOUND)
  INCLUDE_DIRECTORIES(${FEYNHIGGS_INCLUDE_DIRS})  
ELSE(FEYNHIGGS_FOUND)
  LIST(REMOVE_ITEM sources "src/FeynHiggsModelCalculator.cpp")
ENDIF(FEYNHIGGS_FOUND)

IF(NOT HIGGSBOUNDS_FOUND OR NOT HIGGSSIGNALS_FOUND)
  LIST(REMOVE_ITEM sources "src/HiggsSignalsSLHAModelCalculator.cpp")
  LIST(REMOVE_ITEM sources "src/HDim6ModelCalculator.cpp")
  LIST(REMOVE_ITEM sources "src/HiggsSignalsHadXSModelCalculator.cpp")
ENDIF(NOT HIGGSBOUNDS_FOUND OR NOT HIGGSSIGNALS_FOUND)
IF(NOT LHAPDF_FOUND OR NOT GSL_FOUND)
  LIST(REMOVE_ITEM sources "src/HDim6ModelCalculator.cpp")
ENDIF()



ADD_LIBRARY(calculators ${sources})
SET_TARGET_PROPERTIES(calculators PROPERTIES COMPILE_FLAGS ${ROOT_COMPILE_FLAGS})
