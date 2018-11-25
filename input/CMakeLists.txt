
file( MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/input-gen )
file( MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/input-gen/steering )

if( PYTHONINTERP_FOUND )

    list( APPEND outputs steering/MSSMTriLnV_RD_313.xml )
    list( APPEND outputs steering/MSSMTriLnV_RD_323.xml )
    list( APPEND outputs steering/MSSMTriLnV_RD_333.xml )
    list( APPEND outputs steering/MSSMTriLnV_gRatios.xml )
    list( APPEND outputs steering/MSSMTriLnV_Decoupling_01.xml )
    list( APPEND outputs steering/MSSMTriLnV_Decoupling_10.xml )
    list( APPEND outputs steering/MSSMTriLnV_RK.xml )
    list( APPEND outputs steering/MSSMTriLnV_RK_stop.xml )
    list( APPEND outputs steering/MSSMTriLnV_RK_stop_Arg_lambdaPrime_233.xml )
    list( APPEND outputs steering/MSSMTriLnV_RK_stop_233.xml )
    list( APPEND outputs steering/MSSMTriLnV_RKstar.xml )
    list( APPEND outputs steering/MSSMTriLnV_RKRKstar.xml )



    foreach( f ${outputs} )

        list(APPEND fulloutputs ${PROJECT_BINARY_DIR}/input-gen/${f} )

    endforeach()

    add_custom_command( OUTPUT ${fulloutputs}
                    COMMAND ${PYTHON_EXECUTABLE}
                    ARGS ${PROJECT_SOURCE_DIR}/input/scripts/createMSSMTriLnVfiles.py ${PROJECT_SOURCE_DIR}/input/scripts/MSSMTriLnV_Raw.xml
                    DEPENDS ${PROJECT_SOURCE_DIR}/input/scripts/createMSSMTriLnVfiles.py ${PROJECT_SOURCE_DIR}/input/scripts/MSSMTriLnV_Raw.xml
                    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/input-gen/steering )

    add_custom_target( input-gen ALL DEPENDS ${fulloutputs} )

endif()

set( Fittino_INPUT_DIR ${CMAKE_INSTALL_PREFIX}/share/fittino/input )
set( Fittino_DATA_DIR ${CMAKE_INSTALL_PREFIX}/share/fittino/data )

list( APPEND confargs -DPROJECT_BINARY_DIR=${PROJECT_BINARY_DIR} )
list( APPEND confargs -DPROJECT_SOURCE_DIR=${PROJECT_SOURCE_DIR} )
list( APPEND confargs -DFittino_INPUT_DIR=${Fittino_INPUT_DIR} )
list( APPEND confargs -DFittino_DATA_DIR=${Fittino_DATA_DIR} )
list( APPEND confargs -DPYTHONINTERP_FOUND=${PYTHONINTERP_FOUND} )
list( APPEND confargs -DSPheno_EXECUTABLE=${SPheno_EXECUTABLE} )
list( APPEND confargs -DSPheno_MSSMTriLnV_EXECUTABLE=${SPheno_MSSMTriLnV_EXECUTABLE} )
list( APPEND confargs -DSModelS_Database_DIR=${SModelS_Database_DIR} )
list( APPEND confargs -DSModelS_Tools_EXECUTABLE=${SModelS_Tools_EXECUTABLE} )
list( APPEND confargs -DMadGraph5_EXECUTABLE=${MadGraph5_EXECUTABLE} )
list( APPEND confargs -DCheckMATE_EXECUTABLE=${CheckMATE_EXECUTABLE} )
list( APPEND confargs -DCheckMATE_TESTFILE=${CheckMATE_TESTFILE} )
list( APPEND confargs -DProspino_EXECUTABLE=${Prospino_EXECUTABLE} )


list( APPEND installDirs definitions )
list( APPEND installDirs style )
list( APPEND installDirs external )
list( APPEND installDirs steering )

list( APPEND inputFiles steering/SModelS.in.xml )
list( APPEND inputFiles steering/SCYNet.xml )
list( APPEND inputFiles steering/RPV.xml )
list( APPEND inputFiles steering/pMSSM11_LHCsimulation_SCYNet.in.xml )
list( APPEND inputFiles external/SModelS/parameters.ini )
list( APPEND inputFiles external/SPheno/pMSSM11.slha )
list( APPEND inputFiles external/SPheno/LesHouches.in.MSSMTriLnV_low )
list( APPEND inputFiles external/CheckMATE/testparam_with_analysis.dat )
list( APPEND inputFiles steering/TestCLs.xml )



add_custom_command( OUTPUT ${installDirs}
                    COMMAND ${CMAKE_COMMAND} "-Doutputs=${outputs}" "-DinputFiles=${inputFiles}" ${confargs} -P ${PROJECT_SOURCE_DIR}/input/scripts/configureInput.cmake
DEPENDS ${PROJECT_SOURCE_DIR}/input/scripts/configureInput.cmake ${fulloutputs} ${PROJECT_SOURCE_DIR}/input/ ${inputFiles}
                    VERBATIM )

add_custom_target( input-conf ALL DEPENDS ${installDirs})

foreach( dir ${installDirs} )

    install( DIRECTORY ${PROJECT_BINARY_DIR}/input/${dir} DESTINATION share/fittino/input )

endforeach()

