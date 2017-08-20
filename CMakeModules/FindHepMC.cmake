################################################################################S
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindHepMC.cmake                                                  #
#                                                                              #
# Description This macro tries to find a local HepMC installation.             #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE(FindPackageHandleStandardArgs)

FIND_PATH(HEPMC_INCLUDE_DIR NAMES HepMC/GenEvent.h HINTS ${HEPMC_ROOT_DIR}/include)
SET(HEPMC_INCLUDE_DIRS ${HEPMC_INCLUDE_DIR})

FIND_LIBRARY(HEPMC_LIBRARY NAMES HepMC HINTS ${HEPMC_ROOT_DIR}/lib )
SET(HEPMC_LIBRARIES ${HEPMC_LIBRARY})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(HepMC DEFAULT_MSG HEPMC_INCLUDE_DIRS HEPMC_LIBRARIES)
