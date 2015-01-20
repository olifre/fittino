  # $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the calculators directory.          #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#             published by the Free Software Foundation; either version 3 of   #
#             the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

FILE(GLOB includes ./include/*.h)
AUX_SOURCE_DIRECTORY(src sources)

INCLUDE_DIRECTORIES(../../external)
INCLUDE_DIRECTORIES(./include)
INCLUDE_DIRECTORIES(../exceptions/include)
INCLUDE_DIRECTORIES(../datastorages/include)
INCLUDE_DIRECTORIES(../models/include)
INCLUDE_DIRECTORIES(../kernel/include)
INCLUDE_DIRECTORIES(../variables/include)
INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})

IF(FEYNHIGGS_FOUND)

    INCLUDE_DIRECTORIES(${FEYNHIGGS_INCLUDE_DIRS})

    IF(FEYNHIGGS_QUAD)

        ADD_DEFINITIONS(-DQUAD=1)

    ENDIF()

ELSE()

    LIST(REMOVE_ITEM sources "src/FeynHiggsBosonicChannel.cpp")
    LIST(REMOVE_ITEM sources "src/FeynHiggsCalculator.cpp")
    LIST(REMOVE_ITEM sources "src/FeynHiggsChannel.cpp")
    LIST(REMOVE_ITEM sources "src/FeynHiggsCrossSection.cpp")
    LIST(REMOVE_ITEM sources "src/FeynHiggsFermionicChannel.cpp")
    LIST(REMOVE_ITEM sources "src/FeynHiggsNeutralHiggsCrossSection.cpp")

ENDIF()

IF(NOT HIGGSBOUNDS_FOUND OR NOT HIGGSSIGNALS_FOUND)

    LIST(REMOVE_ITEM sources "src/HiggsSignalsHadXSCalculator.cpp")
    LIST(REMOVE_ITEM sources "src/NewHiggsSignalsHadXSCalculator.cpp")

ENDIF()

IF(NOT HIGGSBOUNDS_FOUND)

    LIST(REMOVE_ITEM sources "src/HiggsBoundsCalculator.cpp")
    LIST(REMOVE_ITEM sources "src/HiggsBoundsSLHACalculator.cpp")
    LIST(REMOVE_ITEM sources "src/HiggsBoundsHECCalculator.cpp")
    LIST(REMOVE_ITEM sources "src/HiggsBoundsHadXSCalculator.cpp")
    LIST(REMOVE_ITEM sources "src/FeynHiggsRescalingCalculator.cpp")

ENDIF()

IF(NOT MICROMEGAS_FOUND)

    LIST(REMOVE_ITEM sources "src/MicromegasCalculator.cpp")
    LIST(REMOVE_ITEM sources "src/MicromegasWrapper.cpp")
    
ENDIF()

IF(NOT SLHAEA_FOUND)

    LIST(REMOVE_ITEM sources "src/SPhenoSLHACalculator.cpp")

ENDIF()

IF(NOT HIGGSBOUNDS_FOUND OR NOT HIGGSSIGNALS_FOUND)

    LIST(REMOVE_ITEM sources "src/HiggsSignalsSLHACalculator.cpp")

ENDIF()

IF(NOT LHAPDF_FOUND OR NOT GSL_FOUND)

    LIST(REMOVE_ITEM sources "src/HDim6Calculator.cpp")

ENDIF()

IF(SUPERISO_FOUND)

    INCLUDE_DIRECTORIES(${SUPERISO_INCLUDE_DIRS})

ELSE()

    LIST(REMOVE_ITEM sources "src/SuperIsoCalculator.cpp")

ENDIF()

ADD_LIBRARY(calculators ${includes} ${sources})

GET_PROPERTY(compile_flags TARGET calculators PROPERTY COMPILE_FLAGS)

SET(compile_flags "${compile_flags} ${ROOT_COMPILE_FLAGS}")

IF(LHAPDF_FOUND)

    INCLUDE_DIRECTORIES(${LHAPDF_INCLUDE_DIRS})

ENDIF()

IF(GSL_FOUND)

    SET(compile_flags "${compile_flags} ${GSL_COMPILE_FLAGS}")

ENDIF()

IF(MICROMEGAS_FOUND)

  INCLUDE_DIRECTORIES(${MICROMEGAS_INCLUDE_DIRS})  

ENDIF()

SET_TARGET_PROPERTIES(calculators PROPERTIES COMPILE_FLAGS ${compile_flags})
