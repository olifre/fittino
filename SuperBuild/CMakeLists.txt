# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file                                         #
#                                                                              #
# Authors     Bjoern Sarrazin   <sarrazin@physik.uni-bonn.de                   #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
###############################################################################

CMAKE_MINIMUM_REQUIRED( VERSION 2.8.7 FATAL_ERROR )

PROJECT( Fittino_Superbuild CXX )
ENABLE_LANGUAGE( Fortran C )

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMakeModules)

SET(SuperIso_URL ~/superiso_v3.4.tar) # todo: improve this 

SET(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/Install  ) # todo: only if not defined

INCLUDE(GNUInstallDirs)
SET( BINDIR ${CMAKE_INSTALL_FULL_BINDIR} )
SET( DATADIR ${CMAKE_INSTALL_FULL_DATADIR} )
SET( LIBDIR ${CMAKE_INSTALL_FULL_LIBDIR} )
SET( INCLUDEDIR ${CMAKE_INSTALL_FULL_INCLUDEDIR} )
SET( LOCALSTATEDIR ${CMAKE_INSTALL_FULL_LOCALSTATEDIR} )
SET( InstallDirs -DDATADIR=${DATADIR} -DBINDIR=${BINDIR} -DLIBDIR=${LIBDIR} ) 

SET_PROPERTY( DIRECTORY PROPERTY "EP_BASE" ${PROJECT_BINARY_DIR}  )

OPTION( INSTALL_SLHAea "" OFF )
OPTION( INSTALL_SPheno "" OFF )
OPTION( INSTALL_HiggsSignals "" ON )
OPTION( INSTALL_SuperIso "" OFF )
OPTION( INSTALL_Fittino "" OFF )
OPTION( INSTALL_MicrOMEGAs "" OFF )
OPTION( INSTALL_FeynHiggs "" OFF )

SET(FITTINO_DEPENDENCIES)

INCLUDE(ExternalProject)

#FIND_PACKAGE(Boost 1.47.0 REQUIRED)
IF( INSTALL_SLHAea )	

  EXTERNALPROJECT_ADD(
    SLHAea
    PREFIX external/SLHAea
    GIT_REPOSITORY https://github.com/fthomas/slhaea
    GIT_TAG "v0.1"
    CONFIGURE_COMMAND ""
    UPDATE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
  )

  EXTERNALPROJECT_GET_PROPERTY(SLHAea SOURCE_DIR)
  SET(SLHAEA_INSTALLATION_PATH  ${SOURCE_DIR})

  LIST(APPEND FITTINO_DEPENDENCIES SLHAea)

ENDIF()

IF( INSTALL_SPheno )

EXTERNALPROJECT_ADD(
    SPheno 
    PREFIX external/SPheno
    URL http://www.hepforge.org/archive/spheno/SPheno-3.3.8.tar.gz
    UPDATE_COMMAND ""
    PATCH_COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_SPheno.cmake
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND $(MAKE) F90=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy lib/libSPheno.a ${CMAKE_INSTALL_FULL_LIBDIR}
    COMMAND ${CMAKE_COMMAND} -E copy bin/SPheno ${CMAKE_INSTALL_FULL_BINDIR}
    COMMAND ${CMAKE_COMMAND} -E copy_directory doc ${CMAKE_INSTALL_FULL_DATAROOTDIR}/doc/SPheno
    COMMAND ${CMAKE_COMMAND} -E copy_directory input ${CMAKE_INSTALL_FULL_DATADIR}/SPheno/input
)  

ENDIF()

