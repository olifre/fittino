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

# Specify the minimum cmake version required. It is set to cmake version 2.6 because this is the
# default version currently installed at the National Analysis Facility (NAF) at Desy. Naturally,
# the trueness of this statement should be checked from time to time.
# Note: In CMAKE_MINIMUM_REQUIRED() the FATAL_ERROR option is accepted but ignored by CMake 2.6 and
# higher. It should be specified so CMake versions 2.4 and lower fail with an error instead of just
# a warning.

CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)

# Specify the name of the project.

PROJECT(fittino)

# Specify the installation directory for the fittino executable. After the installation a
# subdirectory called bin is created which contains the executable.

SET(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})

# Specify the installation path of "Boost" which is required by SLHAea. There is only need to change
# this when the installation path differs from the default.

# SET(BOOST_ROOT <boost/installation/path>)
FIND_PACKAGE(Boost REQUIRED)

# Specify user-defined modules required by Fittino.

SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules)

# Specify the installation path of the executable "root-config". By default, it is assumed that the
# environment variable ROOTSYS is set and that the installation path is "ROOTSYS/bin".

# SET(ROOT_CONFIG_INSTALLATION_PATH ROOTSYS/bin)
FIND_PACKAGE(ROOT)

# Specify the installation path of "SLHAea". The default path is "../slhaea".

SET(SLHAEA_INSTALLATION_PATH ~/Downloads/fthomas-slhaea-ae94569)
FIND_PACKAGE(SLHAEA)

# Optional: Specify the installation path of the executable "SPheno". The default path is
# "../SPheno/bin".

# SET(SPHENO_INSTALLATION_PATH <spheno/installation/path>)
# FIND_PACKAGE(SPHENO)

ADD_SUBDIRECTORY(sources)
