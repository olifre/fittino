
file( COPY ${PROJECT_SOURCE_DIR}/input/definitions DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )
file( COPY ${PROJECT_SOURCE_DIR}/input/style DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )
file( COPY ${PROJECT_SOURCE_DIR}/input/external DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )
file( COPY ${PROJECT_SOURCE_DIR}/input/steering DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )

list( APPEND inputFiles steering/SModelS.in.xml )
list( APPEND inputFiles steering/SCYNet.xml )
list( APPEND inputFiles steering/RPV.xml )
list( APPEND inputFiles steering/pMSSM11_LHCsimulation_SCYNet.in.xml )


list( APPEND inputFiles external/SModelS/parameters.ini )
list( APPEND inputFiles external/SPheno/pMSSM11.slha )
list( APPEND inputFiles external/SPheno/LesHouches.in.MSSMTriLnV_low )

foreach( f ${inputFiles} )

#  set_source_files_properties(${f} PROPERTIES HEADER_FILE_ONLY TRUE)
    configure_file( ${PROJECT_SOURCE_DIR}/input/${f} ${PROJECT_BINARY_DIR}/input/${f} )

endforeach()

message( "List of outputs ${outputs} ")


if( PYTHONINTERP_FOUND )

    foreach( f ${outputs} )
    message( "Configuring file ${f} ")
    #  set_source_files_properties(${f} PROPERTIES HEADER_FILE_ONLY TRUE)
    configure_file( ${PROJECT_BINARY_DIR}/input-gen/${f} ${PROJECT_BINARY_DIR}/input/${f} )

    endforeach()

endif()
