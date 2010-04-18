include_directories(./include)
include_directories(../exceptions/include)

aux_source_directory(src sources)

add_library(models ${sources})
