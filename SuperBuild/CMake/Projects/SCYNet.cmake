set( SCYNet SCYNet )

externalproject_add(

    ${SCYNet}
    DEPENDS ${PipPackages}
    URL ${CMAKE_CURRENT_SOURCE_DIR}/SCYNet
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""

)

externalproject_get_property( ${SCYNet} source_dir )

list( APPEND PYTHONPATH ${source_dir} )

list( APPEND Fittino_DEPENDENCIES ${SCYNet} )
