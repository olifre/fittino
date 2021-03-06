set( Fittino Fittino )

list( APPEND CACHE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>" )
list( APPEND CACHE_ARGS "-DCMAKE_CXX_STANDARD:STRING=${CMAKE_CXX_STANDARD}" )
#list( APPEND CACHE_ARGS "-DROOT_CONFIG_EXECUTABLE:FILEPATH=${ROOT_CONFIG_EXECUTABLE}" )


check_language( Fortran )

if( CMAKE_Fortran_COMPILER )

    enable_language( Fortran )

    list( APPEND CACHE_ARGS "-DCMAKE_Fortran_COMPILER:FILEPATH=${CMAKE_Fortran_COMPILER}" )

endif()

check_language( C )

if( CMAKE_C_COMPILER )

    enable_language( C )

    list( APPEND CACHE_ARGS "-DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}" )

endif()

enable_language( CXX )
list( APPEND CACHE_ARGS "-DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}" )

list( APPEND CACHE_ARGS "-DCMAKE_DISABLE_FIND_PACKAGE_PythonLibs:BOOL=${CMAKE_DISABLE_FIND_PACKAGE_PythonLibs}" )

list( APPEND CACHE_ARGS "-DUSE_WCxf:BOOL=${USE_WCxf}" )

set( Fittino_CMAKE_GENERATOR ${CMAKE_GENERATOR} CACHE STRING "" )

if( INSTALL_Python2 OR INSTALL_Python3 )

    list( APPEND fittinoInstallCommand ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 PYTHONPATH=${PYTHONPATH_STRING} )

endif()

if( Fittino_CMAKE_GENERATOR STREQUAL "Unix Makefiles" )

    list( APPEND fittinoInstallCommand $(MAKE) install )

else()

    list( APPEND fittinoInstallCommand ${CMAKE_COMMAND} --build . --target install )

endif()


externalproject_add(

    ${Fittino}
    DEPENDS ${Fittino_DEPENDENCIES}
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..
    BUILD_ALWAYS ON
    BUILD_COMMAND ""
    INSTALL_COMMAND ${fittinoInstallCommand}
    CMAKE_CACHE_ARGS ${CACHE_ARGS}
    CMAKE_GENERATOR ${Fittino_CMAKE_GENERATOR}

)

externalproject_get_property( ${Fittino} install_dir )
set( Fittino_ROOT_DIR ${install_dir} )

file( APPEND ${activationScript} "\n")
file( APPEND ${activationScript} "source ${install_dir}/bin/activate.sh ")

# ExternalProject_Add_StepDependencies( ${Fittino} configure ${CMAKE_CURRENT_BINARY_DIR}/init.cmake )