IF(INSTALL_HiggsSignals)

    EXTERNALPROJECT_ADD(
        HiggsBounds_LEP-chisq
        URL http://www.hepforge.org/archive/higgsbounds/csboutput_trans_binary.tar.gz
        BUILD_IN_SOURCE 1 # simplifies the INSTALL_COMMAND
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory . ${CMAKE_INSTALL_FULL_DATADIR}/HiggsBounds/csboutput_trans_binary 
        )
  
        EXTERNALPROJECT_ADD(
            HiggsBounds
            DEPENDS HiggsBounds_LEP-chisq
            URL http://www.hepforge.org/archive/higgsbounds/HiggsBounds-4.3.1.tar.gz
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ./configure-with-chisq
            PATCH_COMMAND ${CMAKE_COMMAND} ${InstallDirs} -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_HiggsBounds.cmake
            BUILD_COMMAND $(MAKE) F90C=gfortran
            INSTALL_COMMAND ${CMAKE_COMMAND} ${InstallDirs} -P ${CMAKE_CURRENT_SOURCE_DIR}/install_HiggsBounds.cmake
           ) 
    
        EXTERNALPROJECT_ADD(
            HiggsSignals
            DEPENDS HiggsBounds
            URL http://www.hepforge.org/archive/higgsbounds/HiggsSignals-1.4.0.tar.gz
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ./configure
            PATCH_COMMAND ${CMAKE_COMMAND} ${InstallDirs} -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_HiggsSignals.cmake
            BUILD_COMMAND $(MAKE) F90C=gfortran HBLIBS=-L${CMAKE_INSTALL_FULL_LIBDIR} HBINCLUDE=-I${LIBDIR}/fortran/HiggsBounds
            INSTALL_COMMAND ${CMAKE_COMMAND} ${InstallDirs} -P ${CMAKE_CURRENT_SOURCE_DIR}/install_HiggsSignals.cmake 
            )


ENDIF()

IF(INSTALL_SuperIso)
        EXTERNALPROJECT_ADD(
            SuperIso
            PREFIX external/SuperIso
            URL ${SuperIso_URL}
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND "" 
            BUILD_COMMAND $(MAKE) CC=${CMAKE_C_COMPILER}
            COMMAND $(MAKE) slha CC=${CMAKE_C_COMPILER}
            INSTALL_COMMAND ${CMAKE_COMMAND} -E copy src/libisospin.a ${CMAKE_INSTALL_FULL_LIBDIR}/libisospin.a
            COMMAND ${CMAKE_COMMAND} -E copy src/include.h ${CMAKE_INSTALL_FULL_INCLUDEDIR}/SuperIso/include.h
            COMMAND ${CMAKE_COMMAND} -E copy slha.x ${CMAKE_INSTALL_FULL_BINDIR}/slha.x
           ) 
   ENDIF()


   IF(INSTALL_MicrOMEGAs)
        EXTERNALPROJECT_ADD(
            MicrOMEGAs
            BINARY_DIR ${LOCALSTATEDIR}/MicrOMEGAs
            URL https://lapth.cnrs.fr/micromegas/downloadarea/code/micromegas_4.2.5.tgz 
            PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory . ${CMAKE_INSTALL_FULL_LOCALSTATEDIR}/MicrOMEGAs 
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_FORTRAN_COMPILER}
            COMMAND ${CMAKE_COMMAND} -E chdir MSSM $(MAKE) main=main.cpp 
            INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
            INSTALL_COMMAND "" 
           ) 
   ENDIF()

   IF( INSTALL_FeynHiggs )
        EXTERNALPROJECT_ADD(
            FeynHiggs
            URL http://wwwth.mpp.mpg.de/members/heinemey/feynhiggs/newversion/FeynHiggs-2.11.3.tar.gz 
            BUILD_COMMAND $(MAKE) CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_FORTRAN_COMPILER}
           ) 
   ENDIF()

   
   IF(INSTALL_Fittino)

EXTERNALPROJECT_ADD(
  Fittino
  DEPENDS ${FITTINO_DEPENDENCIES}
  PREFIX "./fittino"
  SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
  BUILD_ALWAYS ON
  # BINARY_DIR ${CMAKE_CURRENTSOURCE_DIR}/build
  DOWNLOAD_COMMAND ""
  UPDATE_COMMAND ""
  CMAKE_ARGS -DSLHAEA_INSTALLATION_PATH=${SLHAEA_INSTALLATION_PATH} -DBOOST_ROOT=${BOOST_ROOT}
  )

ENDIF()
