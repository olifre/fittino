set( Prospino Prospino-2.1-10.17.14 )

enable_language( Fortran )

externalproject_add(

    ${Prospino}
    URL http://www.thphys.uni-heidelberg.de/~plehn/includes/prospino/on_the_web_10_17_14.tar.gz
    URL_MD5 40e73d6b56a5008c134cc89c769e274c
    BUILD_IN_SOURCE ON
    CONFIGURE_COMMAND ""
    #BUILD_COMMAND ${CMAKE_COMMAND} -E env $(MAKE) -f <SOURCE_DIR>/Makefile DIRECT=<SOURCE_DIR> COMP=${CMAKE_Fortran_COMPILER}
    BUILD_COMMAND $(MAKE) COMP=${CMAKE_Fortran_COMPILER}
    INSTALL_COMMAND ""

)

externalproject_get_property( ${Prospino} binary_dir )
set( Prospino_ROOT_DIR ${binary_dir} )

list( APPEND CACHE_ARGS "-DProspino_ROOT_DIR:PATH=${Prospino_ROOT_DIR}" )

list( APPEND PATH ${Prospino_ROOT_DIR} )

list( APPEND Fittino_DEPENDENCIES ${Prospino} )

# actually only ctq66.00.pds and cteq6l1.tbl are needed.
# further tables contained are cteq5l.tbl and cteq5m1.tbl
file( APPEND ${activationScript} "\n" )
file( APPEND ${activationScript}  "cp -R ${Prospino_ROOT_DIR}/Pro2_subroutines .\n" )
