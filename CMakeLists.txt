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

  # we launch firefox by clicking on its icon
  add_sikuli_test( FirefoxSikuliTest
    test.sikuli
  )

  # we make use of a function which does not exist
  # unclick()
  add_sikuli_test( SyntaxErrorSikuliTest
    test2.sikuli
  )

  add_sikuli_test( PrintSikuliTest
    test3.sikuli
  )

else()
  message( "Sikuli not found" )
endif()
