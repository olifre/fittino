set( SCYNet2 SCYNet-2.0.0 )

set( SCYNet2_URL ${CMAKE_CURRENT_SOURCE_DIR}/SCYNet2 )

externalproject_add(

    ${SCYNet2}
    DEPENDS ${Virtualenv}
    URL ${SCYNet2_URL}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 PYTHONPATH=${PYTHONPATH_STRING} ${PYTHON_EXECUTABLE} -m pip install <SOURCE_DIR> --prefix=<INSTALL_DIR> --no-cache-dir -b <BINARY_DIR> --no-deps --no-index

)

list( APPEND sn_src ${SCYNet2_URL}/setup.py )
list( APPEND sn_src ${SCYNet2_URL}/scynet/__init__.py )
list( APPEND sn_src ${SCYNet2_URL}/scynet/SCYNet.py )
list( APPEND sn_src ${SCYNet2_URL}/scynet/Preprocessor_lena.py )
list( APPEND sn_src ${SCYNet2_URL}/scynet/data/__init__.py )
list( APPEND sn_src ${SCYNet2_URL}/scynet/data/1.1565_03Aug.h5 )
list( APPEND sn_src ${SCYNet2_URL}/scynet/data/1.1565_03Aug.txt )

ExternalProject_Add_StepDependencies( ${SCYNet2} download ${sn_src} )

externalproject_get_property( ${SCYNet2} install_dir )

list( APPEND PYTHONPATH "${install_dir}/lib/python2.7/site-packages" )
#list( APPEND PATH "${install_dir}/bin" )

list( APPEND Fittino_DEPENDENCIES ${SCYNet2} )

