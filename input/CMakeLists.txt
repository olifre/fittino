set( src )
list( APPEND src definitions )
list( APPEND src style )
list( APPEND src external )
list( APPEND src steering )
list( APPEND src prospino_main.f90 )
add_custom_target( input SOURCES ${src} )

file( COPY ${PROJECT_SOURCE_DIR}/input DESTINATION ${PROJECT_BINARY_DIR} PATTERN ".svn" EXCLUDE )
#file(MAKE_DIRECTORY ${builddir} )

list( APPEND inputFiles steering/SModelS.in.xml )
list( APPEND inputFiles steering/SCYNet.xml )
list( APPEND inputFiles steering/MSSMTriLnV_low.xml  )
list( APPEND inputFiles steering/RPV.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RK_stop.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RD_313.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RD_323.xml )
list( APPEND inputFiles steering/MSSMTriLnV_RD_333.xml )
list( APPEND inputFiles steering/MSSMTriLnV_gRatios.xml )

list( APPEND inputFiles external/SModelS/parameters.ini )
list( APPEND inputFiles external/SPheno/pMSSM11.slha )

set( Fittino_INPUT_DIR ${CMAKE_INSTALL_PREFIX}/share/fittino/input )

foreach( f ${inputFiles} )

    set_source_files_properties(${f} PROPERTIES HEADER_FILE_ONLY TRUE)
    configure_file( ${f} ${PROJECT_BINARY_DIR}/input/${f} )

endforeach()

install( DIRECTORY ${PROJECT_BINARY_DIR}/input DESTINATION share/fittino )
