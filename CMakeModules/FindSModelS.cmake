include( FindPackageHandleStandardArgs )

find_program( SModelS_Tools_EXECUTABLE smodelsTools.py HINTS ${SModelS_ROOT_DIR}/bin )

get_filename_component( bindir ${SModelS_Tools_EXECUTABLE} DIRECTORY )

find_path( SModelS_Database_DIR database.bib HINTS ${SModelS_ROOT_DIR}/smodels-database ${bindir}/../smodels-database )

find_package_handle_standard_args( SModelS FOUND_VAR SModelS_FOUND REQUIRED_VARS SModelSTools_EXECUTABLE SModelS_Database_DIR )

mark_as_advanced(

    SModelS_Tools_EXECUTABLE
    SModelS_Database_DIR

)
