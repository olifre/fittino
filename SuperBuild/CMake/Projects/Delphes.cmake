# see https://cp3.irmp.ucl.ac.be/projects/delphes/wiki/WorkBook/QuickTour
# (The README does not mention cmake (last checked with version 3.4.1) )

set( Delphes Delphes-3.4.1 )

enable_language( CXX )

find_package( ROOT REQUIRED )

execute_process(
    COMMAND ${ROOT_CONFIG_EXECUTABLE} --has-veccore
    OUTPUT_VARIABLE root_has_veccore
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

if ( root_has_veccore )

    find_package( VecCore REQUIRED )

endif()

set( cp_incl_path "${VecCore_INCLUDE_DIRS}:$ENV{CPLUS_INCLUDE_PATH}")

list( APPEND delphes_cache_args "-DROOT_CONFIG_EXECUTABLE:FILEPATH=${ROOT_CONFIG_EXECUTABLE}" )

# Delphes contains FastJet, and FastJet by default uses auto_ptr, which has been removed from C++17.
# FastJet provides a configuration option to disable it.
# But after modifying Delphes doc/update_fastjet.sh script accordingly (see https://cp3.irmp.ucl.ac.be/projects/delphes/ticket/548#comment:2),
# Delphes no longer builds successfully. (Tested with Delphes 3.4.1)
# Hence instead we enforce here the usage of C++14 until Delphes is updated to no longer rely on the depreciated auto_ptr interface of FastJet.

list( APPEND delphes_cache_args "-DCMAKE_CXX_STANDARD:STRING=14" )

list( APPEND delphes_cache_args "-DCMAKE_INSTALL_PREFIX:FILEPATH=<INSTALL_DIR>" )

externalproject_add(

    ${Delphes}
    URL http://cp3.irmp.ucl.ac.be/downloads/Delphes-3.4.1.tar.gz
    URL_MD5 c1d69a19e95351fe695202aec2b9cd8b
    #BUILD_COMMAND ${CMAKE_COMMAND} -E env PATH=${mypath} ROOTSYS=${ROOTSYS} CPLUS_INCLUDE_PATH=${VecCore_INCLUDE_DIRS} $(MAKE) CXX=${CMAKE_CXX_COMPILER}
    BUILD_COMMAND ${CMAKE_COMMAND} -E env CPLUS_INCLUDE_PATH=${cp_incl_path} $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    COMMAND ${CMAKE_COMMAND} -E copy_directory <INSTALL_DIR>/lib <SOURCE_DIR>
    CMAKE_CACHE_ARGS ${delphes_cache_args}

)

externalproject_get_property( ${Delphes} install_dir )
set( Delphes_ROOT_DIR ${install_dir} )

# apparently the CheckMATE authors are not aware of Delphes' cmake installation and require an in source build of Delphes
# That's why we copy the lib dir of Delphes to source_dir in the INSTALL_COMMAND and pass the source dir to CheckMATE

externalproject_get_property( ${Delphes} source_dir )
set( Delphes_SOURCE_DIR ${source_dir} )

list( APPEND PATH ${Delphes_ROOT_DIR}/bin )
