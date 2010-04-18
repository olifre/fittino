add_definitions(`root-config --cflags`)

include_directories(./include)
include_directories(../exceptions/include)
include_directories(../kernel/include)

aux_source_directory(src sources)

add_library(interpreters ${sources})

target_link_libraries(interpreters `root-config --libs` -lXMLIO -lXMLParser)
