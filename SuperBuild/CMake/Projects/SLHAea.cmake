set( SLHAea SLHAea-0.1 )

externalproject_add(

        ${SLHAea}
        URL https://github.com/fthomas/slhaea/archive/v0.1.tar.gz
        URL_MD5 167da979fe62ebbfde09eabb28543cf9
        CONFIGURE_COMMAND ""
        PATCH_COMMAND ${CMAKE_COMMAND} -DSRCFILE=slhaea.h -P ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SLHAea.cmake
        BUILD_COMMAND ""
        INSTALL_COMMAND ""

    )

externalproject_get_property( ${SLHAea} source_dir )

ExternalProject_Add_StepDependencies( ${SLHAea} download ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Scripts/patch_SLHAea.cmake )

list( APPEND CACHE_ARGS -DSLHAEA_INCLUDE_DIR:PATH=${source_dir} )

list( APPEND Fittino_DEPENDENCIES ${SLHAea} )
