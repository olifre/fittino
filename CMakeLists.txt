cmake_minimum_required(VERSION 2.4)

#cmake_minimum_required(VERSION 2.6 FATAL_ERROR)
## The FATAL_ERROR option is accepted but ignored by CMake 2.6 and higher. It
## should be specified so CMake versions 2.4 and lower fail with an error
## instead of just a warning.

project(fittino)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMakeModules")
  
find_package(root)

add_subdirectory(sources)
