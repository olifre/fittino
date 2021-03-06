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
#             published by the Free Software Foundation; either version 3 of   #
#             the License, or (at your option) any later version.              #
#                                                                              #
################################################################################


FILE( GLOB includes ./include/*.h )
AUX_SOURCE_DIRECTORY( ./src sources )
ADD_EXECUTABLE( fittino ${includes} ${sources} )

INCLUDE_DIRECTORIES( ./include                  )
INCLUDE_DIRECTORIES( ../calculators/include     )
INCLUDE_DIRECTORIES( ../datastorages/include    )
INCLUDE_DIRECTORIES( ../exceptions/include      )
INCLUDE_DIRECTORIES( ../histogrammakers/include )
INCLUDE_DIRECTORIES( ../models/include          )
INCLUDE_DIRECTORIES( ../optimizers/include      )
INCLUDE_DIRECTORIES( ../plotters/include        )
INCLUDE_DIRECTORIES( ../samplers/include        )
INCLUDE_DIRECTORIES( ../tools/include           )

TARGET_LINK_LIBRARIES( fittino calculators     )
TARGET_LINK_LIBRARIES( fittino checkvacuum     )
TARGET_LINK_LIBRARIES( fittino datastorages    )
TARGET_LINK_LIBRARIES( fittino exceptions      )
TARGET_LINK_LIBRARIES( fittino histogrammakers )
TARGET_LINK_LIBRARIES( fittino models          )
TARGET_LINK_LIBRARIES( fittino optimizers      )
TARGET_LINK_LIBRARIES( fittino plotters        )
TARGET_LINK_LIBRARIES( fittino samplers        )
TARGET_LINK_LIBRARIES( fittino tools           )

ADD_DEFINITIONS( -DREALPATH_INSTALL_PREFIX="${REALPATH_INSTALL_PREFIX}" )
ADD_DEFINITIONS( -DBoost_MINOR_VERSION=${Boost_MINOR_VERSION} )

IF( PYTHON2_FOUND OR PYTHON3_FOUND )

    TARGET_LINK_LIBRARIES(fittino ${PYTHON_LIBRARIES} )
    INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_DIRS})
    ADD_DEFINITIONS( -DPYTHON_EXECUTABLE="${PYTHON_EXECUTABLE}" )
    ADD_DEFINITIONS( -DPYTHON )


ENDIF()

IF( PYTHON2_FOUND )

    ADD_DEFINITIONS( -DPYTHON2 )

elseif( PYTHON3_FOUND )

    add_definitions( -DPYTHON3 )

endif()



    IF( Boost_FOUND )

    INCLUDE_DIRECTORIES( ${Boost_INCLUDE_DIRS} )
    TARGET_LINK_LIBRARIES(fittino ${Boost_LIBRARIES} )

ENDIF()

IF( ROOT_FOUND )

    INCLUDE_DIRECTORIES( ${ROOT_INCLUDE_DIRS} )
    target_link_libraries( fittino ${ROOT_LIBRARIES})

ENDIF()

IF( LIBXML2_FOUND )

    ADD_DEFINITIONS( -DLIBXML2 )
    ADD_DEFINITIONS( -DLIBXML2_XMLLINT_EXECUTABLE="${LIBXML2_XMLLINT_EXECUTABLE}" )

ENDIF()

IF( SLHAEA_FOUND )

    ADD_DEFINITIONS( -DSLHAEA )

ENDIF()

IF( GSL_FOUND )

    ADD_DEFINITIONS( -DGSL )
    TARGET_LINK_LIBRARIES(fittino ${GSL_LIBRARIES})

ENDIF()

IF( HEPMC_FOUND )

    ADD_DEFINITIONS( -DHEPMC )
    TARGET_LINK_LIBRARIES(fittino ${HEPMC_LIBRARIES})

ENDIF()


IF( EIGEN3_FOUND )

    ADD_DEFINITIONS( -DEIGEN3 )

ENDIF()

IF( GM2CALC_FOUND )

    ADD_DEFINITIONS( -DGM2CALC )

ENDIF()

IF ( EIGEN3_FOUND AND GM2CALC_FOUND )

    TARGET_LINK_LIBRARIES( fittino ${GM2CALC_LIBRARIES}  )

ENDIF()


IF( FORTRANFLUSH_FOUND )

    ADD_DEFINITIONS( -DFORTRANFLUSH )
    TARGET_LINK_LIBRARIES( fittino  ${FORTRANFLUSH_LIBRARIES} )

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
        INCLUDE_DIRECTORIES( ${FEYNHIGGS_INCLUDE_DIRS} )
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

IF( X11_FOUND AND MICROMEGAS_FOUND )

    ADD_DEFINITIONS( -DMICROMEGAS )

    ADD_LIBRARY( sqmeaux SHARED IMPORTED )
    SET_TARGET_PROPERTIES( sqmeaux PROPERTIES IMPORTED_LOCATION ${MICROMEGAS_CALCHEP_SQMEAUX_LIBRARY}  )

    TARGET_LINK_LIBRARIES( fittino sqmeaux )
    TARGET_LINK_LIBRARIES( fittino ${MICROMEGAS_LIBRARIES} )  
    TARGET_LINK_LIBRARIES( fittino ${X11_LIBRARIES} )  

ENDIF()

INSTALL(TARGETS fittino RUNTIME DESTINATION bin)
