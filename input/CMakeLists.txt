add_custom_target( input SOURCES ${PROJECT_SOURCE_DIR}/input )

set( builddir ${PROJECT_BINARY_DIR}/input )

file( COPY ${PROJECT_SOURCE_DIR}/input DESTINATION ${builddir} PATTERN ".svn" EXCLUDE )
#file(MAKE_DIRECTORY ${builddir} )

list( APPEND inputFiles steering/SModelS.in.xml )
list( APPEND inputFiles steering/MSSMTriLnV_low.xml  )
list( APPEND inputFiles steering/RPV.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RK_stop.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RD_313.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RD_323.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RD_333.xml )

list( APPEND inputFiles external/SModelS/parameters.ini )
list( APPEND inputFiles external/SPheno/pMSSM11.slha )

foreach( f ${inputFiles} )

    set_source_files_properties(${f} PROPERTIES HEADER_FILE_ONLY TRUE)
    configure_file( ${f} ${builddir}/${f} )

endforeach()

install( DIRECTORY ${builddir} DESTINATION share/fittino/input )

set( Fittino_INPUT_DIR ${CMAKE_INSTALL_PREFIX}/share/fittino/input )
