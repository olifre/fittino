set( MadGraph5 MadGraph5-2.6.3.2 )

externalproject_add(

    ${MadGraph5}
    URL https://launchpad.net/mg5amcnlo/2.0/2.6.x/+download/MG5_aMC_v2.6.3.2.tar.gz
    URL_MD5 65a66e60e2f3f800130e8bc9b477bc25
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""

)

externalproject_get_property( ${MadGraph5} source_dir )
set( MadGraph5_ROOT_DIR ${source_dir} )

list( APPEND CACHE_ARGS "-DMadGraph5_EXECUTABLE:FILEPATH=${MadGraph5_ROOT_DIR}/bin/mg5_aMC" )

list( APPEND PATH ${MadGraph5_ROOT_DIR}/bin )
list( APPEND PYTHONPATH ${MadGraph5_ROOT_DIR} )

list( APPEND Fittino_DEPENDENCIES ${MadGraph} )
