CMAKE_MINIMUM_REQUIRED( VERSION 2.4 )

PROJECT( FITTINO )

# Project version
SET( ${PROJECT_NAME}_MAJOR_VERSION 0 )
SET( ${PROJECT_NAME}_MINOR_VERSION 0 )
SET( ${PROJECT_NAME}_PATCH_LEVEL 0 )

# Library *nix style versioning
SET( ${PROJECT_NAME}_SOVERSION
    "${${PROJECT_NAME}_MAJOR_VERSION}.${${PROJECT_NAME}_MINOR_VERSION}" )
SET( ${PROJECT_NAME}_VERSION
    "${${PROJECT_NAME}_SOVERSION}.${${PROJECT_NAME}_PATCH_LEVEL}" )

# Project options
OPTION( BUILD_SHARED_LIBS "Set to OFF to build static libraries" ON )
OPTION( BUILD_32BIT_COMPATIBLE "Set to ON to build in 32 bit compatibility mode" OFF )
OPTION( INSTALL_DOC "Set to OFF to skip build/install documentation" ON )

# 32/64 bit issues
IF( CMAKE_SIZEOF_VOID_P EQUAL 4 )
    MESSAGE( STATUS "32 bit architecture detected" )
ENDIF()
IF( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    MESSAGE( STATUS "64 bit architecture detected" )

    IF( BUILD_32BIT_COMPATIBLE )
        IF( COMMAND SET_PROPERTY )
            SET_PROPERTY(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS 0)
            SET( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32" )
            SET( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -m32" )
            SET( CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -m32" )
            SET( CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -m32" )
        ELSE()
            MESSAGE( FATAL_ERROR "To build in 32 bit compatibility mode you need a cmake version >= 2.6" )
        ENDIF()
        MESSAGE( STATUS "Build in 32 bit compatibility mode" )
    ELSE()
        MESSAGE( STATUS "Build in native 64 bit mode" )
    ENDIF()
ENDIF()

# Check for doxygen
FIND_PACKAGE( Doxygen )
IF( DOXYGEN_FOUND )

    ADD_CUSTOM_COMMAND(
        OUTPUT  "${PROJECT_SOURCE_DIR}/doc/html"
        COMMAND "${DOXYGEN_EXECUTABLE}" ARGS "Doxyfile"
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/doc"
        COMMENT "Building API Documentation..."
        VERBATIM )

    # add doc target
    ADD_CUSTOM_TARGET( doc DEPENDS
        "${PROJECT_SOURCE_DIR}/doc/html" )
ELSE()
    MESSAGE( STATUS "Doxygen not found in your system" )
    IF( INSTALL_DOC )
        MESSAGE( STATUS "INSTALL_DOC forced to OFF" )
        SET( INSTALL_DOC OFF )
    ENDIF()
ENDIF()

# Install documentation
IF( INSTALL_DOC )
    # Make sure doxygen is executed (make doc) before make install
    INSTALL( CODE "EXEC_PROGRAM(${CMAKE_BUILD_TOOL} ${PROJECT_BINARY_DIR} ARGS
doc)" )
    # Install documentation
    INSTALL( DIRECTORY "${PROJECT_SOURCE_DIR}/doc"
            DESTINATION . )
ENDIF()

# Set default cmake build type to RelWithDebInfo
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

# Search for ROOT package
FIND_PACKAGE(ROOT REQUIRED)
INCLUDE_DIRECTORIES(${ROOT_INCLUDE_DIRS})
SET(LIBS ${LIBS} ${ROOT_LIBRARIES})

# Add subdirectories
ADD_SUBDIRECTORY(exceptions)
ADD_SUBDIRECTORY(interpreters)
ADD_SUBDIRECTORY(kernel)
ADD_SUBDIRECTORY(optimizers)

# Add binary fittino build from file Fittino.{cpp,cxx,cc}
ADD_EXECUTABLE(fittino Fittino)

# Link executable to required libraries
TARGET_LINK_LIBRARIES(fittino ${LIBS})
