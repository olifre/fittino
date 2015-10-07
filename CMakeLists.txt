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

IF(NOT IS_ABSOLUTE ${CMAKE_INSTALL_PREFIX} )

    MESSAGE( FATAL_ERROR "Absolute path required for CMAKE_INSTALL_PREFIX." )

ENDIF()

IF( CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT )

    MESSAGE( STATUS "CMAKE_INSTALL_PREFIX initialized to default ${CMAKE_INSTALL_PREFIX}." )

ENDIF( )

GET_FILENAME_COMPONENT( REALPATH_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX} REALPATH )

SET( CMAKE_FIND_LIBRARY_PREFIXES       "lib" ""                         )
SET( CMAKE_MODULE_PATH                 ${CMAKE_SOURCE_DIR}/CMakeModules )
SET( CMAKE_SKIP_BUILD_RPATH            FALSE                            )
SET( CMAKE_BUILD_WITH_INSTALL_RPATH    FALSE                            ) 
SET( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE                             )

IF( NOT DEFINED FEYNHIGGS_QUAD )

    SET( FEYNHIGGS_QUAD TRUE )

ENDIF()

ENABLE_LANGUAGE( CXX )
ENABLE_LANGUAGE( C )
# ENABLE_LANGUAGE( Fortran )

FIND_PACKAGE( Boost 1.47.0 COMPONENTS filesystem system thread regex chrono REQUIRED )
FIND_PACKAGE( ROOT 5.20.00 REQUIRED                                                  )
FIND_PACKAGE( GSL                                                                    )
FIND_PACKAGE( LHAPDF 5.8.9 EXACT                                                     )
FIND_PACKAGE( SLHAEA                                                                 )
FIND_PACKAGE( X11                                                                    )
FIND_PACKAGE( MICROMEGAS                                                             )
FIND_PACKAGE( FORTRANFLUSH                                                           )
FIND_PACKAGE( SUPERISO                                                               )
FIND_PACKAGE( HIGGSBOUNDS                                                            )
FIND_PACKAGE( HIGGSSIGNALS                                                           )
FIND_PACKAGE( FEYNHIGGS                                                              )
FIND_PACKAGE( GFORTRANLIB                                                            )
FIND_PACKAGE( IFORTLIB                                                               )
FIND_PACKAGE( LibXml2                                                                )
FIND_PACKAGE( PythonLibs                                                             )
FIND_PACKAGE( Doxygen                                                                )
FIND_PACKAGE( GM2Calc                                                                )
FIND_PACKAGE( Eigen3 3.1                                                             )

IF( PYTHONLIBS_FOUND )

    FIND_PACKAGE( Boost 1.47.0 COMPONENTS filesystem system thread python chrono regex )

ENDIF()

# todo look for astyle
ADD_CUSTOM_TARGET( stylish ALL ${PROJECT_SOURCE_DIR}/devel/apply_style_guidelines.sh ${PROJECT_SOURCE_DIR}  )

If( DOXYGEN_FOUND )

    CONFIGURE_FILE( ${PROJECT_SOURCE_DIR}/doc/Doxyfile.in ${PROJECT_BINARY_DIR}/Doxyfile @ONLY )
    ADD_CUSTOM_TARGET( doc ${DOXYGEN_EXECUTABLE} WORKING_DIRECTORY ${PROJECT_BINARY_DIR} )
    INSTALL( DIRECTORY "${PROJECT_BINARY_DIR}/html" DESTINATION share/doc/fittino OPTIONAL )

ENDIF( DOXYGEN_FOUND )

INSTALL( DIRECTORY "${PROJECT_SOURCE_DIR}/input" DESTINATION share/fittino PATTERN ".svn" EXCLUDE )

ADD_SUBDIRECTORY( external )
ADD_SUBDIRECTORY( sources  )

ADD_CUSTOM_TARGET( Install COMMAND ${CMAKE_MAKE_PROGRAM} install )
