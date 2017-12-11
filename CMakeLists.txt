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

SET( FEYNHIGGS_QUAD TRUE CACHE BOOL "" )

ENABLE_LANGUAGE( CXX )
ENABLE_LANGUAGE( C )
ENABLE_LANGUAGE( Fortran )

FIND_PACKAGE( Boost 1.47.0 REQUIRED COMPONENTS filesystem system thread regex chrono )
FIND_PACKAGE( ROOT 5.20.00 REQUIRED                                                  )
FIND_PACKAGE( GSL                                                                    )
FIND_PACKAGE( HepMC                                                                  )
FIND_PACKAGE( LHAPDF 5.8.9 EXACT                                                     )
FIND_PACKAGE( SLHAEA                                                                 )
find_package( SPheno                                                                 )
find_package( SModelS                                                                )
FIND_PACKAGE( X11                                                                    )
FIND_PACKAGE( MICROMEGAS                                                             )
FIND_PACKAGE( FORTRANFLUSH                                                           )
FIND_PACKAGE( HIGGSBOUNDS                                                            )
FIND_PACKAGE( HIGGSSIGNALS                                                           )
#FIND_PACKAGE( FEYNHIGGS                                                              )
FIND_PACKAGE( GFORTRANLIB                                                            )
FIND_PACKAGE( IFORTLIB                                                               )
FIND_PACKAGE( LibXml2                                                                )
FIND_PACKAGE( Doxygen                                                                )
FIND_PACKAGE( GM2Calc                                                                )
FIND_PACKAGE( Eigen3 3.1                                                             )
FIND_PACKAGE( SUPERISO                                                               )
find_package( PythonInterp )
FIND_PACKAGE( PythonLibs )

if( PYTHONINTERP_FOUND AND PYTHONLIBS_FOUND AND PYTHON_VERSION_STRING EQUAL PYTHONLIBS_VERSION_STRING )

    if( PYTHON_VERSION_MAJOR EQUAL "2" AND PYTHON_VERSION_MINOR EQUAL "7" )

        FIND_PACKAGE( Boost 1.47.0 REQUIRED COMPONENTS filesystem system thread regex chrono OPTIONAL_COMPONENTS python )

        if( Boost_PYTHON_FOUND )

            set( PYTHON2_FOUND 1 )

        endif()

    elseif( PYTHON_VERSION_MAJOR EQUAL "3" )

        set( PYTHON3_FOUND 1 )

    endif()

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

file( GLOB superbuildfiles ${PROJECT_SOURCE_DIR}/SuperBuild/* )

foreach( f ${superbuildfiles} )
set_source_files_properties(${f} PROPERTIES HEADER_FILE_ONLY TRUE)
message(STATUS "superbuildfile=${f}" )
endforeach()

add_custom_target( SuperBuild SOURCES ${superbuildfiles} )


add_subdirectory( external )
add_subdirectory( sources )
add_subdirectory( input )

# ADD_CUSTOM_TARGET( Install COMMAND ${CMAKE_MAKE_PROGRAM} install )


