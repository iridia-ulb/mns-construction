cmake_minimum_required(VERSION 2.8.12)
project(mns-construction)

# Use new policies introduced up to this version
cmake_policy(SET CMP0042 NEW)
cmake_policy(SET CMP0071 NEW)
set(OpenGL_GL_PREFERENCE "LEGACY")

# Make sure we are under Unix
if(NOT UNIX)
  message(FATAL_ERROR "ARGoS compiles only under UNIX, sorry!")
endif(NOT UNIX)

set(CMAKE_MACOSX_RPATH 0)
set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)
include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR})

include(${CMAKE_SOURCE_DIR}/cmake/ARGoSBuildOptions.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/ARGoSBuildFlags.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/ARGoSBuildChecks.cmake)

add_library(my_extensions SHARED
  # add the debug actuator
  extensions/debug/debug_entity.h
  extensions/debug/debug_entity.cpp
  extensions/debug/debug_default_actuator.h
  extensions/debug/debug_default_actuator.cpp
  # add the extended pipuck model
  extensions/pipuck_ext/pipuck_ext_entity.h
  extensions/pipuck_ext/pipuck_ext_entity.cpp  
  extensions/pipuck_ext/dynamics3d_pipuck_ext_model.h
  extensions/pipuck_ext/dynamics3d_pipuck_ext_model.cpp
  # include the loop function
  extensions/my_loop_functions.h
  extensions/my_loop_functions.cpp)
target_link_libraries(my_extensions
  argos3core_${ARGOS_BUILD_FOR})
if(ARGOS_USE_DOUBLE)
  target_compile_definitions(my_extensions PUBLIC BT_USE_DOUBLE_PRECISION)
endif(ARGOS_USE_DOUBLE)

if(ARGOS_QTOPENGL_FOUND)
  add_library(my_qtopengl_extensions SHARED
    qtopengl_extensions/my_qtopengl_user_functions.h
    qtopengl_extensions/my_qtopengl_user_functions.cpp
    qtopengl_extensions/qtopengl_pipuck_ext_model.h
    qtopengl_extensions/qtopengl_pipuck_ext.h
    qtopengl_extensions/qtopengl_pipuck_ext.cpp)
  target_link_libraries(my_qtopengl_extensions
    my_extensions)
endif(ARGOS_QTOPENGL_FOUND)

configure_file(
  ${CMAKE_SOURCE_DIR}/configuration.argos.in
  ${CMAKE_BINARY_DIR}/configuration.argos)

configure_file(
  ${CMAKE_SOURCE_DIR}/drone_controller.lua
  ${CMAKE_BINARY_DIR}/drone_controller.lua
  COPYONLY)

configure_file(
  ${CMAKE_SOURCE_DIR}/pipuck_controller.lua
  ${CMAKE_BINARY_DIR}/pipuck_controller.lua
  COPYONLY)

