# $Id$ #
################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file                                         #
#                                                                              #
# Authors     Bjoern Sarrazin   <sarrazin@physik.uni-bonn.de                   #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)

PROJECT(FittinoSuperBuild)

SET(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMakeModules)

SET(FITTINO_DEPENDENCIES)

INCLUDE(ExternalProject)

FIND_PACKAGE(SLHAEA QUIET)

IF(NOT SLHAEA_FOUND)
  EXTERNALPROJECT_ADD(
    slhaea
    PREFIX "external/slhaea"
    GIT_REPOSITORY https://github.com/fthomas/slhaea
    GIT_TAG "v0.1" 
    INSTALL_COMMAND ""
    UPDATE_COMMAND ""
    )
  EXTERNALPROJECT_GET_PROPERTY(slhaea SOURCE_DIR)
  SET(SLHAEA_INSTALLATION_PATH  ${SOURCE_DIR})
  LIST(APPEND FITTINO_DEPENDENCIES slhaea)
ENDIF(NOT SLHAEA_FOUND)

EXTERNALPROJECT_ADD(
  fittino2
  DEPENDS ${FITTINO_DEPENDENCIES} 
  DOWNLOAD_COMMAND "" 
  UPDATE_COMMAND   "" 
  SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..    
  # BINARY_DIR ${CMAKE_CURRENTSOURCE_DIR}/build
  PREFIX "./fittino2"
  CMAKE_ARGS -DSLHAEA_INSTALLATION_PATH=${SLHAEA_INSTALLATION_PATH}
  )

# ExternalProject_Add_Step(fittino2 "forceconfigure"
#     COMMAND ${CMAKE_COMMAND} -E echo "Force configure of fittino2."
#     DEPENDEES update
#     DEPENDERS configure
#     ALWAYS 1) 

EXTERNALPROJECT_ADD_STEP(fittino2 "forcebuild"
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of fittino2."
    DEPENDEES configure
    DEPENDERS build
    ALWAYS 1)