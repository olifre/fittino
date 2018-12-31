set( SCYNet SCYNet-1.0.0 )

set( SCYNet1_URL ${CMAKE_CURRENT_SOURCE_DIR}/SCYNet )

externalproject_add(

    ${SCYNet}
    DEPENDS ${Virtualenv}
    URL ${SCYNet1_URL}
    #BUILD_ALWAYS ON
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ${CMAKE_COMMAND} -E env PYTHONNOUSERSITE=1 PYTHONPATH=${PYTHONPATH_STRING} ${PYTHON_EXECUTABLE} -m pip install <SOURCE_DIR> --prefix=<INSTALL_DIR> --no-cache-dir -b <BINARY_DIR> --no-deps --no-index

)

list( APPEND sn1_src ${SCYNet1_URL}/setup.py )
list( APPEND sn1_src ${SCYNet1_URL}/bin/test )
list( APPEND sn1_src ${SCYNet1_URL}/scynet1/__init__.py )
list( APPEND sn1_src ${SCYNet1_URL}/scynet1/scynet1.py )
list( APPEND sn1_src ${SCYNet1_URL}/scynet1/data/__init__.py )
list( APPEND sn1_src ${SCYNet1_URL}/scynet1/data/direct_8TeV.ckpt )
list( APPEND sn1_src ${SCYNet1_URL}/scynet1/data/direct_13TeV.ckpt )

ExternalProject_Add_StepDependencies( ${SCYNet} download ${sn1_src} )

externalproject_get_property( ${SCYNet} install_dir )

list( APPEND PYTHONPATH "${install_dir}/lib/python2.7/site-packages" )
list( APPEND PATH "${install_dir}/bin" )

list( APPEND Fittino_DEPENDENCIES ${SCYNet} )
