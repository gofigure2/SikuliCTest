project( SikuliCTest )

cmake_minimum_required( VERSION 2.6 )

set( CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH}
  "${CMAKE_CURRENT_SOURCE_DIR}/CMake"
  )

find_package( Sikuli )

if( SIKULI_FOUND )
  message( "Sikuli found" )
endif()
