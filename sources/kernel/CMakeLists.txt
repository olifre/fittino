add_definitions(`root-config --cflags`)

include_directories(./include)
include_directories(../exceptions/include)
include_directories(../interpreters/include)
include_directories(../models/include)
include_directories(../optimizers/include)

aux_source_directory(./src sources)

add_executable(fittino ${sources})

target_link_libraries(fittino exceptions)
target_link_libraries(fittino interpreters)
target_link_libraries(fittino models)
target_link_libraries(fittino optimizers)
