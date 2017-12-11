if( INSTALL_Python2 OR INSTALL_Python3 )

    include( Projects/Miniconda )
    include( Projects/CondaPackages )
    include( Projects/PipPackages )

endif()

if( INSTALL_SModelS )

    include( Projects/Pythia8Download )
    include( Projects/SModelS )

endif()

if( INSTALL_SCYNet )

    include( Projects/SCYNet )

endif()

if( INSTALL_SLHAea )

    include( Projects/SLHAea )

endif()

if( INSTALL_SPheno )

    include( Projects/SPheno )

endif()

if( INSTALL_MSSMTriLnV )

    include( Projects/MSSMTriLnV )

endif()

if( INSTALL_Fittino )

include( Projects/Fittino)

endif()
