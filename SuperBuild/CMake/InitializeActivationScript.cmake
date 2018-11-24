
if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" )

    set( ldLibraryPathName "DYLD_LIBRARY_PATH" )

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" )

    set( ldLibraryPathName "LD_LIBRARY_PATH" )

else()

    message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} but only Darwin and Linux are supported." )

endif()

set( activationScript ${CMAKE_CURRENT_BINARY_DIR}/activate.sh )
file( WRITE ${activationScript} "#!/usr/bin/env bash\n" )
