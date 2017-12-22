set( MSSMTriLnV MSSMTriLnV )

enable_language( Fortran )

set( MSSMTriLnV_URL "~/Downloads/MSSMTriLnV.tgz" CACHE FILEPATH "" )
set( MSSMTriLnV_MD5 eb54d22459a6f9482fd4e959c69ff00e )

# see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

externalproject_add(

    ${MSSMTriLnV}
    DEPENDS ${SPheno}
    URL ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV
    #URL_MD5 ${MSSMTriLnV_MD5}
    PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SPheno.cmake
    #COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV_patch <SOURCE_DIR>
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> ${SPheno_ROOT_DIR}/MSSMTriLnV
    BINARY_DIR ${SPheno_ROOT_DIR}
    BUILD_COMMAND $(MAKE) Model=MSSMTriLnV F90=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ""

)

ExternalProject_Add_StepDependencies( ${MSSMTriLnV} patch ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SPheno.cmake ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV )

list( APPEND CACHE_ARGS -DSPheno_MSSMTriLnV_EXECUTABLE:FILEPATH=${SPheno_ROOT_DIR}/bin/SPhenoMSSMTriLnV )

list( APPEND Fittino_DEPENDENCIES ${MSSMTriLnV} )
