# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindHIGGSBOUNDS.cmake                                            #
#                                                                              #
# Description This macro tries to find the HiggsBounds installation path. If   #
#             successful, it adds the HiggsBounds libraries to Fittino as a    #
#             cmake module.                                                    #
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

FIND_LIBRARY(HIGGSBOUNDS_LIBRARY NAMES HB PATHS ${HIGGSBOUNDS_INSTALLATION_PATH})

SET(HIGGSBOUNDS_LIBRARIES ${HIGGSBOUNDS_LIBRARY})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(HIGGSBOUNDS DEFAULT_MSG HIGGSBOUNDS_LIBRARIES)
