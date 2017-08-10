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

CMAKE_MINIMUM_REQUIRED( VERSION 3.2 FATAL_ERROR )

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

option( USE_PYTHON3 "" OFF )

SET( FEYNHIGGS_QUAD TRUE CACHE BOOL "" )

ENABLE_LANGUAGE( CXX )
ENABLE_LANGUAGE( C )

FIND_PACKAGE( Boost 1.47.0 COMPONENTS filesystem system thread regex chrono REQUIRED )
FIND_PACKAGE( ROOT 5.20.00 REQUIRED                                                  )
FIND_PACKAGE( GSL                                                                    )
FIND_PACKAGE( HepMC                                                                  )
FIND_PACKAGE( LHAPDF 5.8.9 EXACT                                                     )
FIND_PACKAGE( SLHAEA                                                                 )
find_package( SPheno                                                                 )
find_package( SModelSTools                                                           )
find_package( SModelSDatabase                                                        )
FIND_PACKAGE( X11                                                                    )
FIND_PACKAGE( MICROMEGAS                                                             )
FIND_PACKAGE( FORTRANFLUSH                                                           )
FIND_PACKAGE( HIGGSBOUNDS                                                            )
FIND_PACKAGE( HIGGSSIGNALS                                                           )
FIND_PACKAGE( FEYNHIGGS                                                              )
FIND_PACKAGE( GFORTRANLIB                                                            )
FIND_PACKAGE( IFORTLIB                                                               )
FIND_PACKAGE( LibXml2                                                                )
FIND_PACKAGE( Doxygen                                                                )
FIND_PACKAGE( GM2Calc                                                                )
FIND_PACKAGE( Eigen3 3.1                                                             )

if( USE_PYTHON3 )

    find_package(PythonInterp 3)
    FIND_PACKAGE( PythonLibs 3                                                     )

    IF( PYTHONINTERP_FOUND AND PYTHONLIBS_FOUND AND PYTHON_VERSION_STRING EQUAL PYTHONLIBS_VERSION_STRING  )

        set( PYTHON3_FOUND 1 )

    ENDIF()

else(  )

    find_package(PythonInterp 2.7 EXACT )
    FIND_PACKAGE( PythonLibs 2.7                                                     )

    FIND_PACKAGE( Boost 1.47.0 COMPONENTS filesystem system thread python chrono regex )

    IF( PYTHONINTERP_FOUND AND PYTHONLIBS_FOUND AND Boost_PYTHON_FOUND AND PYTHON_VERSION_STRING EQUAL PYTHONLIBS_VERSION_STRING  )

        set( PYTHON2_FOUND 1 )

    ENDIF()

endif()


# todo look for astyle
ADD_CUSTOM_TARGET( stylish ALL ${PROJECT_SOURCE_DIR}/devel/apply_style_guidelines.sh ${PROJECT_SOURCE_DIR}  )

If( DOXYGEN_FOUND )

    CONFIGURE_FILE( ${PROJECT_SOURCE_DIR}/doc/Doxyfile.in ${PROJECT_BINARY_DIR}/Doxyfile @ONLY )
    ADD_CUSTOM_TARGET( doc ${DOXYGEN_EXECUTABLE} WORKING_DIRECTORY ${PROJECT_BINARY_DIR} )
    INSTALL( DIRECTORY "${PROJECT_BINARY_DIR}/html" DESTINATION share/doc/fittino OPTIONAL )

ENDIF( DOXYGEN_FOUND )

IF( SPHENO_FOUND )

    add_definitions( -DSPHENO_EXECUTABLE="${SPHENO_EXECUTABLE}" )

endif()

IF( SMODELSTOOLS_FOUND )

    add_definitions( -DSModelSTools_EXECUTABLE="${SModelSTools_EXECUTABLE}" )

endif()

set( indir ${PROJECT_BINARY_DIR}/input/ )

#file( COPY ${PROJECT_SOURCE_DIR}/input DESTINATION ${indir} PATTERN ".svn" EXCLUDE )
file(MAKE_DIRECTORY ${indir} )

set( Fittino_INPUT_DIR ${CMAKE_INSTALL_PREFIX}/share/fittino/input )

configure_file( ${PROJECT_SOURCE_DIR}/input/SModelS.in.xml ${indir} )
configure_file( ${PROJECT_SOURCE_DIR}/input/pMSSM11.slha ${indir} )
configure_file( ${PROJECT_SOURCE_DIR}/input/parameters.ini ${indir} )
configure_file( ${PROJECT_SOURCE_DIR}/input/MSSMTriLnV_low.xml ${indir} )
configure_file( ${PROJECT_SOURCE_DIR}/input/RPV.xml ${indir} )
#configure_file( ${PROJECT_SOURCE_DIR}/input/MSSMTriLnV_RK.xml ${indir} )
#configure_file( ${PROJECT_SOURCE_DIR}/input/MSSMTriLnV_RD.xml ${indir} )

configure_file( ${PROJECT_SOURCE_DIR}/input/LesHouches.in.MSSMTriLnV_low ${indir} )

install( DIRECTORY ${indir} DESTINATION ${Fittino_INPUT_DIR} )

ADD_SUBDIRECTORY( external )
ADD_SUBDIRECTORY( sources  )

ADD_CUSTOM_TARGET( Install COMMAND ${CMAKE_MAKE_PROGRAM} install )
