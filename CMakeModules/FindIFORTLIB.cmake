# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindIFORT.cmake                                                  #
#                                                                              #
# Description This macro tries to find ifort libraries                         #
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

FIND_LIBRARY( IFORT_IFCORE_LIBRARY NAMES ifcore PATHS ${IFORT_LIBRARY_DIR} )
FIND_LIBRARY( IFORT_IFPORT_LIBRARY NAMES ifport PATHS ${IFORT_LIBRARY_DIR} )
FIND_LIBRARY( IFORT_SVML_LIBRARY   NAMES svml   PATHS ${IFORT_LIBRARY_DIR} )

SET( IFORT_LIBRARIES ${IFORT_IFCORE_LIBRARY} ${IFORT_IFPORT_LIBRARY} ${IFORT_SVML_LIBRARY} )

FIND_PACKAGE_HANDLE_STANDARD_ARGS(IFORTLIB REQUIRED_VARS IFORT_IFCORE_LIBRARY IFORT_IFPORT_LIBRARY IFORT_SVML_LIBRARY )


