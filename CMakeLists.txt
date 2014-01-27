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
PROJECT(fittino CXX)

# Specify the installation directory for the fittino executable. After the installation a
# subdirectory called bin is created which contains the executable.
SET(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR})

# Specify the installation path of "Boost" which is required by SLHAea. There is only need to change
# this when the installation path differs from the default.
# SET(BOOST_ROOT <boost/installation/path>)
FIND_PACKAGE(Boost 1.47.0 COMPONENTS filesystem system REQUIRED)

# Specify user-defined modules required by Fittino.
SET(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMakeModules)

# Optional: Specify the installation path of "HiggsBounds".
# SET(HIGGSBOUNDS_INSTALLATION_PATH <higgsbounds/installation/path>)
FIND_PACKAGE(HIGGSBOUNDS)

# Optional: Specify the installation path of "HiggsSignals".
# SET(HIGGSSIGNALS_INSTALLATION_PATH <higgssignals/installation/path>)
FIND_PACKAGE(HIGGSSIGNALS)

# Specify the directory of the executable "root-config". By default, it is assumed that the
# environment variable ROOTSYS is set and that the directory is "ROOTSYS/bin/".
# SET(ROOT_CONFIG_DIR)
FIND_PACKAGE( ROOT 5.20.00 REQUIRED )

# Specify the installation path of "SLHAea". The default path is "../slhaea".
# SET(SLHAEA_INSTALLATION_PATH <slhaea/installation/path>)
FIND_PACKAGE(SLHAEA REQUIRED)

# Optional: Specify the installation path of the executable "SPheno". The default path is
# "../SPheno/bin".
# SET(SPHENO_INSTALLATION_PATH <spheno/installation/path>)
# FIND_PACKAGE(SPHENO)

# Optional: Specify the installation path of "LHAPDF".
# SET(LHAPDF_INSTALLATION_PATH <lhapdf/installation/path>)
FIND_PACKAGE(LHAPDF)

# Optional: Specify the installation path of "FeynHiggs".
# SET(FEYNHIGGS_INSTALLATION_PATH <lhapdf/installation/path>)
FIND_PACKAGE(FEYNHIGGS)

ADD_SUBDIRECTORY(external)
ADD_SUBDIRECTORY(sources)
