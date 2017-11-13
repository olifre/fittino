if( INSTALL_PYTHON2 )

    set( pippackages "PipPackages2-1")
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements_PipPackages2.txt" )

else()

    set( pippackages "PipPackages3-1")
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements_PipPackages3.txt" )

endif()

set( download_command ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH  ${condapackages_root_dir}/bin/pip download --find-links . --no-cache-dir -b <BINARY_DIR> -r ${requirements} --no-deps --dest . )

if( BUILD_OFFLINE )

    list( APPEND download_command --no-index )

endif()

LIST( APPEND download_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${condapackages_root_dir}/bin/pip install --find-links . --no-cache-dir -b <BINARY_DIR> -r ${requirements} --no-deps --prefix <INSTALL_DIR> --no-index )

externalproject_add(

    ${pippackages}
    DEPENDS ${condapackages}
    DOWNLOAD_NO_EXTRACT
    DOWNLOAD_COMMAND ${download_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""

)
