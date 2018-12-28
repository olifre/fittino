set( SModelS SModelS-a1fd1bb22989457049daad8a93235f41e17e68ed )

enable_language( Fortran ) # for Pythia6 & NLL_FAST
enable_language( CXX ) # for Pythia8

find_package( UnixCommands )
set_package_properties( UnixCommands PROPERTIES TYPE REQUIRED PURPOSE "Required by INSTALL_SModels to untar the SModelS database." )

externalproject_add(

    ${SModelS}
    DEPENDS ${Virtualenv} ${Pythia8Download}
    URL https://github.com/smodels/smodels/archive/a1fd1bb22989457049daad8a93235f41e17e68ed.zip
    URL_MD5 628478ce03e9293c16a4de0445357921
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${Pythia8Download_FILE} <SOURCE_DIR>/smodels/lib/pythia8/.pythia8226.tgz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${CMAKE_COMMAND} -E chdir <SOURCE_DIR>/smodels/lib $(MAKE) FCC=${CMAKE_Fortran_COMPILER} CXX=${CMAKE_CXX_COMPILER} FC=${CMAKE_Fortran_COMPILER} PYTHIAVER=8226

    INSTALL_COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 PYTHONPATH=${PYTHONPATH_STRING} ${PYTHON_EXECUTABLE} -m pip install <SOURCE_DIR> --prefix=<INSTALL_DIR> --no-cache-dir -b <BINARY_DIR> --no-deps --no-index
     COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/smodels-database <INSTALL_DIR>/smodels-database
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
