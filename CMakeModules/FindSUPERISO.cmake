# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindSUPERISO.cmake                                               #
#                                                                              #
# Description This macro tries to find a local LHAPDF installation.            #
#             If successful, it adds LHAPDF to Fittino as a cmake module.      #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE( FindPackageHandleStandardArgs )

FIND_LIBRARY( SUPERISO_LIBRARY NAMES isospin PATHS ${SUPERISO_ROOT_DIR}/src )
SET( SUPERISO_LIBRARIES ${SUPERISO_LIBRARY} )

FIND_PATH( SUPERISO_INCLUDE_DIR NAMES include.h PATHS ${SUPERISO_ROOT_DIR}/src )
SET( SUPERISO_INCLUDE_DIRS ${SUPERISO_INCLUDE_DIR} )

FIND_PACKAGE_HANDLE_STANDARD_ARGS( SUPERISO REQUIRED_VARS SUPERISO_LIBRARY SUPERISO_INCLUDE_DIR )
