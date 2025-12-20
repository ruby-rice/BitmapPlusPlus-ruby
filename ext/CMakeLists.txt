cmake_minimum_required (VERSION 3.26)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Setup ruby extension
project(BitmapPlusPlus LANGUAGES CXX)
add_library (${CMAKE_PROJECT_NAME} SHARED)

# Link to Rice git repo
include(FetchContent)
FetchContent_Declare(
  rice
  GIT_REPOSITORY https://github.com/ruby-rice/rice.git
  GIT_TAG dev
)
FetchContent_MakeAvailable(rice)

# Use FindRuby.cmake from Rice repo for now while upstream is being updated to support
# the new Ruby targets
list(PREPEND CMAKE_MODULE_PATH "${rice_SOURCE_DIR}")

# Find Ruby
find_package(Ruby REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  Ruby::Module
)

# Rice headers
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  rice::rice
)

# BitmapPlusPlus.hpp headers
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE .)

# Define project properties
get_target_property(RUBY_EXT_SUFFIX Ruby::Ruby INTERFACE_RUBY_EXTENSION_SUFFIX)
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
  PREFIX ""
  SUFFIX "${RUBY_EXT_SUFFIX}"
  OUTPUT_NAME "bitmap_plus_plus_ruby"
  CXX_VISIBILITY_PRESET hidden
  VISIBILITY_INLINES_HIDDEN ON
  WINDOWS_EXPORT_ALL_SYMBOLS OFF
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/../lib/${Ruby_VERSION_MAJOR}.${Ruby_VERSION_MINOR}" # Windows
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/../lib") # Not Windows

# Source code
target_sources(${CMAKE_PROJECT_NAME} PRIVATE
               "${CMAKE_PROJECT_NAME}-rb.hpp"
               "${CMAKE_PROJECT_NAME}-rb.cpp")