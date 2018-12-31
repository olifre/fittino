set ( pkgs )
set( libs "lib/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/site-packages" )

if( INSTALL_Python2 )

    set( PipPackages "PipPackages2-1")
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/PipPackages2.txt" )
    list( APPEND  pkgs cython numpy scipy matplotlib nose tensorflow docutils keras requests ipython plotly pandas argparse Unum tex2pix pyslha  )

# see https://github.com/tensorflow/tensorflow/issues/6341#issuecomment-377804376
    set( install_command ${CMAKE_COMMAND} -E touch <INSTALL_DIR>/${libs}/google/__init__.py )

elseif( INSTALL_Python3 )

    set( PipPackages "PipPackages3-1")
    list( APPEND pkgs numpy scipy matplotlib nose pyyaml mpmath ckmutil rundec wcxf wetrunner flavio )

    set( install_command {CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/Flavio_patch/flha.py <INSTALL_DIR>/${libs}/flavio/io/flha.py )

    if( USE_WCxf )

        set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/PipPackages3.txt" )

    else()

        set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/PipPackages3_Flavio-0.24.txt" )


    endif()

endif()

set( download_command ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 PYTHONPATH=${PYTHONPATH_STRING} ${PYTHON_EXECUTABLE} -m pip download --find-links . --no-cache-dir -b <BINARY_DIR> --dest . )

if( BUILD_OFFLINE )

    list( APPEND download_command --no-index )

endif()

set( pythonPath "<INSTALL_DIR>/${libs}:${PYTHONPATH_STRING}" )

set( build_command COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 PYTHONPATH=${pythonPath} ${PYTHON_EXECUTABLE} -m pip install --find-links <DOWNLOAD_DIR> --no-cache-dir -b <BINARY_DIR> --prefix <INSTALL_DIR> --no-index )

if( Python_REQUIREMENTSFILE )

    list( APPEND download_command --no-deps -r ${requirements} COMMAND ${download_command} --no-deps iminuit==1.3.3 argparse==1.4.0 )
    list( APPEND build_command --no-deps -r ${requirements} COMMAND ${build_command} --no-deps iminuit==1.3.3 argparse==1.4.0 )

else()

    list( APPEND download_command ${pkgs} iminuit )
    list( APPEND build_command ${pkgs} COMMAND ${build_command} iminuit )
    #list( APPEND build_command COMMAND ${build_command} iminuit )

endif()

externalproject_add(

    ${PipPackages}
    DEPENDS ${Virtualenv}
    #DOWNLOAD_NO_EXTRACT
    DOWNLOAD_COMMAND ${download_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${build_command}
    INSTALL_COMMAND ${install_command}

)

ExternalProject_Add_StepDependencies( ${PipPackages} download ${requirements} )
ExternalProject_Add_StepDependencies( ${PipPackages} install ${CMAKE_CURRENT_SOURCE_DIR}/Flavio_patch/flha.py )

externalproject_get_property( ${PipPackages} install_dir )

list( APPEND PYTHONPATH "${install_dir}/${libs}" )
