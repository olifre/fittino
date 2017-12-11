include( CMakeDependentOption )

option( BUILD_OFFLINE "" OFF )

cmake_dependent_option( INSTALL_Python2 "Install Python 2 environment fulfilling the requirements of CheckMATE, SCYNet, and SModelS." OFF "NOT INSTALL_Python3" OFF )
add_feature_info( INSTALL_Python2 INSTALL_Python2 "the Python 2 evironment installed fulfills the requirements of CheckMATE, SCYNet, and SModelS. This option depends on the option INSTALL_Python3 to be OFF. It requires the package UnixCommands to be found in order to run the bash installer of Miniconda." )

cmake_dependent_option( INSTALL_Python3 "Install Python 3 environment including flavio and its requirements" OFF "NOT INSTALL_Python2" OFF )
add_feature_info( INSTALL_Python3 INSTALL_Python3 "the Python 3 installation includes flavio and its requirements. Flavio is used by the FlavioCalculator of Fittino. It requires the package UnixCommands to be found in order to run the bash installer of Miniconda." )

option( INSTALL_SLHAea "Install SLHAea" OFF )
add_feature_info( INSTALL_SLHAea INSTALL_SLHAea "SLHAea is required for using the SPhenoCalculator of Fittino." )

option( INSTALL_SPheno "Install SPheno" OFF )
add_feature_info( INSTALL_SPheno INSTALL_SPheno "SPheno is used by the SPhenoCalculator of Fittino." )

cmake_dependent_option( INSTALL_SModelS "Install SModelS" OFF "INSTALL_Python2" OFF )
add_feature_info( INSTALL_SModelS INSTALL_SModelS "SModelS is used by the SModelsCalculator of Fittino. This option depends on the option INSTALL_Python2 to be ON. It requires the package UnixCommands to be found in order to untar the database of SModelS." )

cmake_dependent_option( INSTALL_SCYNet "Install SCYNet" OFF "INSTALL_Python2" OFF )
add_feature_info( INSTALL_SCYNet INSTALL_SCYNet "SCYNet is used by the SCYNetCalculator of Fittino. This option depends on the option INSTALL_Python2 to be ON.")


option( INSTALL_Fittino "Install Fittino" ON )
add_feature_info( INSTALL_Fittino INSTALL_Fittino "" )
