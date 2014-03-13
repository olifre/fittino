# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindMICROMEGAS.cmake                                             #
#                                                                              #
# Description This macro tries to find a local micrOMEGAs installation.        #
#                                                                              #
# Authors     Bjoern   Sarrazin    <sarrazin@physik.uni-bonn.de>               #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

INCLUDE( FindPackageHandleStandardArgs )

IF( NOT MICROMEGAS_ROOT_DIR )

    FIND_PATH( MICROMEGAS_ROOT_DIR sources/micromegas.h )

ENDIF()    

FIND_LIBRARY( MICROMEGAS_LIBRARY                   NAMES micromegas   HINTS ${MICROMEGAS_ROOT_DIR}/sources         NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_MSSM_WORKAUX_LIBRARY      NAMES work_aux     HINTS ${MICROMEGAS_ROOT_DIR}/MSSM/work       NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_MSSM_LIBRARY              NAMES aLib         HINTS ${MICROMEGAS_ROOT_DIR}/MSSM/lib        NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_SLHAPLUS_LIBRARY  NAMES SLHAplus     HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_SQMEAUX_LIBRARY   NAMES sqme_aux     HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_DYNAMICME_LIBRARY NAMES dynamic_me   HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_DYNAMICVP_LIBRARY NAMES dynamic_vp   HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_SYMB_LIBRARY      NAMES symb         HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_NUMC_LIBRARY      NAMES num_c        HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_NTOOLS_LIBRARY    NAMES ntools       HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )
FIND_LIBRARY( MICROMEGAS_CALCHEP_SERV_LIBRARY      NAMES serv         HINTS ${MICROMEGAS_ROOT_DIR}/CalcHEP_src/lib NO_DEFAULT_PATH )

SET( MICROMEGAS_LIBRARIES ${MICROMEGAS_LIBRARY}
                          ${MICROMEGAS_MSSM_WORKAUX_LIBRARY}
                          ${MICROMEGAS_MSSM_LIBRARY}
                          ${MICROMEGAS_CALCHEP_SLHAPLUS_LIBRARY}
                          ${MICROMEGAS_CALCHEP_DYNAMICME_LIBRARY}
                          ${MICROMEGAS_CALCHEP_DYNAMICVP_LIBRARY}
                          ${MICROMEGAS_CALCHEP_SYMB_LIBRARY}
                          ${MICROMEGAS_CALCHEP_NUMC_LIBRARY}
                          ${MICROMEGAS_CALCHEP_NTOOLS_LIBRARY}
                          ${MICROMEGAS_CALCHEP_SERV_LIBRARY} )

IF(     EXISTS ${MICROMEGAS_ROOT_DIR}/sources/micromegas.h
    AND EXISTS ${MICROMEGAS_ROOT_DIR}/sources/micromegas_aux.h
    AND EXISTS ${MICROMEGAS_ROOT_DIR}/MSSM/lib/pmodel.h  )

    SET( MICROMEGAS_INCLUDE_DIRS ${MICROMEGAS_ROOT_DIR}/sources ${MICROMEGAS_ROOT_DIR}/MSSM/lib )

ENDIF()

FIND_PACKAGE_HANDLE_STANDARD_ARGS( MICROMEGAS REQUIRED_VARS MICROMEGAS_INCLUDE_DIRS MICROMEGAS_LIBRARY MICROMEGAS_MSSM_WORKAUX_LIBRARY MICROMEGAS_MSSM_LIBRARY MICROMEGAS_CALCHEP_SLHAPLUS_LIBRARY MICROMEGAS_CALCHEP_SQMEAUX_LIBRARY MICROMEGAS_CALCHEP_DYNAMICME_LIBRARY MICROMEGAS_CALCHEP_DYNAMICVP_LIBRARY MICROMEGAS_CALCHEP_SYMB_LIBRARY MICROMEGAS_CALCHEP_NUMC_LIBRARY MICROMEGAS_CALCHEP_NTOOLS_LIBRARY MICROMEGAS_CALCHEP_SERV_LIBRARY )

