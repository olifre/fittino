include( FindPackageHandleStandardArgs )

find_program( SModelSTools_EXECUTABLE smodelsTools.py HINTS ${SModelS_ROOT_DIR}/bin )

find_package_handle_standard_args( SModelSTools DEFAULT_MSG SModelSTools_EXECUTABLE )
