set( Pythia8Download PythiaDownload-8.2.26 )

externalproject_add(

    ${Pythia8Download}
    URL http://home.thep.lu.se/~torbjorn/pythia8/pythia8226.tgz
    URL_MD5 f6f1373468af87221f477fb3d8f50d5d
    DOWNLOAD_NO_EXTRACT ON
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    #INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <DOWNLOADED_FILE> <INSTALL_DIR>
    INSTALL_COMMAND ""

)

externalproject_get_property( ${Pythia8Download} DOWNLOADED_FILE )

set( Pythia8Download_FILE ${DOWNLOADED_FILE} )
