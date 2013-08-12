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

# The variable HIGGSSIGNALS_LIBRARIES is set to "HIGGSSIGNALS_LIBRARIES-NOTFOUND" which is the default value.

SET(HIGGSSIGNALS_LIBRARIES "HIGGSSIGNALS_LIBRARIES-NOTFOUND")

# Look for the location of the HiggsSignals libraries.

FIND_LIBRARY(HIGGSSIGNALS_LIBRARY NAMES HS PATHS ${HIGGSSIGNALS_INSTALLATION_PATH} NO_DEFAULT_PATH)
SET(HIGGSSIGNALS_LIBRARIES ${HIGGSSIGNALS_LIBRARY})

IF(${HIGGSSIGNALS_LIBRARIES} MATCHES "HIGGSSIGNALS_LIBRARIES-NOTFOUND")

    # If the path to the HiggsSignals installation is not found print this message.

    MESSAGE(WARNING "\nOptional libraries for HiggsSignals not found.\nIf you want to use them, please specify the path to your HiggsSignals installation in the file CMakeLists.txt in the Fittino root directory.\nContinuing with the cmake configuration.\n")

ELSE(${HIGGSSIGNALS_LIBRARIES} MATCHES "HIGGSSIGNALS_LIBRARIES-NOTFOUND")

    # If the path to the HiggsSignals installation is found print this message.

    MESSAGE(STATUS "HiggsSignals found")

ENDIF(${HIGGSSIGNALS_LIBRARIES} MATCHES "HIGGSSIGNALS_LIBRARIES-NOTFOUND")

FIND_PACKAGE_HANDLE_STANDARD_ARGS(HIGGSSIGNALS DEFAULT_MSG HIGGSSIGNALS_LIBRARIES)
