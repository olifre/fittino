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
#	          published by the Free Software Foundation; either version 3 of   #
#	          the License, or (at your option) any later version.              #
#                                                                              #
###############################################################################

# because of DOWNLOAD_NO_EXTRACT: https://cmake.org/cmake/help/v3.6/release/3.6.html?highlight=download_no_extract#modules
cmake_minimum_required( VERSION 3.6 FATAL_ERROR )

project( Fittino_Superbuild LANGUAGES CXX C Fortran )

set( CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMakeModules )

include( ExternalProject )

set_property( DIRECTORY PROPERTY "EP_BASE" ${PROJECT_BINARY_DIR} )

option( INSTALL_SLHAea       "" ON  )
option( INSTALL_SPheno       "" ON  )
option( INSTALL_FeynHiggs    "" OFF )
option( INSTALL_HiggsSignals "" OFF )
option( INSTALL_SuperIso     "" OFF )
option( INSTALL_LHAPDF       "" OFF )
option( INSTALL_MicrOMEGAs   "" OFF )
option( INSTALL_HepMC2       "" OFF )
option( INSTALL_Pythia8      "" OFF )
option( INSTALL_Minconda2    "" ON  )
option( INSTALL_MSSMTriLnV   "" OFF )
option( INSTALL_SModelS      "" ON  )
option( INSTALL_SCYNet       "" ON  )
option( INSTALL_CheckMATE    "" OFF )
option( INSTALL_Fittino      "" ON  )

# START CACHE VARIABLES

set( SuperIso_URL "~/Downloads/superiso_v3.4.tar" CACHE FILEPATH "" )

set( MSSMTriLnV_URL "~/Downloads/MSSMTriLnV.tgz" CACHE FILEPATH "" )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" )

    set( SModelS_URL "~/Downloads/smodels-v1.1.0patch1.tar" CACHE FILEPATH "" )
    set( SModelSFastlimDatabase_URL "~/Downloads/smodels-v1.1-fastlim-1.0.tar" CACHE FILEPATH "" )

else()

    set( SModelS_URL "~/Downloads/smodels-v1.1.0patch1.tgz" CACHE FILEPATH "" )
    set( SModelSFastlimDatabase_URL "~/Downloads/smodels-v1.1-fastlim-1.0.tgz" CACHE FILEPATH "" )

endif()

if( SModelS_URL MATCHES "\\.tar$" )

    set( SModelS_URL_MD5 396d3a28d1bebd1cbe3123100475108a CACHE STRING "" )

elseif( SModelS_URL MATCHES "\\.tgz$" )

    set( SModelS_URL_MD5 093757506db0823cf3ce13007720f79a CACHE STRING "" )

elseif( NOT DEFINED SModelS_URL_MD5 )

    message( WARNING "Unexpected extension of SModelS_URL and SModelS_URL_MD5 not defined." )

endif()

if( SModelSFastlimDatabase_URL MATCHES "\\.tar$" )

    set( SModelSFastlimDatabase_URL_MD5 5a67af22ee5a578038cd90409ed72e79 CACHE STRING "" )

elseif( SModelSFastlimDatabase_URL MATCHES "\\.tgz$" )

    set( SModelSFastlimDatabase_URL_MD5 55a2b8b7eeebd06b065315c8b2dc96d2 CACHE STRING "" )

elseif( NOT DEFINED SModelSFastlimDatabase_URL_MD5 )

    message( WARNING "Unexpected extension of SModelSFastlimDatabase_URL and SModelSFastlimDatabase_URL_MD5 not defined." )

endif()

# END CACHE VARIABLES

if( INSTALL_SLHAea OR INSTALL_SPheno OR INSTALL_MSSMTriLnV )

    set( slhaea SLHAea-0.1 )

    externalproject_add(

            ${slhaea}
            URL https://github.com/fthomas/slhaea/archive/v0.1.tar.gz
            URL_MD5 167da979fe62ebbfde09eabb28543cf9
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""

    )

    externalproject_get_property( ${slhaea} source_dir )
    set( SLHAEA_INSTALLATION_PATH ${source_dir} )

    list( APPEND fittino_dependencies ${slhaea} )

endif()

if( INSTALL_SPheno OR INSTALL_MSSMTriLnV )

    set( spheno SPheno-4.0.3 )

    externalproject_add(

            ${spheno}
            DEPENDS ${slhaea}
            URL http://www.hepforge.org/archive/spheno/SPheno-4.0.3.tar.gz
            URL_MD5 64787d6c8ce03cac38aec53d34ac46ad
            PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=src/Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_SPheno.cmake
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) F90=${CMAKE_Fortran_COMPILER}
            INSTALL_COMMAND ""

    )

    externalproject_get_property( ${spheno} source_dir )
    set( SPheno_ROOT_DIR ${source_dir} )

    list( APPEND fittino_dependencies ${spheno} )
    list( APPEND prefixPath ${SPheno_ROOT_DIR} )


