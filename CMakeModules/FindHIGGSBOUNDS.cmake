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

# The variable HIGGSBOUNDS_LIBRARIES is set to "HIGGSBOUNDS_LIBRARIES-NOTFOUND" which is the default value.

SET(HIGGSBOUNDS_LIBRARIES "HIGGSBOUNDS_LIBRARIES-NOTFOUND")

# Look for the location of the HiggsBounds libraries.

FIND_LIBRARY(HIGGSBOUNDS_LIBRARY NAMES HB PATHS ${HIGGSBOUNDS_INSTALLATION_PATH} NO_DEFAULT_PATH)
SET(HIGGSBOUNDS_LIBRARIES ${HIGGSBOUNDS_LIBRARY})

IF(${HIGGSBOUNDS_LIBRARIES} MATCHES "HIGGSBOUNDS_LIBRARIES-NOTFOUND")

    # If the path to the HiggsBounds installation is not found print this message.

    MESSAGE(WARNING "\nOptional libraries for HiggsBounds not found.\nIf you want to use them, please specify the path to your HiggsBounds installation in the file CMakeLists.txt in the Fittino root directory.\nContinuing with the cmake configuration.\n")

ELSE(${HIGGSBOUNDS_LIBRARIES} MATCHES "HIGGSBOUNDS_LIBRARIES-NOTFOUND")

    # If the path to the HiggsBounds installation is found print this message.

    MESSAGE(STATUS "HiggsBounds found")

ENDIF(${HIGGSBOUNDS_LIBRARIES} MATCHES "HIGGSBOUNDS_LIBRARIES-NOTFOUND")
