set( src )

list( APPEND src Doxyfile )
list( APPEND src Doxyfile.in )
list( APPEND src html )
list( APPEND src images )
list( APPEND src StyleGuide.dox )
list( APPEND src Input.md )

add_custom_target( docfiles SOURCES ${src} )

list( APPEND xmlFiles ${PROJECT_SOURCE_DIR}/input/steering/SModelS.in.xml )
list( APPEND xmlFiles ${PROJECT_SOURCE_DIR}/input/steering/pMSSM11_LHCsimulation_SCYNet.in.xml )


if( PYTHONINTERP_FOUND )

    list( APPEND xmlFiles ${PROJECT_BINARY_DIR}/input-gen/steering/MSSMTriLnV_RK_stop.xml )
    list( APPEND xmlFiles ${PROJECT_BINARY_DIR}/input-gen/steering/MSSMTriLnV_RK_stop_Arg_lambdaPrime_233.xml )

endif()

find_package( LibXslt )

if( LIBXSLT_XSLTPROC_EXECUTABLE )

    foreach( f ${xmlFiles} )

        get_filename_component( fn ${f} NAME_WE )
        list( APPEND com COMMAND ${LIBXSLT_XSLTPROC_EXECUTABLE} -o ${fn}.html ${PROJECT_SOURCE_DIR}/input/style/InputFile.xsl ${f} )
        set( HTML_EXTRA_FILES "${HTML_EXTRA_FILES} ${fn}.html" )

    endforeach( )

endif()

if( DOXYGEN_FOUND )

    list( APPEND com COMMAND ${DOXYGEN_EXECUTABLE} )
    CONFIGURE_FILE( ${PROJECT_SOURCE_DIR}/doc/Doxyfile.in ${PROJECT_BINARY_DIR}/doc/Doxyfile @ONLY )

endif()

list( APPEND com WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/doc DEPENDS input-gen )

if( DOXYGEN_FOUND AND LIBXSLT_XSLTPROC_EXECUTABLE )

    ADD_CUSTOM_TARGET( doc  ${com} )
    INSTALL( DIRECTORY "${PROJECT_BINARY_DIR}/doc/html" DESTINATION share/doc/fittino OPTIONAL )

endif()

