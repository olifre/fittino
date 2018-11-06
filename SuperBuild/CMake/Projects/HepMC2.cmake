# see file INSTALL.cmake inside the tarball
# GeV and mm are required according to https://arxiv.org/pdf/1611.09856.pdf

set( HepMC2 HepMC-2.06.09)

list( APPEND hepmc2_cache_args "-DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>" )
list( APPEND hepmc2_cache_args "-DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}" )
list( APPEND hepmc2_cache_args "-DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}" )
list( APPEND hepmc2_cache_args "-Dmomentum:STRING=GEV" )
list( APPEND hepmc2_cache_args "-Dlength:STRING=MM" )

externalproject_add(

    ${HepMC2}
    URL http://hepmc.web.cern.ch/hepmc/releases/hepmc2.06.09.tgz
    URL_MD5 52518437a64f6b4284e9acc2ecad6212
    CMAKE_CACHE_ARGS ${hepmc2_cache_args}

)

externalproject_get_property( ${HepMC2} install_dir )
set( HepMC2_ROOT_DIR ${install_dir} )

list( APPEND ldLibraryPathValue ${HepMC2_ROOT_DIR}/lib )
