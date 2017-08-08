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
set_property( DIRECTORY PROPERTY "EP_UPDATE_DISCONNECTED" ${PROJECT_BINARY_DIR} )

option( INSTALL_SLHAea "" OFF )
option( INSTALL_SPheno "" OFF )
option( INSTALL_FeynHiggs "" OFF )
option( INSTALL_HiggsSignals "" OFF )
option( INSTALL_SuperIso "" OFF )
option( INSTALL_LHAPDF "" OFF )
option( INSTALL_MicrOMEGAs "" OFF )
option( INSTALL_HepMC2 "" OFF )
option( INSTALL_Pythia8 "" OFF )
option( INSTALL_Python "" OFF )
option( INSTALL_MSSMTriLnV "" OFF )
option( INSTALL_SModelS "" OFF )
option( INSTALL_SCYNet "" OFF )
option( INSTALL_CheckMATE "" OFF )
option( INSTALL_Fittino_Python2 "" OFF )
option( INSTALL_Fittino_Python3 "" OFF )

set( script ${CMAKE_CURRENT_BINARY_DIR}/activate.in )

file( WRITE ${script} "#!/usr/bin/env bash\n" )

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

#if( INSTALL_SPheno OR INSTALL_MSSMTriLnV OR INSTALL_SARAH )
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

    list( APPEND fittino_dependencies ${spheno} )

    externalproject_get_property( ${spheno} source_dir )
    set( SPheno_ROOT_DIR ${source_dir} )
    list( APPEND prefixPath ${SPheno_ROOT_DIR} )
    file( APPEND ${script} "export PATH=${SPheno_ROOT_DIR}/bin/:$PATH\n" )

endif()

if ( INSTALL_SARAH )

    set( sarah SARAH-4.11.0 )

    # see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

    externalproject_add(

            ${sarah}
            DEPENDS ${spheno}
            URL http://www.hepforge.org/archive/sarah/SARAH-4.11.0.tar.gz
            URL_MD5 e8cef704101f7e1c2e400ca49da26c36
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${sarah} )

    externalproject_get_property( ${sarah} source_dir )
    set( SARAH_ROOT_DIR ${source_dir} )

endif()

if ( INSTALL_MSSMTriLnVsrc)

    set( sarahmssmtrilnv MSSMTriLnVsrc )

    # see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

    externalproject_add(

            ${sarahmssmtrilnv}
            DEPENDS ${sarah}
            DOWNLOAD_COMMAND ""
            CONFIGURE_COMMAND ""
            BUILD_COMMAND /Applications/Mathematica.app/Contents/MacOS/MathKernel -script ${CMAKE_CURRENT_SOURCE_DIR}/createSource_MSSMTriLnV.m
            BINARY_DIR ${SARAH_ROOT_DIR}
            INSTALL_COMMAND ""

    )

    set( mssmtrilnv MSSMTriLnV )

    externalproject_add(

            ${mssmtrilnv}
            DEPENDS ${sarahmssmtrilnv} ${spheno}
            DOWNLOAD_COMMAND ${CMAKE_COMMAND} -E copy_directory ${SARAH_ROOT_DIR}/Output/MSSM-RpV-TriLnV/EWSB/SPheno <SOURCE_DIR>
            DOWNLOAD_NO_EXTRACT 1
            PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_SPheno.cmake
            CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> ${SPheno_ROOT_DIR}/MSSMTriLnV
            BINARY_DIR ${SPheno_ROOT_DIR}
            BUILD_COMMAND $(MAKE) Model=MSSMTriLnV F90=${CMAKE_Fortran_COMPILER}
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${sarahmssmtrilnv} )
    list( APPEND fittino_dependencies ${mssmtrilnv} )

    #  list(APPEND MSSMTriLnV_DEPENDS ${sarah})

endif()

