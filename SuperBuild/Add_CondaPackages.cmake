if( INSTALL_PYTHON2 )

    set( condapackages "CondaPackages2-1" )
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/CondaPackages2_Requirements.txt" )

else()

    set( condapackages "CondaPackages3-1" )
    set( requirements "${CMAKE_CURRENT_SOURCE_DIR}/CondaPackages3_Requirements.txt" )

endif()

set( install_command ${CMAKE_COMMAND} -E env CONDA_PKGS_DIRS=. PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${miniconda_root_dir}/bin/conda remove  -y  --prefix <INSTALL_DIR> --all )

list( APPEND install_command COMMAND ${CMAKE_COMMAND} -E env CONDA_PKGS_DIRS=. PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${miniconda_root_dir}/bin/conda create -y --no-deps --no-update-deps --prefix <INSTALL_DIR> --file ${requirements} )

if( BUILD_OFFLINE )

    list( APPEND install_command --offline --use-index-cache )

endif()

externalproject_add(

    ${condapackages}
    DEPENDS ${miniconda}
    DOWNLOAD_NO_EXTRACT
    DOWNLOAD_COMMAND ${install_command}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""

)

externalproject_get_property( ${condapackages} install_dir )
set( condapackages_root_dir ${install_dir} )
