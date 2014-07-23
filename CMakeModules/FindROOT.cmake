# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindROOT.cmake                                                   #
#                                                                              #
# Description This macro tries to find a local ROOT installation.              #
#             If successful, it adds ROOT to Fittino as a cmake module.        #
#                                                                              #
# Authors     Matthias Hamer       <mhamer@gwdg.de>                            #
#             Mathias  Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>             #
#             Bjoern   Sarrazin    <sarrazin@physik.uni-bonn.de>               #
#             Peter    Wienemann   <wienemann@physik.uni-bonn.de>              # 
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE( FindPackageHandleStandardArgs )

FIND_PROGRAM( ROOT_CONFIG_EXECUTABLE root-config PATHS ${ROOT_CONFIG_DIR} $ENV{ROOTSYS}/bin )

IF( ROOT_CONFIG_EXECUTABLE )

    EXECUTE_PROCESS( COMMAND ${ROOT_CONFIG_EXECUTABLE} --version OUTPUT_VARIABLE ROOT_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${ROOT_CONFIG_EXECUTABLE} --cflags  OUTPUT_VARIABLE ROOT_CFLAGS  OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${ROOT_CONFIG_EXECUTABLE} --ldflags OUTPUT_VARIABLE ROOT_LDFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${ROOT_CONFIG_EXECUTABLE} --libs    OUTPUT_VARIABLE ROOT_LIBS    OUTPUT_STRIP_TRAILING_WHITESPACE )
    EXECUTE_PROCESS( COMMAND ${ROOT_CONFIG_EXECUTABLE} --libdir  OUTPUT_VARIABLE ROOT_LIBDIR  OUTPUT_STRIP_TRAILING_WHITESPACE )

    FIND_LIBRARY( ROOT_FOAM_LIBRARY        NAMES Foam       PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_MINUIT_LIBRARY      NAMES Minuit     PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_MINUIT2_LIBRARY     NAMES Minuit2    PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_ROOFIT_LIBRARY      NAMES RooFit     PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_ROOFITCORE_LIBRARY  NAMES RooFitCore PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_MATHMORE_LIBRARY    NAMES MathMore   PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_TREEPLAYER_LIBRARY  NAMES TreePlayer PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_MLP_LIBRARY         NAMES MLP        PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )
    FIND_LIBRARY( ROOT_TMVA_LIBRARY        NAMES TMVA       PATHS ${ROOT_LIBDIR} NO_DEFAULT_PATH )

    STRING( REGEX REPLACE "^([0-9]+)\\.[0-9][0-9]+\\/[0-9][0-9]+"   "\\1" ROOT_VERSION_MAJOR "${ROOT_VERSION}" )
    STRING( REGEX REPLACE "^[0-9]+\\.([0-9][0-9])+\\/[0-9][0-9]+.*" "\\1" ROOT_VERSION_MINOR "${ROOT_VERSION}" )
    STRING( REGEX REPLACE "^[0-9]+\\.[0-9][0-9]+\\/([0-9][0-9]+)"   "\\1" ROOT_VERSION_PATCH "${ROOT_VERSION}" )

    SET( ROOT_VERSION_STRING "${ROOT_VERSION_MAJOR}.${ROOT_VERSION_MINOR}.${ROOT_VERSION_PATCH}" ) 
    SET( ROOT_COMPILE_FLAGS  "${ROOT_CFLAGS}" )
    SET( ROOT_LINK_FLAGS     "${ROOT_LIBS} -lFoam -lMinuit -lMinuit2 -lRooFit -lRooFitCore -lMathMore -lTreePlayer -lMLP -lTMVA ${ROOT_LDFLAGS}" )
    SET( ROOT_LIBRARY_DIRS   "${ROOT_LIBDIR}" )

ENDIF()

FIND_PACKAGE_HANDLE_STANDARD_ARGS( ROOT REQUIRED_VARS ROOT_CONFIG_EXECUTABLE ROOT_FOAM_LIBRARY ROOT_MINUIT_LIBRARY ROOT_MINUIT2_LIBRARY ROOT_ROOFIT_LIBRARY ROOT_ROOFITCORE_LIBRARY ROOT_MATHMORE_LIBRARY ROOT_TREEPLAYER_LIBRARY ROOT_MLP_LIBRARY ROOT_TMVA_LIBRARY VERSION_VAR ROOT_VERSION_STRING )
