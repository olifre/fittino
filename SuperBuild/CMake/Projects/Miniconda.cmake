find_package( UnixCommands )
set_package_properties( UnixCommands PROPERTIES TYPE REQUIRED PURPOSE "Required by INSTALL_Python2 to run the bash installer of Miniconda." )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

    if( INSTALL_Python2 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.30.1-MacOSX-x86_64.sh )
        set( miniconda_url_md5 726cb6ba61196b5014918d836dd7a67a )
        set( Miniconda "Miniconda2-4.3.30.1")


    elseif( INSTALL_Python3 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda3-4.3.30.1-MacOSX-x86_64.sh )
        set( miniconda_url_md5 edd8037f8271314fdca00011987ce537 )
        set( Miniconda "Miniconda3-4.3.30.1")

    endif()

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86_64" )

    if( INSTALL_Python2 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.30-Linux-x86_64.sh )
        set( miniconda_url_md5 bd1655b4b313f7b2a1f2e15b7b925d03 )
        set( Miniconda "Miniconda2-4.3.30")

    elseif( INSTALL_Python3 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86_64.sh )
        set( miniconda_url_md5 0b80a152332a4ce5250f3c09589c7a81  )
        set( Miniconda "Miniconda3-4.3.30")

    endif()

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND ${CMAKE_HOST_SYSTEM_PROCESSOR} MATCHES "x86" )

    if( INSTALL_Python2 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda2-4.3.30-Linux-x86.sh )
        set( miniconda_url_md5 a8088c56572ae7f3ce51b16ce84317d9 )
        set( Miniconda "Miniconda2-4.3.30")

    elseif( INSTALL_Python3 )

        set( miniconda_url https://repo.continuum.io/miniconda/Miniconda3-4.3.30-Linux-x86.sh )
        set( miniconda_url_md5 c9518b83488c85d44505a44c03a0ea1e )
        set( Miniconda "Miniconda3-4.3.30")

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

