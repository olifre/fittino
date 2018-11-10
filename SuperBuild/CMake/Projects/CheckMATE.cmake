# see https://arxiv.org/abs/1611.09856, p.41 (Appendix A)
# (As of version 2.0.26 README does not mention all options )

set( CheckMATE CheckMATE-2.0.26 )

externalproject_add(

    ${CheckMATE}
    URL https://checkmate.hepforge.org/downloads/CheckMATE-2.0.26.tar.gz
    URL_MD5 d4af00cbf28948c4b1820abfbf6ef9d3
    DEPENDS ${Delphes} ${HepMC2} ${Pythia8} ${MadGraph5} ${CondaPackages}
    PATCH_COMMAND ${CMAKE_COMMAND} -P ${PROJECT_SOURCE_DIR}/CMake/Scripts/patch_CheckMATE.cmake
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env CXX=${CMAKE_CXX_COMPILER} ./configure --with-rootsys=${ROOTSYS} --with-delphes=${Delphes_SOURCE_DIR} --with-hepmc=${HepMC2_ROOT_DIR} --with-pythia=${Pythia8_ROOT_DIR} --with-gziplib=${zlib_library_dir} --with-gzipinc=${ZLIB_INCLUDE_DIRS} --with-madgraph=${MadGraph5_ROOT_DIR} --with-python=${PYTHON_EXECUTABLE}
    BUILD_IN_SOURCE ON
    BUILD_COMMAND ${CMAKE_COMMAND} -E env $(MAKE)
    INSTALL_COMMAND ${CMAKE_COMMAND} -E env $(MAKE) install

)

ExternalProject_Add_StepDependencies( ${CheckMATE} download ${PROJECT_SOURCE_DIR}/CMake/Scripts/patch_CheckMATE.cmake )

externalproject_get_property( ${CheckMATE} source_dir )
set( CheckMATE_ROOT_DIR ${source_dir} )

list( APPEND CACHE_ARGS "-DCheckMATE_EXECUTABLE:FILEPATH=${CheckMATE_ROOT_DIR}/bin/CheckMATE" )

list( APPEND PATH ${CheckMATE_ROOT_DIR}/bin )

list( APPEND Fittino_DEPENDENCIES ${CheckMATE} )

if( ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" )

    file( APPEND ${activationScript} "\n" )
    file( APPEND ${activationScript} "mkdir -p @rpath\n" )
    file( APPEND ${activationScript} "ln -fs ${Delphes_ROOT_DIR}/lib/libDelphes.dylib @rpath\n" )
    file( APPEND ${activationScript} "ln -fs ${HepMC2_ROOT_DIR}/lib/libHepMC.4.dylib\n" )
    file( APPEND ${activationScript} "ln -fs ${HepMC2_ROOT_DIR}/lib/libHepMCfio.4.dylib\n" )

endif()
