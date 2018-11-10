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

set( CMAKE_CXX_STANDARD 14 CACHE STRING "" )
set( CMAKE_CXX_STANDARD_REQUIRED ON )

set( CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "" )

project( Fittino_Superbuild LANGUAGES NONE )

set( CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMakeModules )
list( APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/CMake )

include( ExternalProject )

set_property( DIRECTORY PROPERTY "EP_BASE" ${PROJECT_BINARY_DIR} )

include( CheckLanguage )
include( FeatureSummary )

include( Options )

if ( BUILD_OFFLINE )

    set_property( DIRECTORY PROPERTY "EP_UPDATE_DISCONNECTED" ${PROJECT_BINARY_DIR} )

endif()

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" )

    set( ldLibraryPathName "DYLD_LIBRARY_PATH" )

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" )

    set( ldLibraryPathName "LD_LIBRARY_PATH" )

else()

message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} but only Darwin and Linux are supported." )

endif()

set( activationScript ${CMAKE_CURRENT_BINARY_DIR}/activate.sh )
file( WRITE ${activationScript} "#!/usr/bin/env bash\n" )

include( Projects )

if ( PATH )

    file( APPEND ${activationScript} "\n" )

endif()

foreach( dir IN LISTS PATH )

    file( APPEND ${activationScript} "export PATH=${dir}:$PATH\n" )

endforeach()

if ( ldLibraryPathValue )

    file( APPEND ${activationScript} "\n" )

endif()

foreach( dir IN LISTS ldLibraryPathValue )

    file( APPEND ${activationScript} "export ${ldLibraryPathName}=${dir}:$${ldLibraryPathName}\n" )

endforeach()

if ( PYTHONPATH )

    file( APPEND ${activationScript} "\n" )

endif()

foreach( dir IN LISTS PYTHONPATH )

    file( APPEND ${activationScript} "export PYTHONPATH=${dir}:$PYTHONPATH\n" )

endforeach()

feature_summary( WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES )
