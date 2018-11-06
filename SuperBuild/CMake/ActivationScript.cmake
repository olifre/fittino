set( script ${CMAKE_CURRENT_BINARY_DIR}/activate.sh )

file( WRITE ${script} "#!/usr/bin/env bash\n\n" )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" )

    set( ldLibraryPathName "DYLD_LIBRARY_PATH" )

    if( INSTALL_CheckMATE )

        file( APPEND ${script} "mkdir -p @rpath\n" )
        file( APPEND ${script} "ln -fs ${Delphes_ROOT_DIR}/lib/libDelphes.dylib @rpath\n" )
        file( APPEND ${script} "ln -fs ${HepMC2_ROOT_DIR}/lib/libHepMC.4.dylib\n" )
        file( APPEND ${script} "ln -fs ${HepMC2_ROOT_DIR}/lib/libHepMCfio.4.dylib\n\n" )

    endif()

elseif( ${CMAKE_SYSTEM_NAME} MATCHES "Linux" )

    set( ldLibraryPathName "LD_LIBRARY_PATH" )

else()

    message( FATAL_ERROR "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME} but only Darwin and Linux are supported." )

endif()

if( INSTALL_Python2 OR INSTALL_Python3 )

    file( APPEND ${script} "unset PYTHONPATH\n" )
    file( APPEND ${script} "export PYTHONNOUSERSITE=1\n" )

endif()

foreach( dir IN LISTS PYTHONPATH )

    file( APPEND ${script} "export PYTHONPATH=${dir}:$PYTHONPATH\n" )

endforeach()

foreach( dir IN LISTS PATH )

    file( APPEND ${script} "export PATH=${dir}:$PATH\n" )

endforeach()


foreach( dir IN LISTS ldLibraryPathValue )

    file( APPEND ${script} "export ${ldLibraryPathName}=${dir}:$${ldLibraryPathName}\n" )

endforeach()

if( INSTALL_Fittino )

    file( APPEND ${script} "export FITTINO_ROOT_DIR=${Fittino_ROOT_DIR}\n" )
    file( APPEND ${script} "export FITTINO_INPUT_DIR=${Fittino_ROOT_DIR}/share/fittino/input\n" )

endif()

