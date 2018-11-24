if ( PATH )

    file( APPEND ${activationScript} "\n" )

endif()

foreach( dir IN LISTS PATH )

    file( APPEND ${activationScript} "export PATH=${dir}:$PATH\n" )

endforeach()

if ( ldLibraryPathValue )

    file( APPEND ${activationScript} "\n" )

endif()

foreach( dir IN LISTS ldLibraryPathValue )

    file( APPEND ${activationScript} "export ${ldLibraryPathName}=${dir}:$${ldLibraryPathName}\n" )

endforeach()

if ( PYTHONPATH )

    file( APPEND ${activationScript} "\n" )

endif()

foreach( dir IN LISTS PYTHONPATH )

    file( APPEND ${activationScript} "export PYTHONPATH=${dir}:$PYTHONPATH\n" )

endforeach()
