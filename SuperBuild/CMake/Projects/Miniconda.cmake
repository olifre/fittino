set( Miniconda "Miniconda2-4.5.11")

find_package( UnixCommands )
set_package_properties( UnixCommands PROPERTIES TYPE REQUIRED PURPOSE "Required by INSTALL_Python2 to run the bash installer of Miniconda." )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

    set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.5.11-MacOSX-x86_64.sh )
    set( miniconda_url_md5 a444da43ad50a83c332ea1fb7a5bb96c )

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh )
        set( miniconda_url_md5 458324438b7b0e5afcc272b63d44195d )

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86" )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.5.11-Linux-x86.sh )
        set( miniconda_url_md5 187c460ffc6ea5f890b512320b2994c6 )

else()

    message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} and CMAKE_HOST_SYSTEM_PROCESSOR is ${CMAKE_HOST_SYSTEM_PROCESSOR}." )

endif()

set( miniconda_install_command ${CMAKE_COMMAND} -E env HOME=<INSTALL_DIR> PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${BASH} <DOWNLOADED_FILE> -b -f -p <INSTALL_DIR> )

externalproject_add(

    ${Miniconda}
    URL ${miniconda_url}
    URL_MD5 ${miniconda_url_md5}
    CONFIGURE_COMMAND ""
    DOWNLOAD_NO_EXTRACT 1
    BUILD_COMMAND ""
    INSTALL_COMMAND ${miniconda_install_command}

)

externalproject_get_property( ${Miniconda} install_dir )

set( Miniconda_EXECUTABLE ${install_dir}/bin/conda )
set( Miniconda_PYTHONPATH "${install_dir}/lib/python2.7:${install_dir}/lib/python2.7/site-packages" )

