# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindFORTRANFLUSH.cmake                                           #
#                                                                              #
# Description This macro tries to find fortranflush                            #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#             published by the Free Software Foundation; either version 3 of   #
#             the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_LIBRARY( FORTRANFLUSH_LIBRARY NAMES fortranflush )
SET( FORTRANFLUSH_LIBRARIES ${FORTRANFLUSH_LIBRARY} )

FIND_PACKAGE_HANDLE_STANDARD_ARGS( FORTRANFLUSH REQUIRED_VARS FORTRANFLUSH_LIBRARY )


