include_directories(./include)
#include_directories(../exceptions/include)

aux_source_directory(src sources)

#add_definitions(`root-config --cflags`)

#link_libraries(ROOT `root-config --libs`)

add_library(interpreters ${sources})
