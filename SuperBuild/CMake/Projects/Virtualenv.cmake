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

set( pythonIncludeDir include/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR} )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" )

    set( pythonLibrary lib/libpython${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}.dylib )

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" )

    set( pythonLibrary lib/libpython${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}.so )

else()

    message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} but only Darwin and Linux are supported." )

endif()

list( APPEND CACHE_ARGS -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE} )
list( APPEND CACHE_ARGS -DPYTHON_INCLUDE_DIR:PATH=${install_dir}/${pythonIncludeDir} )

list( APPEND PATH ${install_dir}/bin )

list( APPEND Fittino_DEPENDENCIES ${Virtualenv} )
