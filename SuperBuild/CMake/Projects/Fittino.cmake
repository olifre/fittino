set( Fittino Fittino )

list( APPEND CACHE_ARGS "-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>" )

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

externalproject_add(

    ${Fittino}
    DEPENDS ${Fittino_DEPENDENCIES}
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..
    BUILD_ALWAYS ON
    #BUILD_COMMAND ""
    CMAKE_CACHE_ARGS ${CACHE_ARGS}
# CMAKE_GENERATOR Xcode

)

externalproject_get_property( ${Fittino} install_dir )
set( Fittino_ROOT_DIR ${install_dir} )

list( APPEND PATH ${install_dir}/bin )

# ExternalProject_Add_StepDependencies( ${Fittino} configure ${CMAKE_CURRENT_BINARY_DIR}/init.cmake )
