set( MSSMTriLnV MSSMTriLnV )

enable_language( Fortran )

# see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

externalproject_add(

    ${MSSMTriLnV}
    DEPENDS ${SPheno}
    URL ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV
    SOURCE_DIR ${SPheno_ROOT_DIR}/MSSMTriLnV
    PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SPheno.cmake
    CONFIGURE_COMMAND ""
    BINARY_DIR ${SPheno_ROOT_DIR}
    BUILD_COMMAND $(MAKE) Model=MSSMTriLnV F90=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ""

)

ExternalProject_Add_StepDependencies( ${MSSMTriLnV} download ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SPheno.cmake ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV )

list( APPEND CACHE_ARGS -DSPheno_MSSMTriLnV_EXECUTABLE:FILEPATH=${SPheno_ROOT_DIR}/bin/SPhenoMSSMTriLnV )

list( APPEND Fittino_DEPENDENCIES ${MSSMTriLnV} )
