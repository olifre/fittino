# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        FindROOT.cmake                                                   #
#                                                                              #
# Description This macro tries to find a local ROOT installation.              #
#             If successful, it adds ROOT to Fittino as a cmake module.        #
#                                                                              #
# Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

# Specify the installation path of the executable "root-config". By default, it is assumed that the
# environment variable ROOTSYS is set.

SET(ROOT_CONFIG_PATH $ENV{ROOTSYS}/bin)

# The variable ROOT_CONFIG_EXECUTABLE is set to "ROOT_CONFIG_EXECUTABLE-NOTFOUND" which is the
# default value.

SET(ROOT_CONFIG_EXECUTABLE "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

# Look for the executable "root-config".

FIND_PROGRAM(ROOT_CONFIG_EXECUTABLE root-config PATHS ${ROOT_CONFIG_PATH} NO_DEFAULT_PATH)

IF(${ROOT_CONFIG_EXECUTABLE} MATCHES "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

    # If the executable "root-config is not found print this message"

    MESSAGE(FATAL_ERROR "\nModule ROOT not found.\nPlease set ROOTSYS or add the path to your ROOT installation to the macro FindROOT.cmake in the subdirectory CMakeModules.\n") 

ELSE(${ROOT_CONFIG_EXECUTABLE} MATCHES "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

    # If the executable "root-config is found print this message"

    MESSAGE(STATUS "Module ROOT found")

    # Look for needed libraries and make them accessible via the ROOT_LIBRARIES cache entry.

    EXECUTE_PROCESS(COMMAND root-config --libdir OUTPUT_VARIABLE ROOT_LIBRARY_PATH OUTPUT_STRIP_TRAILING_WHITESPACE)
    EXECUTE_PROCESS(COMMAND root-config --libs OUTPUT_VARIABLE ROOT_STANDARD_LIBRARIES OUTPUT_STRIP_TRAILING_WHITESPACE)

    FIND_LIBRARY(ROOT_XMLPARSER_LIBRARY NAMES XMLParser PATHS ${ROOT_LIBRARY_PATH} NO_DEFAULT_PATH)
    FIND_LIBRARY(ROOT_MINUIT2_LIBRARY NAMES Minuit2 PATHS ${ROOT_LIBRARY_PATH} NO_DEFAULT_PATH)

    SET(ROOT_LIBRARIES ${ROOT_STANDARD_LIBRARIES} ${ROOT_XMLPARSER_LIBRARY} ${ROOT_MINUIT2_LIBRARY})

ENDIF(${ROOT_CONFIG_EXECUTABLE} MATCHES "ROOT_CONFIG_EXECUTABLE-NOTFOUND")

# Folgendes funktioniert leider nicht, da der Output in einem String gespeichert ist
# und nicht in einer Liste. Dies muss ich mir noch mal anschauen.
# Bis dahin wird jede Library einzeln abgefragt und am Ende die ROOT_LIBRARIES
# zusammengebaut.
#
#      EXECUTE_PROCESS( ${ROOT_CONFIG_EXECUTABLE}
#        ARGS "--libs --noauxlibs --noldflags" 
#        OUTPUT_VARIABLE root_flags )
#        message("ROOT_FLAGS: ${root_flags}")
#
#     set(ROOT_LIBRARIES "")
#     FOREACH (_current_FLAG ${root_flags})
#       message("1")
#       string(SUBstring ${_current_FLAG} 2 1 bla)
#       if(${bla} MATCHES "l")
#         string(REGEX REPLACE "^-l(.*)" "\\1" test ${_current_FLAG}) 
#         message("${test}")
#         set(ROOT_LIBRARIES ${ROOT_LIBRARIES} ${test})
#       ELSE (${bla} MATCHES "l")
#         if(${bla} MATCHES "p")
#           string(REGEX REPLACE "^-(.*)" "\\1" test ${_current_FLAG}) 
#         endif(${bla} MATCHES "p")       
#         message("${test}")
#         set(ROOT_LIBRARIES ${ROOT_LIBRARIES} ${test})
#       ENDIF (${bla} MATCHES "l")
#
#     endFOREACH (_current_FLAG ${root_flags})
#
#
#      set(ROOT_FLAGS ${root_flags})
#      # CACHE INTERNAL "")
#
#
#  set(ROOT_DEFINITIONS ${ROOT_DEFINITIONS} -L${ROOT_LIBRARY_DIR} ${ROOT_FLAGS} )

# Make variables changeble to the advanced user
#MARK_AS_ADVANCED( ROOT_LIBRARY_DIR ROOT_INCLUDE_DIR ROOT_DEFINITIONS)

# Set ROOT_INCLUDES
#set( ROOT_INCLUDES ${ROOT_INCLUDE_DIR})

#set(LD_LIBRARY_PATH ${LD_LIBRARY_PATH} ${ROOT_LIBRARY_DIR})
 

#######################################
#
#       Check the executables of ROOT 
#          ( rootcint )
#
#######################################

#    find_program(ROOT_CINT_EXECUTABLE
#	    NAMES rootcint
#	    PATHS ${ROOT_BINARY_DIR}
#	    NO_DEFAULT_PATH
#	    )

# Check if the minimal ROOT version required is found

#STRING(REGEX REPLACE "(^.*)/bin/root-config" "\\1" test ${ROOT_CONFIG_EXECUTABLE})
#SET(ENV{ROOTSYS} ${test})

#if(ROOT_CONFIG_EXECUTABLE)
#
#    # we need at least version 4.00/08
#
#    if(NOT ROOT_MIN_VERSION)
#
#        set(ROOT_MIN_VERSION "4.00/08")
#
#    endif(NOT ROOT_MIN_VERSION)
# 
#    # now parse the parts of the user given version string into variables
#
#    string(REGEX REPLACE "^([0-9]+)\\.[0-9][0-9]+\\/[0-9][0-9]+" "\\1" req_root_major_vers "${ROOT_MIN_VERSION}")
#    string(REGEX REPLACE "^[0-9]+\\.([0-9][0-9])+\\/[0-9][0-9]+.*" "\\1" req_root_minor_vers "${ROOT_MIN_VERSION}")
#    string(REGEX REPLACE "^[0-9]+\\.[0-9][0-9]+\\/([0-9][0-9]+)" "\\1" req_root_patch_vers "${ROOT_MIN_VERSION}")
#    
#    # and now the version string given by qmake
#
#    string(REGEX REPLACE "^([0-9]+)\\.[0-9][0-9]+\\/[0-9][0-9]+.*" "\\1" found_root_major_vers "${ROOTVERSION}")
#    string(REGEX REPLACE "^[0-9]+\\.([0-9][0-9])+\\/[0-9][0-9]+.*" "\\1" found_root_minor_vers "${ROOTVERSION}")
#    string(REGEX REPLACE "^[0-9]+\\.[0-9][0-9]+\\/([0-9][0-9]+).*" "\\1" found_root_patch_vers "${ROOTVERSION}")
#    
#    if(found_root_major_vers LESS 4)
#
#        message(FATAL_ERROR "Invalid ROOT version \"${ROOTERSION}\", at least major version 4 is required, e.g. \"4.00/08\"")
#
#    endif(found_root_major_vers LESS 4)
#    
#    # compute an overall version number which can be compared at once
#
#    math(EXPR req_vers "${req_root_major_vers}*10000 + ${req_root_minor_vers}*100 + ${req_root_patch_vers}")
#    math(EXPR found_vers "${found_root_major_vers}*10000 + ${found_root_minor_vers}*100 + ${found_root_patch_vers}")
#    
#    if(found_vers LESS req_vers)
#
#        set(ROOT_FOUND false)
#        set(ROOT_INSTALLED_VERSION_TOO_OLD true)
#
#    else(found_vers LESS req_vers)
#
#        set(ROOT_FOUND true)
#        set(ROOT_INSTALLED_VERSION_TOO_OLD false)
#
#    endif(found_vers LESS req_vers)
#
#endif(ROOT_CONFIG_EXECUTABLE)

#set(ROOT_DEFINITIONS "")

###########################################
#
#       Macros for building ROOT dictionary
#
###########################################

#MACRO(ROOT_GENERATE_DICTIONARY)
#
#    set(INFILES "")
#
#    FOREACH(_current_FILE ${ARGN})
#    
#        IF(${_current_FILE} MATCHES "^.*\\.h$")
#
#            IF(${_current_FILE} MATCHES "^.*Link.*$")
#
#                set(LINKDEF_FILE ${_current_FILE})
#
#            ELSE(${_current_FILE} MATCHES "^.*Link.*$")
#
#                set(INFILES ${INFILES} ${_current_FILE})
#
#            ENDIF(${_current_FILE} MATCHES "^.*Link.*$")
#
#        ELSE(${_current_FILE} MATCHES "^.*\\.h$")
#
#            IF(${_current_FILE} MATCHES "^.*\\.cxx$")
#
#                set(OUTFILE ${_current_FILE})
#
#            ELSE(${_current_FILE} MATCHES "^.*\\.cxx$")
#
#                set(INCLUDE_DIRS ${INCLUDE_DIRS} -I${_current_FILE})   
#
#            ENDIF(${_current_FILE} MATCHES "^.*\\.cxx$")
#
#        ENDIF(${_current_FILE} MATCHES "^.*\\.h$")
#    
#    ENDFOREACH(_current_FILE ${ARGN})
#    
#    #message("INFILES: ${INFILES}")
#    #message("OutFILE: ${OUTFILE}")
#    #message("LINKDEF_FILE: ${LINKDEF_FILE}")
#    #message("INCLUDE_DIRS: ${INCLUDE_DIRS}")
#    string(REGEX REPLACE "(^.*).cxx" "\\1.h" bla "${OUTFILE}")
#    #message("BLA: ${bla}")
#    SET(OUTFILES ${OUTFILE} ${bla})
#    ADD_CUSTOM_COMMAND(OUTPUT ${OUTFILES}
#    COMMAND ${ROOT_CINT_EXECUTABLE} ARGS -f ${OUTFILE} -c -DHAVE_CONFIG_H ${INCLUDE_DIRS} ${INFILES} ${LINKDEF_FILE} )
#    #message("ROOT_CINT_EXECUTABLE has created the dictionary ${OUTFILE}")
#
#ENDMACRO(ROOT_GENERATE_DICTIONARY)