endif()

if( INSTALL_MSSMTriLnV )

    set( mssmtrilnv mssmtrilnv )

# see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

    externalproject_add(

            ${mssmtrilnv}
            DEPENDS ${spheno}
            URL ${MSSMTriLnV_URL}
            URL_MD5 eb54d22459a6f9482fd4e959c69ff00e
            PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_SPheno.cmake
            BUILD_IN_SOURCE 0
            CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> ${SPheno_ROOT_DIR}/MSSMTriLnV
            BINARY_DIR ${SPheno_ROOT_DIR}
            BUILD_COMMAND $(MAKE) Model=MSSMTriLnV F90=${CMAKE_Fortran_COMPILER}
            INSTALL_COMMAND ""

    )

    #externalproject_get_property( ${spheno} source_dir )
    #set( SPheno_ROOT_DIR ${source_dir} )

    list( APPEND fittino_dependencies ${mssmtrilnv} )
    #list( APPEND prefixPath ${SPheno_ROOT_DIR} )


endif()

if( INSTALL_FeynHiggs )

    set( feynhiggs FeynHiggs-2.11.3 )

    externalproject_add(

            ${feynhiggs}
            URL http://wwwth.mpp.mpg.de/members/heinemey/feynhiggs/newversion/FeynHiggs-2.11.3.tar.gz
            URL_MD5 49f5ea1838cb233baffd85bbc1b0d87d
            CONFIGURE_COMMAND ./configure --quad --enable-slhapara --disable-vt100 --prefix=<INSTALL_DIR> CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_Fortran_COMPILER} MAKE=$(MAKE)
            BUILD_COMMAND $(MAKE)
            BUILD_IN_SOURCE 1
            INSTALL_COMMAND $(MAKE) install
    )

    externalproject_get_property( ${feynhiggs} install_dir )
    set( FeynHiggs_ROOT_DIR ${install_dir} )

    list( APPEND prefixPath ${FeynHiggs_ROOT_DIR} )
    list( APPEND fittino_dependencies ${feynhiggs} )

endif()

if( INSTALL_HiggsSignals )

    set( higgsboundslepchisq HiggsBounds_LEP-chisq )

    externalproject_add(

            ${higgsboundslepchisq}
            URL http://www.hepforge.org/archive/higgsbounds/csboutput_trans_binary.tar.gz
            URL_MD5 004decca30335ddad95654a04dd034a6
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""

    )

    externalproject_get_property( ${higgsboundslepchisq} source_dir )

    set( higgsbounds HiggsBounds-4.3.1 )

    externalproject_add(

            ${higgsbounds}
            DEPENDS ${higgsboundslepchisq}
            URL http://www.hepforge.org/archive/higgsbounds/HiggsBounds-4.3.1.tar.gz
            URL_MD5 c1667613f814a9f0297d1f11a8b3ef34
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ./configure-with-chisq
            PATCH_COMMAND ${CMAKE_COMMAND} -Dclsbtablesdir=${source_dir} -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_HiggsBounds.cmake
            BUILD_COMMAND $(MAKE) F90C=${CMAKE_Fortran_COMPILER}
            INSTALL_COMMAND ""

    )

    externalproject_get_property( ${higgsbounds} source_dir )

    set( higgssignals HiggsSignals-1.4.0 )

    externalproject_add(

            ${higgssignals}
            DEPENDS ${higgsbounds}
            URL http://www.hepforge.org/archive/higgsbounds/HiggsSignals-1.4.0.tar.gz
            URL_MD5 00b8ac655e357c7cba9ca786f8f2ddee
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ./configure
            PATCH_COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_HiggsSignals.cmake
            BUILD_COMMAND $(MAKE) F90C=${CMAKE_Fortran_COMPILER} HBLIBS=-L${source_dir} HBINCLUDE=-I${source_dir}
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${higgssignals} )

endif()

if( INSTALL_SuperIso )

    set( superiso SuperIso-3.4 )

    externalproject_add(

            ${superiso}
            URL ${SuperIso_URL}
            URL_MD5 fa6b41e70c34e8ab40c81ad126fb7248
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) CC=${CMAKE_C_COMPILER}
            COMMAND $(MAKE) slha CC=${CMAKE_C_COMPILER}
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${superiso} )

endif()

