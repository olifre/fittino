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

CMAKE_MINIMUM_REQUIRED(VERSION 2.8.7 FATAL_ERROR)

PROJECT(fittino_superbuild)

SET(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMakeModules)

SET(FITTINO_DEPENDENCIES)

INCLUDE(ExternalProject)

FIND_PACKAGE(Boost 1.47.0 REQUIRED)

FIND_PACKAGE(SLHAEA QUIET)

IF(NOT SLHAEA_FOUND)

  EXTERNALPROJECT_ADD(
    slhaea
    PREFIX "external/slhaea"
    GIT_REPOSITORY https://github.com/fthomas/slhaea
    GIT_TAG "v0.1"
    UPDATE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    CMAKE_ARGS -DBOOST_ROOT=${BOOST_ROOT}
  )

  EXTERNALPROJECT_GET_PROPERTY(slhaea SOURCE_DIR)
  SET(SLHAEA_INSTALLATION_PATH  ${SOURCE_DIR})
  LIST(APPEND FITTINO_DEPENDENCIES slhaea)

ENDIF(NOT SLHAEA_FOUND)

EXTERNALPROJECT_ADD(
  fittino
  DEPENDS ${FITTINO_DEPENDENCIES}
  PREFIX "./fittino"
  SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
  # BINARY_DIR ${CMAKE_CURRENTSOURCE_DIR}/build
  DOWNLOAD_COMMAND ""
  UPDATE_COMMAND ""
  CMAKE_ARGS -DSLHAEA_INSTALLATION_PATH=${SLHAEA_INSTALLATION_PATH} -DBOOST_ROOT=${BOOST_ROOT}
  )

# ExternalProject_Add_Step(fittino "forceconfigure"
#     COMMAND ${CMAKE_COMMAND} -E echo "Force configure of fittino."
#     DEPENDEES update
#     DEPENDERS configure
#     ALWAYS 1)

EXTERNALPROJECT_ADD_STEP(fittino "forcebuild"
    COMMAND ${CMAKE_COMMAND} -E echo "Force build of fittino."
    DEPENDEES configure
    DEPENDERS build
    ALWAYS 1)