if( INSTALL_MSSMTriLnV )

    set( MSSMTriLnV_URL "~/Downloads/MSSMTriLnV.tgz" CACHE FILEPATH "" )
    set( MSSMTriLnV_MD5 eb54d22459a6f9482fd4e959c69ff00e )
    #set( MSSMTriLnV_MD5 bd08220ea64540f209f384a6e65c30b4 )

    set( mssmtrilnv MSSMTriLnV )
    # see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

    externalproject_add(

            ${mssmtrilnv}
            DEPENDS ${spheno}
            URL ${MSSMTriLnV_URL}
            URL_MD5 ${MSSMTriLnV_MD5}
            PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/patch_SPheno.cmake
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV_patch <SOURCE_DIR>
            BUILD_IN_SOURCE 0
            CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> ${SPheno_ROOT_DIR}/MSSMTriLnV
            BINARY_DIR ${SPheno_ROOT_DIR}
            BUILD_COMMAND $(MAKE) Model=MSSMTriLnV F90=${CMAKE_Fortran_COMPILER}
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${mssmtrilnv} )

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

    list( APPEND fittino_dependencies ${feynhiggs} )

    externalproject_get_property( ${feynhiggs} install_dir )
    set( FeynHiggs_ROOT_DIR ${install_dir} )
    list( APPEND prefixPath ${FeynHiggs_ROOT_DIR} )

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
    set( SuperIso_URL "~/Downloads/superiso_v3.4.tar" CACHE FILEPATH "" )

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

if( INSTALL_Python OR INSTALL_SModelS OR INSTALL_SCYNet OR INSTALL_CheckMATE )

    set( miniconda Miniconda2-4.3.11 )

    if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.11-MacOSX-x86_64.sh )
        set( miniconda_url_md5 d2edb7d4f3f55c35b9a25fd2d0ef6856 )

    elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh )
        set( miniconda_url_md5 d573980fe3b5cdf80485add2466463f5 )

    elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86" )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86.sh )
        set( miniconda_url_md5 09e9780288d29e46f3dd7eaa7ce280bc )

    else()

        message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} and CMAKE_HOST_SYSTEM_PROCESSOR is ${CMAKE_HOST_SYSTEM_PROCESSOR}." )

    endif()

    find_package( UnixCommands REQUIRED )

    set( miniconda_install_command ${CMAKE_COMMAND} -E env HOME=<INSTALL_DIR> PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${BASH} <DOWNLOADED_FILE> -b -f -p <INSTALL_DIR> )

    set( conda2_packages numpy scipy docutils )
    set( pip2_packages unum pyslha argparse )

    if( "${CMAKE_SYSTEM_NAME}" MATCHES "Linux" )

        set( conda2_packages ${conda2_packages} tensorflow==0.10.0rc0 )

    else()

        set( pip2_packages ${pip2_packages} tensorflow==0.12.0rc0 )

    endif()

    set( python2_v 2.7 )
    set( python2_env Python-2.7 )

    set( python3_v 3.6 )
    set( python3_env Python-3.6 )

    list( APPEND miniconda_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/bin/conda create -y --name ${python2_env} python=${python2_v} ${conda2_packages} )
    list( APPEND miniconda_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/envs/${python2_env}/bin/pip install ${pip2_packages} )

    set( conda3_packages numpy scipy matplotlib nose )
    set( pip3_packages flavio )

    list( APPEND miniconda_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/bin/conda create -y --name ${python3_env} python=${python3_v} ${conda3_packages} )
    list( APPEND miniconda_install_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH <INSTALL_DIR>/envs/${python3_env}/bin/pip install ${pip3_packages} )
    list( APPEND miniconda_install_command COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Flavio_patch/flha.py <INSTALL_DIR>/envs/${python3_env}/lib/python${python3_v}/site-packages/flavio/io/flha.py   )

    externalproject_add(

            ${miniconda}
            URL ${miniconda_url}
            URL_MD5 ${miniconda_url_md5}
            CONFIGURE_COMMAND ""
            DOWNLOAD_NO_EXTRACT 1
            BUILD_COMMAND ""
            INSTALL_COMMAND ${miniconda_install_command}

    )

    list( APPEND fittino_dependencies ${miniconda} )

    externalproject_get_property( ${miniconda} install_dir )

    set( python2_dir ${install_dir}/envs/${python2_env} )
    set( python3_dir ${install_dir}/envs/${python3_env} )

    file( APPEND ${script} "unset PYTHONPATH\n" )
    file( APPEND ${script} "export PYTHONNOUSERSITE=1\n" )
    file( APPEND ${script} "source ${install_dir}/bin/activate @python_env@ \n" )

    #file( APPEND ${script} "export PYTHONHOME=@python_dir@\n" )


endif()

