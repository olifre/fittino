# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the main directory.                 #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

# In CMAKE_MINIMUM_REQUIRED() the FATAL_ERROR option is accepted but ignored
# by CMake 2.6 and higher. It should be specified so CMake versions 2.4 and
# lower fail with an error instead of just a warning.

CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)

PROJECT(fittino)

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules)

FIND_PACKAGE(ROOT)

ADD_SUBDIRECTORY(sources)
