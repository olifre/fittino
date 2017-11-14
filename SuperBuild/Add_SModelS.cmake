set( smodelspythia8download SModelsPythia8Download-2.26 )

externalproject_add(

    ${smodelspythia8download}
    URL http://home.thep.lu.se/~torbjorn/pythia8/pythia8226.tgz
    URL_MD5 f6f1373468af87221f477fb3d8f50d5d
    DOWNLOAD_NO_EXTRACT ON
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <DOWNLOADED_FILE> <INSTALL_DIR>

)

externalproject_get_property( ${smodelspythia8download} install_dir )
set( smodelspythia8download_root_dir ${install_dir} )

set( smodels SModelS-2236cf372eec70f568fbf072a5ddb9dcfdbc7e2a)

externalproject_add(

    ${smodels}
    DEPENDS ${pippackages} ${smodelspythia8download}
    URL https://github.com/smodels/smodels/archive/2236cf372eec70f568fbf072a5ddb9dcfdbc7e2a.zip
    URL_MD5 837b5cf541b70491c8143d1680eb0d40
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${smodelspythia8download_root_dir}/pythia8226.tgz <SOURCE_DIR>/smodels/lib/pythia8/.pythia8226.tgz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND $(MAKE) FCC=${CMAKE_Fortran_COMPILER} CXX=${CMAKE_CXX_COMPILER} PYTHIAVER=8226
    BUILD_IN_SOURCE ON
    # Optionally: SET PYTHONPATH HERE and use pip
    INSTALL_COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 --unset=PYTHONPATH ${condapackages_root_dir}/bin/python setup.py install --prefix=<INSTALL_DIR>

)



