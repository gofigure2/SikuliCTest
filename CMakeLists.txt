project( SikuliCTest )

cmake_minimum_required( VERSION 2.6 )

set( CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH}
  "${CMAKE_CURRENT_SOURCE_DIR}/CMake"
  )

find_package( Sikuli )

if( SIKULI_FOUND )
  include( CTest )
  ENABLE_TESTING()

  add_sikuli_test( ThunderbirdSikuliTest
    test.sikuli
  )

  add_sikuli_test( SikuliScriptWithArgumentTest
    test2.sikuli
    arg1 arg2 arg3 arg4
  )
else()
  message( "Sikuli not found" )
endif()
