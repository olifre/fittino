include_directories(./include)

aux_source_directory(src sources)

add_library(exceptions ${sources})
