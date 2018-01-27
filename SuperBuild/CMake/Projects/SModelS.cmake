set( SModelS SModelS-7e4c32cc6de1174a8a78c266e04b4e85c10a193a )

enable_language( Fortran ) # for Pythia6 & NLL_FAST
enable_language( CXX ) # for Pythia8

find_package( UnixCommands )
set_package_properties( UnixCommands PROPERTIES TYPE REQUIRED PURPOSE "Required by INSTALL_SModels to untar the SModelS database." )

externalproject_add(

    ${SModelS}
    DEPENDS ${PipPackages} ${Pythia8Download}
    URL https://github.com/smodels/smodels/archive/7e4c32cc6de1174a8a78c266e04b4e85c10a193a.zip
    URL_MD5 aa676ebd3892c827a01c2789634ddf12
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Pythia8Download_FILE} <SOURCE_DIR>/smodels/lib/pythia8/.pythia8226.tgz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${CMAKE_COMMAND} -E chdir <SOURCE_DIR> $(MAKE) FCC=${CMAKE_Fortran_COMPILER} CXX=${CMAKE_CXX_COMPILER} PYTHIAVER=8226

    COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${PYTHON_EXECUTABLE} -m pip install <SOURCE_DIR> --prefix=<INSTALL_DIR> --no-cache-dir -b <BINARY_DIR> --no-deps --no-index
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/smodels-database <INSTALL_DIR>/smodels-database
    # see http://smodels.readthedocs.io/en/latest/Installation.html#adding-fastlim-data
    COMMAND ${CMAKE_COMMAND} -E chdir <INSTALL_DIR>/smodels-database ${TAR} -xzvf smodels-v1.1-fastlim-1.0.tgz
    COMMAND ${CMAKE_COMMAND} -E  remove -f <INSTALL_DIR>/smodels-database/smodels-v1.1-fastlim-1.0.tgz

)

externalproject_get_property( ${SModelS} install_dir )

list( APPEND CACHE_ARGS -DSModelS_Tools_EXECUTABLE:FILEPATH=${install_dir}/bin/smodelsTools.py )
list( APPEND CACHE_ARGS -DSModelS_Database_DIR:PATH=${install_dir}/smodels-database )

list( APPEND PYTHONPATH "${install_dir}/lib/python2.7/site-packages" )
list( APPEND PATH "${install_dir}/bin" )

list( APPEND Fittino_DEPENDENCIES ${SModelS} )
