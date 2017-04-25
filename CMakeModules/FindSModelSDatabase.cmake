include( FindPackageHandleStandardArgs )

find_path( SModelSDatabase database.bib HINTS ${SModelSDatabase_ROOT_DIR} )

find_package_handle_standard_args( SModelSDatabase DEFAULT_MSG SModelSDatabase )
