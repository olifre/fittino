set( SCYNet SCYNet-r256 )

if( BUILD_OFFLINE )

    set( download_command "" )

else()

    find_package( Subversion )
    set_package_properties( Subversion PROPERTIES TYPE REQUIRED PURPOSE "Required for download of SCYNet." )


set( download_command ${Subversion_SVN_EXECUTABLE} co https://svn.physik.uni-bonn.de/basic/fittino-protected/trunk/SCYNet -r 256 --non-interactive . )

endif()

list( APPEND download_command COMMAND ${CMAKE_COMMAND} -E copy_directory . <SOURCE_DIR> )

externalproject_add(

    ${SCYNet}
    DEPENDS ${PipPackages}
    DOWNLOAD_COMMAND ${download_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""

)

externalproject_get_property( ${SCYNet} source_dir )

list( APPEND PYTHONPATH ${source_dir} )

list( APPEND Fittino_DEPENDENCIES ${SCYNet} )
