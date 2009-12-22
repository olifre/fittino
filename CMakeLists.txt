PROJECT( Fittino )

# Project version
SET( ${PROJECT_NAME}_MAJOR_VERSION 0 )
SET( ${PROJECT_NAME}_MINOR_VERSION 0 )
SET( ${PROJECT_NAME}_PATCH_LEVEL 0 )

# set default cmake build type to RelWithDebInfo
# (None Debug Release RelWithDebInfo MinSizeRel)
IF( NOT CMAKE_BUILD_TYPE )
SET( CMAKE_BUILD_TYPE "RelWithDebInfo" )
ENDIF()

# Install directory
SET( CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/bin" )

#include directories
INCLUDE_DIRECTORIES( "${PROJECT_SOURCE_DIR}/include" )

# Require proper c++
ADD_DEFINITIONS( "-Wall -ansi -pedantic" )

# Add debug definitions
#IF( CMAKE_BUILD_TYPE STREQUAL "Debug" OR
# CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo" )
# ADD_DEFINITIONS( "-DDEBUG" )
#ENDIF()

# List of all source files
AUX_SOURCE_DIRECTORY( src )

ADD_EXECUTABLE(fittino fittino)
