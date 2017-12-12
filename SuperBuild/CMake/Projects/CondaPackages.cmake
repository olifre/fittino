if( INSTALL_Python2 )

    set( CondaPackages "CondaPackages2-1" )
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/CondaPackages2.txt" )

elseif( INSTALL_Python3 )

    set( CondaPackages "CondaPackages3-1" )
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/Requirements/CondaPackages3.txt" )

endif()

set( install_command ${CMAKE_COMMAND} -E env CONDA_PKGS_DIRS=. PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${Miniconda_EXECUTABLE} remove -y  --prefix <INSTALL_DIR> --all )

# TODO: when conda 4.4 is released containing the --download-only flag (see https://github.com/conda/conda/commit/962eae0eb1c14d0b23c388b2a218b95379fb32d8 ) and cmake substitutes download_dir, this can be split into download and install step (compare PipPackages)

list( APPEND install_command COMMAND ${CMAKE_COMMAND} -E env CONDA_PKGS_DIRS=. PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${Miniconda_EXECUTABLE} create -y --no-deps --no-update-deps --prefix <INSTALL_DIR> --file ${requirements} )

if( BUILD_OFFLINE )

    list( APPEND install_command --offline --use-index-cache )

endif()

externalproject_add(

    ${CondaPackages}
    DEPENDS ${Miniconda}
    DOWNLOAD_NO_EXTRACT
    DOWNLOAD_COMMAND ${install_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""

)

ExternalProject_Add_StepDependencies( ${CondaPackages} download ${requirements} )

externalproject_get_property( ${CondaPackages} install_dir )

# set filepath according to https://cmake.org/cmake/help/v3.10/module/FindPythonInterp.html
set( PYTHON_EXECUTABLE ${install_dir}/bin/python )

list( APPEND CACHE_ARGS -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE} )

list( APPEND PATH ${install_dir}/bin )

list( APPEND Fittino_DEPENDENCIES ${CondaPackages} )
