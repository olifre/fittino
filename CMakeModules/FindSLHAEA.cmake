# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindSLHAEA.cmake                                                 #
#                                                                              #
# Description This macro tries to find a local SLHAEA installation.            #
#             If successful, it adds SLHAEA to Fittino as a cmake module.      #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#             Bjoern Sarrazin     <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

include(FindPackageHandleStandardArgs)

FIND_PATH(SLHAEA_INCLUDE_DIR slhaea.h HINTS ${SLHAEA_INSTALLATION_PATH} PATHS ../slhaea)

set(SLHAEA_INCLUDE_DIRS ${SLHAEA_INCLUDE_DIR} )

find_package_handle_standard_args(SLHAEA REQUIRED_VARS SLHAEA_INCLUDE_DIR )


