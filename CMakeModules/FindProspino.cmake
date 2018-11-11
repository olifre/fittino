include( FindPackageHandleStandardArgs )

find_path( Prospino_ROOT_DIR Xprospino_subroutine.f90 )

find_package_handle_standard_args( Prospino FOUND_VAR Prospino_FOUND REQUIRED_VARS Prospino_ROOT_DIR )
