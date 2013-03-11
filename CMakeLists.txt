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

# In CMAKE_MINIMUM_REQUIRED() the FATAL_ERROR option is accepted but ignored by CMake 2.6 and
# higher. It should be specified so CMake versions 2.4 and lower fail with an error instead of just
# a warning.

CMAKE_MINIMUM_REQUIRED(VERSION 2.8 FATAL_ERROR)

PROJECT(fittino)

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules)

# Specify the installation path of the executable "root-config". By default, it is assumed that the
# environment variable ROOTSYS is set and that the installation path is "ROOTSYS/bin".

# SET(ROOT_CONFIG_INSTALLATION_PATH <root-config/installation/path>)
FIND_PACKAGE(ROOT)

# Specify the installation path of "SLHAea". The default path is "../slhaea".

# SET(SLHAEA_INSTALLATION_PATH <slhaea/installation/path>)
FIND_PACKAGE(SLHAEA)

# Optional: Specify the installation path of the executable "SPheno". The default path is
# "../SPheno/bin".

# SET(SPHENO_INSTALLATION_PATH <spheno/installation/path>)
# FIND_PACKAGE(SPHENO)

ADD_SUBDIRECTORY(sources)
