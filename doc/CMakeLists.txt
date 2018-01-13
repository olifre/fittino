set( src )

list( APPEND src Doxyfile )
list( APPEND src Doxyfile.in )
list( APPEND src html )
list( APPEND src images )
list( APPEND src StyleGuide.dox )

add_custom_target( docfiles SOURCES ${src} )

If( DOXYGEN_FOUND )

    CONFIGURE_FILE( ${PROJECT_SOURCE_DIR}/doc/Doxyfile.in ${PROJECT_BINARY_DIR}/Doxyfile @ONLY )
    ADD_CUSTOM_TARGET( doc ${DOXYGEN_EXECUTABLE} WORKING_DIRECTORY ${PROJECT_BINARY_DIR} )
    INSTALL( DIRECTORY "${PROJECT_BINARY_DIR}/html" DESTINATION share/doc/fittino OPTIONAL )

ENDIF( DOXYGEN_FOUND )
