# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindFEYNHIGGS.cmake                                              #
#                                                                              #
# Description This macro tries to find a local FEYNHIGGS installation.         #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_PATH(FEYNHIGGS_INCLUDE_DIR NAMES CFeynHiggs.h HINTS ${FEYNHIGGS_INSTALLATION_PATH})
SET(FEYNHIGGS_INCLUDE_DIRS ${FEYNHIGGS_INCLUDE_DIR})

FIND_LIBRARY(FEYNHIGGS_LIBRARY NAMES libFH.a HINTS ${FEYNHIGGS_INSTALLATION_PATH}/lib64)
SET(FEYNHIGGS_LIBRARIES ${FEYNHIGGS_LIBRARY})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(FEYNHIGGS DEFAULT_MSG FEYNHIGGS_INCLUDE_DIRS FEYNHIGGS_LIBRARIES)