if( INSTALL_SModelS )

    set( smodels SModelS )

    externalproject_add(

            ${smodels}
            DEPENDS ${miniconda}
            GIT_REPOSITORY https://github.com/SModelS/smodels.git
            GIT_TAG 317859dd370ff893a7c2c89dec36f589a506f787
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND $(MAKE) FCC=${CMAKE_Fortran_COMPILER} CXX=${CMAKE_CXX_COMPILER}
            INSTALL_COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${python2_dir}/bin/python setup.py install

    )

    list( APPEND fittino_dependencies ${smodels} )

    set( smodelstarball SModelS-1.1.1 )

    externalproject_add(

            ${smodelstarball}
            DEPENDS ${miniconda}
            URL http://smodels.hephy.at/downloads/v1.1.1/smodels-v1.1.1.tgz
            URL_MD5 d2aeda4815e2764386886ca019f5de16
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""

    )

    list( APPEND fittino_dependencies ${smodelstarball} )

    externalproject_get_property( ${smodelstarball} source_dir )

    set( smodelsfastlimdatabase SModelS-1.1.1-Fastlim-1.0-Database )

    externalproject_add(

            ${smodelsfastlimdatabase}
            DEPENDS ${smodelstarball}
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            URL http://smodels.hephy.at/downloads/v1.1.1/smodels-v1.1.1-fastlim-1.0.tgz
            URL_MD5 e58b08ecd24160563fd38c7a832907a2
            DOWNLOAD_NO_EXTRACT 1
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
            DEPENDS ${miniconda}
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

#configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/activate ${CMAKE_CURRENT_BINARY_DIR}/activate )

if( INSTALL_Fittino_Python2 )

    set( fittino_py2 Fittino_Python2 )

    externalproject_add(

            ${fittino_py2}
            DEPENDS ${fittino_dependencies}
            SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
            BUILD_ALWAYS ON
            BUILD_COMMAND ""
            CMAKE_ARGS -C${CMAKE_CURRENT_BINARY_DIR}/init-python2.cmake -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>

    )

    externalproject_get_property( ${fittino_py2} install_dir )
    set( Fittino_ROOT_DIR_py2 ${install_dir} )

    file( APPEND ${script} "export PATH=@Fittino_ROOT_DIR@/bin/:$PATH\n" )
    file( APPEND ${script} "export FITTINO_ROOT_DIR=@Fittino_ROOT_DIR@\n" )

endif()

if( INSTALL_Fittino_Python3 )

    set( fittino_py3 Fittino_Python3 )

    externalproject_add(

            ${fittino_py3}
            DEPENDS ${fittino_dependencies}
            SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/..
            BUILD_ALWAYS ON
            BUILD_COMMAND ""
            CMAKE_ARGS -C${CMAKE_CURRENT_BINARY_DIR}/init-python3.cmake -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>

    )

    externalproject_get_property( ${fittino_py3} install_dir )
    set( Fittino_ROOT_DIR_py3 ${install_dir} )

    file( APPEND ${script} "export PATH=@Fittino_ROOT_DIR@/bin/:$PATH\n" )
    file( APPEND ${script} "export FITTINO_ROOT_DIR=@Fittino_ROOT_DIR@\n" )

endif()

set( USE_PYTHON3 1 )
set( totalPrefixPath ${prefixPath} )
list( APPEND totalPrefixPath ${python3_dir} )
set( Fittino_ROOT_DIR ${Fittino_ROOT_DIR_py3} )
set( python_env ${python3_env} )
set( python_dir ${python3_dir} )
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/init.cmake ${CMAKE_CURRENT_BINARY_DIR}/init-python3.cmake )
configure_file( ${CMAKE_CURRENT_BINARY_DIR}/activate.in ${CMAKE_CURRENT_BINARY_DIR}/activate-python3 )

set( USE_PYTHON3 0 )
file( APPEND ${script} "export PYTHONPATH=@SCYNet_ROOT_DIR@\n" )
set( totalPrefixPath ${prefixPath} )
list( APPEND totalPrefixPath ${python2_dir} )
set( Fittino_ROOT_DIR ${Fittino_ROOT_DIR_py2} )
set( python_env ${python2_env} )
set( python_dir ${python2_dir} )
configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/init.cmake ${CMAKE_CURRENT_BINARY_DIR}/init-python2.cmake )
configure_file( ${CMAKE_CURRENT_BINARY_DIR}/activate.in ${CMAKE_CURRENT_BINARY_DIR}/activate-python2 )