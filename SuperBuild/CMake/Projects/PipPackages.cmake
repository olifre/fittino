if( INSTALL_Python2 )

    set( PipPackages "PipPackages2-1")
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/PipPackages2.txt" )
    set( libs "lib/python2.7/site-packages" )

elseif( INSTALL_Python3 )

    set( PipPackages "PipPackages3-1")

    if( USE_WCxf )

        set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/PipPackages3.txt" )

    else()

        set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/PipPackages3_Flavio-0.24.txt" )


    endif()

    set( libs "lib/python3.6/site-packages" )

endif()

set( download_command ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH  ${PYTHON_EXECUTABLE} -m pip download --find-links . --no-cache-dir -b <BINARY_DIR> -r ${requirements} --no-deps --dest . )

if( BUILD_OFFLINE )

    list( APPEND download_command --no-index )

endif()

# TODO this should become the build step once CMake 3.11.0 (which supports DOWNLOAD_DIR) is widely available (compare condapackages)
LIST( APPEND download_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${PYTHON_EXECUTABLE} -m pip install --find-links . --no-cache-dir -b <BINARY_DIR> -r ${requirements} --no-deps --prefix <INSTALL_DIR> --no-index )

externalproject_add(

    ${PipPackages}
    DEPENDS ${CondaPackages}
    DOWNLOAD_NO_EXTRACT
    DOWNLOAD_COMMAND ${download_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Flavio_patch/flha.py <INSTALL_DIR>/${libs}/flavio/io/flha.py

)

ExternalProject_Add_StepDependencies( ${PipPackages} download ${requirements} )
ExternalProject_Add_StepDependencies( ${PipPackages} install ${CMAKE_CURRENT_SOURCE_DIR}/Flavio_patch/flha.py )

externalproject_get_property( ${PipPackages} install_dir )

list( APPEND PYTHONPATH "${install_dir}/${libs}" )
