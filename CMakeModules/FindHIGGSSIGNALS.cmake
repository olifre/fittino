# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindHIGGSSIGNALS.cmake                                           #
#                                                                              #
# Description This macro tries to find the HiggsSignals installation path.     #
#             If successful, it adds the HiggsSignals libraries to Fittino     #
#             as a cmake module.                                               #
#                                                                              #
# Authors     Sebastian Heer  <s6seheer@uni-bonn.de>                           #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_LIBRARY(HIGGSSIGNALS_LIBRARY NAMES HS PATHS ${HIGGSSIGNALS_INSTALLATION_PATH})

SET(HIGGSSIGNALS_LIBRARIES ${HIGGSSIGNALS_LIBRARY})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(HIGGSSIGNALS DEFAULT_MSG HIGGSSIGNALS_LIBRARIES)
