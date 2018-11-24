
set( src )
list( APPEND src setup.py cls  )

if( PYTHON2_FOUND )

    add_custom_target( CLs ALL
                       COMMAND ${PYTHON_EXECUTABLE} -m pip install ${CMAKE_CURRENT_LIST_DIR} --prefix=${CMAKE_INSTALL_PREFIX} --no-cache-dir -b . --no-deps --no-index
                       SOURCES ${src}  )

    list( APPEND PYTHONPATH "${CMAKE_INSTALL_PREFIX}/lib/python2.7/site-packages" )
    set( PYTHONPATH "${PYTHONPATH}" CACHE INTERNAL "" )

else()

    add_custom_target( CLs SOURCES ${src} )

endif()
