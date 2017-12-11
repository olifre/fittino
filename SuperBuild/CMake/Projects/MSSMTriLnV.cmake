set( MSSMTriLnV MSSMTriLnV )

enable_language( Fortran )

set( MSSMTriLnV_URL "~/Downloads/MSSMTriLnV.tgz" CACHE FILEPATH "" )
set( MSSMTriLnV_MD5 eb54d22459a6f9482fd4e959c69ff00e )

# see https://sarah.hepforge.org/sarah_in_a_nutshell.pdf

externalproject_add(

    ${MSSMTriLnV}
    DEPENDS ${SPheno}
    URL ${MSSMTriLnV_URL}
    URL_MD5 ${MSSMTriLnV_MD5}
    PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=Makefile -P ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SPheno.cmake
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/MSSMTriLnV_patch <SOURCE_DIR>
    BUILD_IN_SOURCE 0
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> ${SPheno_ROOT_DIR}/MSSMTriLnV
    BINARY_DIR ${SPheno_ROOT_DIR}
    BUILD_COMMAND $(MAKE) Model=MSSMTriLnV F90=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ""

)

list( APPEND CACHE_ARGS -DSPheno_MSSMTriLnV_EXECUTABLE=${SPheno_ROOT_DIR}/bin/SPhenoMSSMTriLnV )

list( APPEND Fittino_DEPENDENCIES ${MSSMTriLnV} )
