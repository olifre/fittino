add_custom_command( OUTPUT prospino_2.run
                    COMMAND ${CMAKE_COMMAND} -E copy_directory ${PROJECT_SOURCE_DIR}/external/Prospino .
                    COMMAND $(MAKE)
                    ARGS -f ${Prospino_ROOT_DIR}/Makefile DIRECT=${Prospino_ROOT_DIR}/ COMP='${CMAKE_Fortran_COMPILER} -I${Prospino_ROOT_DIR}'
                    DEPENDS ${Prospino_ROOT_DIR}/ ${PROJECT_SOURCE_DIR}/external/Prospino/prospino_main.f90 )

add_custom_target( prospino ALL DEPENDS prospino_2.run )

install( PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/prospino_2.run DESTINATION bin )

set( Prospino_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/prospino_2.run CACHE INTERNAL "" )

# actually only ctq66.00.pds and cteq6l1.tbl are needed.
# further tables contained are cteq5l.tbl and cteq5m1.tbl
file( APPEND ${activationScript} "\n" )
file( APPEND ${activationScript}  "cp -r ${Prospino_ROOT_DIR}/Pro2_subroutines .\n" )
