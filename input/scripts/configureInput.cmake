
file( COPY ${PROJECT_SOURCE_DIR}/input/definitions DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )
file( COPY ${PROJECT_SOURCE_DIR}/input/style DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )
file( COPY ${PROJECT_SOURCE_DIR}/input/external DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )
file( COPY ${PROJECT_SOURCE_DIR}/input/steering DESTINATION ${PROJECT_BINARY_DIR}/input PATTERN ".svn" EXCLUDE )



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
