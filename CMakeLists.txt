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

CMAKE_MINIMUM_REQUIRED( VERSION 2.6 FATAL_ERROR )

PROJECT( fittino NONE )

INCLUDE( build/CMakeLists.txt OPTIONAL )

#SET( CMAKE_CXX_FLAGS                   "${CMAKE_CXX_FLAGS} -std=c++11"  )
# todo: When cmake 3.1 is available in all supported environments, use CXX_STANDARD_REQUIRED instead.
# alternatively use target_compile_features together with CMAKE_CXX_COMPILE_FEATURES
SET( CMAKE_INSTALL_PREFIX              ${CMAKE_SOURCE_DIR}              )
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

FIND_PACKAGE( Boost 1.47.0 COMPONENTS filesystem system thread REQUIRED )
FIND_PACKAGE( ROOT 5.20.00 REQUIRED                                     )
FIND_PACKAGE( GSL                                                       )
FIND_PACKAGE( LHAPDF 5.8.9 EXACT                                        )
FIND_PACKAGE( SLHAEA                                                    )
FIND_PACKAGE( X11                                                       )
FIND_PACKAGE( MICROMEGAS                                                )
FIND_PACKAGE( FORTRANFLUSH                                              )
FIND_PACKAGE( SUPERISO                                                  )
FIND_PACKAGE( HIGGSBOUNDS                                               )
FIND_PACKAGE( HIGGSSIGNALS                                              )
FIND_PACKAGE( FEYNHIGGS                                                 )
FIND_PACKAGE( GFORTRANLIB                                               )
FIND_PACKAGE( IFORTLIB                                                  )
FIND_PACKAGE( LIBXML2                                                   )

FIND_PACKAGE( PythonLibs ) 

IF( PYTHONLIBS_FOUND )

    FIND_PACKAGE( Boost 1.47.0 COMPONENTS filesystem system thread python )

ENDIF()

ADD_SUBDIRECTORY( external )
ADD_SUBDIRECTORY( sources  )

ADD_CUSTOM_TARGET( stylish ALL ${PROJECT_SOURCE_DIR}/devel/apply_style_guidelines.sh ${PROJECT_SOURCE_DIR}  )