if( INSTALL_MicrOMEGAs )

    set( micromegas MicrOMEGAs-4.2.5 )

    externalproject_add(

            ${micromegas}
            URL https://lapth.cnrs.fr/micromegas/downloadarea/code/micromegas_4.2.5.tgz
            URL_MD5 1b9afd0f0f5c5467b0f5e87783031c8c
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_Fortran_COMPILER} CPLUS_INCLUDE_PATH=/usr/include
            COMMAND ${CMAKE_COMMAND} -E chdir MSSM $(MAKE) CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_Fortran_COMPILER} CPLUS_INCLUDE_PATH=/usr/include main=main.cpp
            BUILD_IN_SOURCE 1
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${micromegas} )

endif()

if( INSTALL_LHAPDF )

    set( lhapdf5 LHAPDF-5.8.9 )

    externalproject_add(

            ${lhapdf5}
            URL https://www.hepforge.org/archive/lhapdf/lhapdf-5.8.9.tar.gz
            URL_MD5 51e61fa316957abd13d1b76b44e665cf
            CONFIGURE_COMMAND ./configure --prefix=<INSTALL_DIR> CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_Fortran_COMPILER}
            BUILD_COMMAND $(MAKE)
            BUILD_IN_SOURCE 1
            INSTALL_COMMAND $(MAKE) install

    )

    list( APPEND fittino_dependencies ${lhapdf} )

endif()

if( INSTALL_Miniconda2 OR INSTALL_SModelS OR INSTALL_SCYNet OR INSTALL_CheckMATE )

    set( miniconda2 Miniconda2-4.3.11 )

    if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

        set( miniconda2_url https://repo.continuum.io/miniconda/Miniconda2-4.3.11-MacOSX-x86_64.sh )
        set( miniconda2_url_md5 d2edb7d4f3f55c35b9a25fd2d0ef6856 )

    elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

        set( miniconda2_url https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh )
        set( miniconda2_url_md5 d573980fe3b5cdf80485add2466463f5 )

    elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86" )

        set( miniconda2_url https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86.sh )
        set( miniconda2_url_md5 09e9780288d29e46f3dd7eaa7ce280bc )

    else()

        message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} and CMAKE_HOST_SYSTEM_PROCESSOR is ${CMAKE_HOST_SYSTEM_PROCESSOR}." )

    endif()

    find_package( UnixCommands REQUIRED )

    set( miniconda2_install_command ${CMAKE_COMMAND} -E env HOME=<INSTALL_DIR> PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${BASH} <DOWNLOADED_FILE> -b -f -p <INSTALL_DIR> )

    list( APPEND miniconda2_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/bin/conda install -y numpy scipy )


    if( "${CMAKE_SYSTEM_NAME}" MATCHES "Linux" )

        list( APPEND miniconda2_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/bin/conda install -y tensorflow==0.10.0rc0 )

    else()

        list( APPEND miniconda2_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/bin/pip install tensorflow==0.12.0rc0 )

    endif()

    externalproject_add(

            ${miniconda2}
            URL ${miniconda2_url}
            URL_MD5 ${miniconda2_url_md5}
            CONFIGURE_COMMAND ""
            DOWNLOAD_NO_EXTRACT 1
            BUILD_COMMAND ""
            INSTALL_COMMAND ${miniconda2_install_command}

    )

    externalproject_get_property( ${miniconda2} install_dir )
    set( Conda_ROOT_DIR ${install_dir} )

    list( APPEND prefixPath ${Conda_ROOT_DIR} )
    list( APPEND fittino_dependencies ${miniconda2} )

endif()

if( INSTALL_SModelS )

    set( smodels SModelS-1.1.0patch1 )

        externalproject_add(

            ${smodels}
            DEPENDS ${miniconda2}
            URL ${SModelS_URL}
            URL_MD5 ${SModelS_URL_MD5}
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) FCC=${CMAKE_Fortran_COMPILER}
            BUILD_IN_SOURCE 1
            INSTALL_COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${Conda_ROOT_DIR}/bin/pip install unum docutils pyslha argparse
            COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${Conda_ROOT_DIR}/bin/python setup.py install


    )

    list( APPEND fittino_dependencies ${smodels} )

    externalproject_get_property( ${smodels} source_dir )

    set( smodelsfastlimdatabase SModelSFastlimDatabase-1.1_1.0 )

    externalproject_add(

            ${smodelsfastlimdatabase}
            DEPENDS ${smodels}
            URL ${SModelSFastlimDatabase_URL}
            URL_MD5 ${SModelSFastlimDatabase_URL_MD5}
            DOWNLOAD_NO_EXTRACT 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory ${source_dir}/smodels-database <INSTALL_DIR>
            COMMAND ${CMAKE_COMMAND} -E chdir <INSTALL_DIR> ${CMAKE_COMMAND} -E tar xf <DOWNLOADED_FILE>

    )

    externalproject_get_property( ${smodelsfastlimdatabase} install_dir )
    set( SModelSDatabase_ROOT_DIR ${install_dir} )

    list( APPEND fittino_dependencies ${smodelsfastlimdatabase} )

