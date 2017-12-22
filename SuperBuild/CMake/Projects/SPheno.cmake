set( SPheno SPheno-4.0.3 )

enable_language( Fortran )

externalproject_add(

    ${SPheno}
    URL http://www.hepforge.org/archive/spheno/SPheno-4.0.3.tar.gz
    URL_MD5 64787d6c8ce03cac38aec53d34ac46ad
    PATCH_COMMAND ${CMAKE_COMMAND} -DMAKEFILE=src/Makefile -P ${CMAKE_SOURCE_DIR}/CMake/Scripts/patch_SPheno.cmake
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/SPheno_patch <SOURCE_DIR>/src
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND $(MAKE) F90=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ""

)

externalproject_get_property( ${SPheno} source_dir )

list( APPEND CACHE_ARGS "-DSPheno_EXECUTABLE:FILEPATH=${source_dir}/bin/SPheno" )

list( APPEND PATH ${source_dir}/bin )

set( SPheno_ROOT_DIR ${source_dir} )

list( APPEND Fittino_DEPENDENCIES ${SPheno} )
