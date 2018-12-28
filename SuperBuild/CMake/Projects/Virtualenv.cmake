set( Virtualenv "Virtualenv-16.1.0" )

find_package( PythonInterp )
set_package_properties( PythonInterp PROPERTIES TYPE REQUIRED PURPOSE "Required by INSTALL_Python." )

externalproject_add(

        ${Virtualenv}
        URL https://github.com/pypa/virtualenv/tarball/16.1.0
        URL_MD5 ad6d2ebd6885b3a2b4ff2030ce532a2f
        #BUILD_IN_SOURCE ON
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ${PYTHON_EXECUTABLE} <SOURCE_DIR>/src/virtualenv.py <INSTALL_DIR>
)

externalproject_get_property( ${Virtualenv} install_dir )

set( PYTHON_EXECUTABLE ${install_dir}/bin/python )
set( PYTHON_INCLUDE_DIR ${install_dir}/include/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR} )

set( PYTHONPATH_STRING "${install_dir}/lib/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/site-packages" )

list( APPEND PATH ${install_dir}/bin )
list( APPEND PYTHONPATH "${PYTHONPATH_STRING}" )

list( APPEND CACHE_ARGS -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE} )
list( APPEND CACHE_ARGS -DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR} )

list( APPEND Fittino_DEPENDENCIES ${Virtualenv} )
