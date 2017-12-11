set( Pythia8 Pythia-8.2.30 )

enable_language( CXX )

find_package( ZLIB REQUIRED )
set_package_properties( ZLIB PROPERTIES TYPE REQUIRED PURPOSE "Required by installation of Pythia 8." )
get_filename_component( zlib_library_dir ${ZLIB_LIBRARIES} DIRECTORY )

externalproject_add(

    ${Pythia8}
    DEPENDS ${HepMC2}
    URL http://home.thep.lu.se/~torbjorn/pythia8/pythia8230.tgz
    URL_MD5 5362429333f43bd1f7621a599bae5a24
    CONFIGURE_COMMAND ./configure --cxx=${CMAKE_CXX_COMPILER} --prefix=<INSTALL_DIR> --with-hepmc2=${HepMC_ROOT_DIR} --with-gzip-lib=${zlib_library_dir} --with-gzip-include=${ZLIB_INCLUDE_DIRS}
    BUILD_COMMAND $(MAKE)
    BUILD_IN_SOURCE 1
    INSTALL_COMMAND $(MAKE) install

)

externalproject_get_property( ${Pythia8} install_dir )
set( Pythia8_ROOT_DIR ${install_dir} )
