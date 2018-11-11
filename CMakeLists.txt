# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the main directory.                 #
#                                                                              #
# Authors     Bjoern  Sarrazin    <sarrazin@physik.uni-bonn.de>                #
#             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#             published by the Free Software Foundation; either version 3 of   #
#             the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

CMAKE_MINIMUM_REQUIRED( VERSION 3.3 FATAL_ERROR )
cmake_policy(SET CMP0057 NEW)

PROJECT( fittino NONE )

IF( CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT )

     MESSAGE( STATUS "CMAKE_INSTALL_PREFIX initialized to default: ${CMAKE_INSTALL_PREFIX}" )

ENDIF()

GET_FILENAME_COMPONENT( REALPATH_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX} REALPATH )

SET( CMAKE_FIND_LIBRARY_PREFIXES       "lib" ""                         )
SET( CMAKE_MODULE_PATH                 ${CMAKE_SOURCE_DIR}/CMakeModules )
SET( CMAKE_SKIP_BUILD_RPATH            FALSE                            )
SET( CMAKE_BUILD_WITH_INSTALL_RPATH    FALSE                            )
SET( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE                             )

SET( FEYNHIGGS_QUAD TRUE CACHE BOOL "" )

option( USE_WCxf "" ON )

ENABLE_LANGUAGE( CXX )
ENABLE_LANGUAGE( C )
ENABLE_LANGUAGE( Fortran )

set( CMAKE_CXX_STANDARD 14 CACHE STRING "" )
set( CMAKE_CXX_STANDARD_REQUIRED ON )

FIND_PACKAGE( Boost 1.47.0 REQUIRED COMPONENTS filesystem system thread regex chrono )
FIND_PACKAGE( ROOT 5.20.00 REQUIRED COMPONENTS Minuit2 TMVA                                                 )
FIND_PACKAGE( GSL                                                                    )
FIND_PACKAGE( HepMC                                                                  )
FIND_PACKAGE( LHAPDF 5.8.9 EXACT                                                     )
FIND_PACKAGE( SLHAEA                                                                 )
find_package( SPheno OPTIONAL_COMPONENTS MSSMTriLnV                                  )
find_package( SModelS                                                                )
FIND_PACKAGE( X11                                                                    )
FIND_PACKAGE( MICROMEGAS                                                             )
FIND_PACKAGE( FORTRANFLUSH                                                           )
FIND_PACKAGE( HIGGSBOUNDS                                                            )
FIND_PACKAGE( HIGGSSIGNALS                                                           )
#FIND_PACKAGE( FEYNHIGGS                                                             )
FIND_PACKAGE( GFORTRANLIB                                                            )
FIND_PACKAGE( IFORTLIB                                                               )
FIND_PACKAGE( LibXml2                                                                )
FIND_PACKAGE( Doxygen                                                                )
FIND_PACKAGE( GM2Calc                                                                )
FIND_PACKAGE( Eigen3 3.1                                                             )
FIND_PACKAGE( SUPERISO                                                               )
find_package( PythonInterp )
FIND_PACKAGE( PythonLibs )
FIND_PACKAGE( MadGraph5 )
FIND_PACKAGE( CheckMATE )
find_package( Prospino )

set( veccoreVersions "6.12/04;6.12/06;6.14/04" )

if( "${ROOT_VERSION}" IN_LIST veccoreVersions  )

    find_package( VecCore REQUIRED )
    list( APPEND ROOT_INCLUDE_DIRS ${VecCore_INCLUDE_DIRS} )

endif()

if( PYTHONINTERP_FOUND AND PYTHONLIBS_FOUND AND PYTHON_VERSION_STRING STREQUAL PYTHONLIBS_VERSION_STRING )

    if( PYTHON_VERSION_MAJOR EQUAL "2" AND PYTHON_VERSION_MINOR EQUAL "7" )

        FIND_PACKAGE( Boost 1.47.0 REQUIRED COMPONENTS filesystem system thread regex chrono OPTIONAL_COMPONENTS python )

        if( Boost_PYTHON_FOUND )

            set( PYTHON2_FOUND 1 )

            # needed to use Python 2.7.13-15 with C++17
            # compare also https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=231073
            add_compile_options( -Wno-register )

        endif()

    elseif( PYTHON_VERSION_MAJOR EQUAL "3" AND PYTHON_VERSION_MINOR GREATER_EQUAL "5" )

        set( PYTHON3_FOUND 1 )

    endif()

endif()

IF( SPheno_FOUND )

    add_definitions( -DSPHENO_EXECUTABLE="${SPheno_EXECUTABLE}" )

endif()

IF( SMODELSTOOLS_FOUND )

    add_definitions( -DSModelSTools_EXECUTABLE="${SModelSTools_EXECUTABLE}" )

endif()

add_subdirectory( CMakeModules )
add_subdirectory( sources )
add_subdirectory( external )
add_subdirectory( input )
add_subdirectory( doc )
add_subdirectory( devel )
add_subdirectory( logo )

add_custom_target( README SOURCES README )

set( sbsrc )
list( APPEND sbsrc SuperBuild/CMakeLists.txt )
list( APPEND sbsrc SuperBuild/CMake )
list( APPEND sbsrc SuperBuild/createSource_MSSMTriLnV.m )
list( APPEND sbsrc SuperBuild/Flavio_patch )
list( APPEND sbsrc SuperBuild/MSSMTriLnV )
list( APPEND sbsrc SuperBuild/SPhenoMSSMTriLnV )
list( APPEND sbsrc SuperBuild/Requirements )
list( APPEND sbsrc SuperBuild/SPheno_patch )
list( APPEND sbsrc SuperBuild/SCYNet )
list( APPEND sbsrc SuperBuild/init.cmake )
add_custom_target( SuperBuild SOURCES ${sbsrc} )

set( insrc )
list( APPEND insrc input/definitions )
list( APPEND insrc input/style )
list( APPEND insrc input/external )
list( APPEND insrc input/steering )
list( APPEND insrc input/scripts )
list( APPEND insrc input/prospino_main.f90 )
add_custom_target( input SOURCES ${insrc} )

# maybe needed for some IDEs in order to be able to run install command
# add_custom_target( Install COMMAND ${CMAKE_MAKE_PROGRAM} install )

