add_definitions(`root-config --cflags`)

include_directories(./include)
include_directories(../exceptions/include)

aux_source_directory(src sources)

add_library(optimizers ${sources})

target_link_libraries(optimizers `root-config --libs`)
