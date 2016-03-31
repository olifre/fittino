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
################################################################################

CMAKE_MINIMUM_REQUIRED( VERSION 2.8.7 FATAL_ERROR )


PROJECT( Fittino_Superbuild CXX )
ENABLE_LANGUAGE( Fortran C )

SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMakeModules)

SET(SuperIso_URL ~/superiso_v3.4.tar) # todo: improve this 

SET_PROPERTY( DIRECTORY PROPERTY "EP_BASE" ${PROJECT_BINARY_DIR}  )
SET(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/Install  ) # todo: only if not defined

OPTION( BUILTIN_SLHAEA "" OFF )
OPTION( BUILTIN_SPHENO "" OFF )
OPTION( BUILTIN_HIGGSSIGNALS "" OFF )
OPTION( BUILTIN_SuperIso "" OFF )
OPTION( BUILD_FITTINO "" OFF )
OPTION( BUILTIN_MicrOMEGAs "" ON )

SET(FITTINO_DEPENDENCIES)

INCLUDE(GNUInstallDirs)
INCLUDE(ExternalProject)

#FIND_PACKAGE(Boost 1.47.0 REQUIRED)

IF( BUILTIN_SLHAEA )	

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

IF( BUILTIN_SPHENO )

EXTERNALPROJECT_ADD(
    SPheno 
    PREFIX external/SPheno
    URL http://www.hepforge.org/archive/spheno/SPheno-3.3.8.tar.gz
    UPDATE_COMMAND ""
    PATCH_COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_SPheno.cmake
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND $(MAKE) F90=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy lib/libSPheno.a ${CMAKE_INSTALL_FULL_LIBDIR}/libSPheno.a
    COMMAND ${CMAKE_COMMAND} -E copy bin/SPheno ${CMAKE_INSTALL_FULL_BINDIR}/SPheno
    COMMAND ${CMAKE_COMMAND} -E copy_directory doc ${CMAKE_INSTALL_FULL_DATAROOTDIR}/doc/SPheno
    COMMAND ${CMAKE_COMMAND} -E copy_directory input ${CMAKE_INSTALL_FULL_DATADIR}/SPheno/input
)  

ENDIF()

IF(BUILTIN_HIGGSSIGNALS)

    EXTERNALPROJECT_ADD(
        HiggsBounds_LEP-chisq
        PREFIX external/HiggsBounds_LEP-chisq
        URL http://www.hepforge.org/archive/higgsbounds/csboutput_trans_binary.tar.gz
        BUILD_IN_SOURCE 1 # simplifies the INSTALL_COMMAND
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory . ${CMAKE_INSTALL_FULL_DATADIR}/HiggsBounds/csboutput_trans_binary 
        )
  
        EXTERNALPROJECT_ADD(
            HiggsBounds
            DEPENDS HiggsBounds_LEP-chisq
            PREFIX external/HiggsBounds
            URL http://www.hepforge.org/archive/higgsbounds/HiggsBounds-4.3.1.tar.gz
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ./configure-with-chisq
            PATCH_COMMAND ${CMAKE_COMMAND} -DHiggsBounds_DATADIR=${CMAKE_INSTALL_FULL_DATADIR}/HiggsBounds -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_HiggsBounds.cmake
            BUILD_COMMAND $(MAKE) F90C=gfortran
            INSTALL_COMMAND ${CMAKE_COMMAND} -E copy libHB.a ${CMAKE_INSTALL_FULL_LIBDIR}/libHB.a
            COMMAND ${CMAKE_COMMAND} -E copy HiggsBounds ${CMAKE_INSTALL_FULL_BINDIR}/HiggsBounds
            COMMAND ${CMAKE_COMMAND} -E copy_directory Expt_tables ${CMAKE_INSTALL_FULL_DATADIR}/HiggsBounds/Expt_tables
           ) 
    #
    #    EXTERNALPROJECT_ADD(
    #        HiggsSignals
    #        DEPENDS HiggsBounds
    #        PREFIX "external/HiggsSignals"
    #        URL http://www.hepforge.org/archive/higgsbounds/HiggsSignals-1.4.0.tar.gz
    #        BUILD_IN_SOURCE 1
    #        CONFIGURE_COMMAND ./configure
    #        BUILD_COMMAND $(MAKE) F90C=${CMAKE_Fortran_COMPILER} 
    #        INSTALL_COMMAND ""
    #        )


ENDIF()

IF(BUILTIN_SuperIso)
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


   IF(BUILTIN_MicrOMEGAs)
        EXTERNALPROJECT_ADD(
            MicrOMEGAs
            BINARY_DIR ${CMAKE_INSTALL_FULL_LOCALSTATEDIR}/MicrOMEGAs
            URL https://lapth.cnrs.fr/micromegas/downloadarea/code/micromegas_4.2.5.tgz 
            PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory . ${CMAKE_INSTALL_FULL_LOCALSTATEDIR}/MicrOMEGAs 
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_FORTRAN_COMPILER}
            COMMAND ${CMAKE_COMMAND} -E chdir MSSM $(MAKE) main=main.cpp 
            INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
            INSTALL_COMMAND "" 
           ) 
   ENDIF()

   
IF(BUILD_FITTINO)

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
