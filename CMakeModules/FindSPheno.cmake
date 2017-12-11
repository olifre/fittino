# $Id: FindSPHENO.cmake 2790 2017-04-24 13:50:25Z sarrazin $ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindSPHENO.cmake                                                 #
#                                                                              #
# Description This macro tries to find a local SPHENO installation.            #
#             If successful, it adds SPHENO to Fittino as a cmake module.      #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of       #
#	      the License, or (at your option) any later version.                  #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_PROGRAM(SPheno_EXECUTABLE NAMES SPheno HINTS ${SPheno_ROOT_DIR}/bin )
FIND_PROGRAM(SPheno_MSSMTriLnV_EXECUTABLE NAMES SPhenoMSSMTriLnV HINTS ${SPheno_ROOT_DIR}/bin )

if( SPheno_MSSMTriLnV_EXECUTABLE )

    set( SPheno_MSSMTriLnV_FOUND TRUE )

else()

    set( SPheno_MSSMTriLnV_FOUND FALSE )

endif()

FIND_PACKAGE_HANDLE_STANDARD_ARGS( SPheno REQUIRED_VARS SPheno_EXECUTABLE HANDLE_COMPONENTS )



