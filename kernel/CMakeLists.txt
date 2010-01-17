include_directories(./include
                    ../exceptions/include
		    ../interpreters/include)
aux_source_directory(src sources)
add_definitions(`root-config --cflags`)
link_libraries(ROOT `root-config --libs`)
add_executable(fittino ${sources})
#add_custom_command(TARGET fittino PRE_BUILD COMMAND ./versioning.sh)
