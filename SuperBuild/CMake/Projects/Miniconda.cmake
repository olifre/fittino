find_package( UnixCommands )
set_package_properties( UnixCommands PROPERTIES TYPE REQUIRED PURPOSE "Required by INSTALL_Python2 to run the bash installer of Miniconda." )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

    if( INSTALL_Python2 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.31-MacOSX-x86_64.sh )
        set( miniconda_url_md5 2c499488605bafd9e13a430f299f1489 )
        set( Miniconda "Miniconda2-4.3.31")


    elseif( INSTALL_Python3 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda3-4.3.31-MacOSX-x86_64.sh )
        set( miniconda_url_md5 03c2dedc466886459e968157c63197f3 )
        set( Miniconda "Miniconda3-4.3.31")

    endif()

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

    if( INSTALL_Python2 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.31-Linux-x86_64.sh )
        set( miniconda_url_md5 da2dd466d26e33a2b1f72fdb853a8ff0 )
        set( Miniconda "Miniconda2-4.3.31")

    elseif( INSTALL_Python3 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh )
        set( miniconda_url_md5 7fe70b214bee1143e3e3f0467b71453c )
        set( Miniconda "Miniconda3-4.3.31")

    endif()

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86" )

    if( INSTALL_Python2 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.31-Linux-x86.sh )
        set( miniconda_url_md5 4067ba22e1d687f92b11531a0b30b17f )
        set( Miniconda "Miniconda2-4.3.31")

    elseif( INSTALL_Python3 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86.sh )
        set( miniconda_url_md5 df2f9770d83df8269f3f43f1e60285e6 )
        set( Miniconda "Miniconda3-4.3.31")

    endif()

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