endif()

if( INSTALL_SCYNet )

    set( scynet SCYNet )

    externalproject_add(

            ${scynet}
            DEPENDS ${miniconda2}
            SVN_REPOSITORY https://svn.physik.uni-bonn.de/basic/fittino-protected/trunk/SCYNet
            SVN_REVISION -r194
            CONFIGURE_COMMAND ""
            UPDATE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""

    )

    externalproject_get_property( ${scynet} SOURCE_DIR )
    set( SCYNet_ROOT_DIR ${SOURCE_DIR} )

    list( APPEND fittino_dependencies ${scynet} )

endif()

if( INSTALL_HepMC2 OR INSTALL_CheckMATE )

    set( hepmc2 HepMC-2.6.9 )

    externalproject_add(

            ${hepmc2}
            URL http://hepmc.web.cern.ch/hepmc/releases/hepmc2.06.09.tgz
            URL_MD5 52518437a64f6b4284e9acc2ecad6212
            CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -Dmomentum:STRING=GEV -Dlength:STRING=MM -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}

    )

    list( APPEND fittino_dependencies ${hepmc2} )

    externalproject_get_property( ${hepmc2} INSTALL_DIR )
    set( HepMC_ROOT_DIR ${INSTALL_DIR} )

endif()

if( INSTALL_Pythia8 OR INSTALL_CheckMATE )

    find_package( ZLIB REQUIRED )
    get_filename_component( zlib_library_dir ${ZLIB_LIBRARIES} DIRECTORY )

    set( pythia8 PYTHIA-8.2.23 )

    externalproject_add(

            ${pythia8}
            DEPENDS ${hepmc2}
            URL http://home.thep.lu.se/~torbjorn/pythia8/pythia8223.tgz
            URL_MD5 ccb52b9172ffcdc426732a95f7bf4dbb
            CONFIGURE_COMMAND ./configure --cxx=${CMAKE_CXX_COMPILER} --prefix=<INSTALL_DIR> --with-hepmc2=${HepMC_ROOT_DIR} --with-gzip-lib=${zlib_library_dir} --with-gzip-include=${ZLIB_INCLUDE_DIRS}
            BUILD_COMMAND $(MAKE)
            BUILD_IN_SOURCE 1
            INSTALL_COMMAND $(MAKE) install

    )

endif()

# TODO: ADD MADGRAPH AND DELPHES required by checkmate
#    EXTERNALPROJECT_ADD(
#            ${checkmate}
#            DEPENDS ${hepmc2} ${pythia8} ${madgraph} ${delphes}
#            URL
#            URL_MD5
#            CONFIGURE_COMMAND ./configure --cxx=${CMAKE_CXX_COMPILER}  --with-hepmc2=${HepMC_ROOT_DIR}  --with-gziplib=${zlib_library_dir} --with-gzipinc=${ZLIB_INCLUDE_DIRS}
#            BUILD_COMMAND $(MAKE)
#            BUILD_IN_SOURCE 1
#            INSTALL_COMMAND ""
#    )

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/activate ${CMAKE_CURRENT_BINARY_DIR}/activate )


if( INSTALL_Fittino )

    set( fittino Fittino )

    externalproject_add(

            ${fittino}
            DEPENDS ${fittino_dependencies}
            SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
            BUILD_ALWAYS ON
            BUILD_COMMAND ""
            # BINARY_DIR ${CMAKE_CURRENTSOURCE_DIR}/build
            CMAKE_ARGS -C${CMAKE_CURRENT_BINARY_DIR}/init.cmake -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>

    )

    externalproject_get_property( ${fittino} install_dir )
    set( Fittino_ROOT_DIR ${install_dir} )

    file( APPEND ${CMAKE_CURRENT_BINARY_DIR}/activate "export PATH=${Fittino_ROOT_DIR}/bin/:$PATH\n" )
    file( APPEND ${CMAKE_CURRENT_BINARY_DIR}/activate "export FITTINO_ROOT_DIR=${Fittino_ROOT_DIR}\n" )

endif()

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/init.cmake ${CMAKE_CURRENT_BINARY_DIR}/init.cmake )

