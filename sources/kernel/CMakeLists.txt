# $Id$ #

################################################################################
#                                                                              #
# Project     Fittino - A SUSY Parameter Fitting Package                       #
#                                                                              #
# File        CMakeLists.txt                                                   #
#                                                                              #
# Description Cmake configuration file for the kernel directory.               #
#                                                                              #
# Authors     Bjoern Sarrazin     <sarrazin@physik.uni-bonn.de>                #
#             Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              #
#                                                                              #
# Licence     This program is free software; you can redistribute it and/or    #
#             modify it under the terms of the GNU General Public License as   #
#	      published by the Free Software Foundation; either version 3 of   #
#	      the License, or (at your option) any later version.              #
#                                                                              #
################################################################################

IF( ROOT_FOUND )

    LINK_DIRECTORIES( ${ROOT_LIBRARY_DIRS} )

ENDIF()

FILE( GLOB includes ./include/*.h )
AUX_SOURCE_DIRECTORY( ./src sources )
ADD_EXECUTABLE( fittino ${includes} ${sources} )

GET_PROPERTY( compile_flags TARGET fittino PROPERTY COMPILE_FLAGS )
GET_PROPERTY( link_flags    TARGET fittino PROPERTY LINK_FLAGS    )

INCLUDE_DIRECTORIES( ./include               )
INCLUDE_DIRECTORIES( ../calculators/include  )
INCLUDE_DIRECTORIES( ../datastorages/include )
INCLUDE_DIRECTORIES( ../exceptions/include   )
INCLUDE_DIRECTORIES( ../models/include       )
INCLUDE_DIRECTORIES( ../optimizers/include   )
INCLUDE_DIRECTORIES( ../plotters/include     )
INCLUDE_DIRECTORIES( ../samplers/include     )

TARGET_LINK_LIBRARIES( fittino checkvacuum  )
TARGET_LINK_LIBRARIES( fittino models       )
TARGET_LINK_LIBRARIES( fittino calculators  )
TARGET_LINK_LIBRARIES( fittino optimizers   )
TARGET_LINK_LIBRARIES( fittino plotters     )
TARGET_LINK_LIBRARIES( fittino samplers     )
TARGET_LINK_LIBRARIES( fittino datastorages )
TARGET_LINK_LIBRARIES( fittino exceptions   )

IF( Boost_FOUND )

    INCLUDE_DIRECTORIES( ${Boost_INCLUDE_DIRS} )
    TARGET_LINK_LIBRARIES(fittino ${Boost_LIBRARIES} )

ENDIF()

IF( ROOT_FOUND )

    SET( compile_flags "${compile_flags} ${ROOT_COMPILE_FLAGS}" )
    SET( link_flags    "${link_flags} ${ROOT_LINK_FLAGS}"       )

ENDIF()

IF( SLHAEA_FOUND )

    ADD_DEFINITIONS( -DSLHAEA )

ENDIF()

IF( GSL_FOUND )

    ADD_DEFINITIONS( -DGSL )
    TARGET_LINK_LIBRARIES(fittino ${GSL_LIBRARIES})

ENDIF()

IF( LHAPDF_FOUND )

    ADD_DEFINITIONS( -DLHAPDF_FOUND )
    TARGET_LINK_LIBRARIES( fittino ${LHAPDF_LIBRARIES} )  

ENDIF( LHAPDF_FOUND )

IF(LHAPDF_FOUND AND GSL_FOUND)

    TARGET_LINK_LIBRARIES(fittino HDim6)

ENDIF()

IF ( GFORTRANLIB_FOUND )

    TARGET_LINK_LIBRARIES( fittino ${GFORTRAN_LIBRARIES} )

ENDIF()

IF ( IFORTLIB_FOUND )

    TARGET_LINK_LIBRARIES( fittino ${IFORT_LIBRARIES} )

ENDIF()

IF ( GFORTRANLIB_FOUND OR IFORTLIB_FOUND )

    IF( FEYNHIGGS_FOUND )

        ADD_DEFINITIONS( -DFEYNHIGGS )
        ADD_LIBRARY( feynhiggs STATIC IMPORTED )
        SET_TARGET_PROPERTIES( feynhiggs PROPERTIES IMPORTED_LOCATION ${FEYNHIGGS_LIBRARIES} IMPORTED_LINK_INTERFACE_LANGUAGES "Fortran" )
        TARGET_LINK_LIBRARIES( fittino feynhiggs )

    ENDIF()

    IF( HIGGSBOUNDS_FOUND )

        ADD_DEFINITIONS( -DHIGGSBOUNDS_FOUND )
        ADD_LIBRARY( higgsbounds STATIC IMPORTED )
        SET_TARGET_PROPERTIES( higgsbounds PROPERTIES IMPORTED_LOCATION ${HIGGSBOUNDS_LIBRARIES} IMPORTED_LINK_INTERFACE_LANGUAGES "Fortran" )
        TARGET_LINK_LIBRARIES( fittino higgsbounds )

    ENDIF()

    IF( HIGGSSIGNALS_FOUND )

        ADD_DEFINITIONS( -DHIGGSSIGNALS_FOUND )
        ADD_LIBRARY( higgssignals STATIC IMPORTED )
        SET_TARGET_PROPERTIES( higgssignals PROPERTIES IMPORTED_LOCATION ${HIGGSSIGNALS_LIBRARIES} IMPORTED_LINK_INTERFACE_LANGUAGES "Fortran" )
        TARGET_LINK_LIBRARIES( fittino higgssignals )

    ENDIF()

ENDIF()

SET_TARGET_PROPERTIES( fittino PROPERTIES COMPILE_FLAGS ${compile_flags} LINK_FLAGS ${link_flags} )

INSTALL(TARGETS fittino DESTINATION bin)
