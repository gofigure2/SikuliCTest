# - Find SIKULI

IF( UNIX )
  FIND_PROGRAM( SH_EXECUTABLE
    NAMES bash
    )

  FIND_FILE( SIKULI_EXECUTABLE
    NAMES sikuli-ide.sh
    PATHS
    "$ENV{ProgramFiles}/Sikuli-IDE/"
    "$ENV{SystemDrive}/Sikuli-IDE/"
    "$ENV{HOME}/Sikuli-IDE/"
    "$ENV{HOME}/Sikuli-IDE/Sikuli-IDE"
    "/Applications/Sikuli-IDE.app"
    PATH_SUFFIXES "bin"
    DOC "Specify the path to sikuli"
    )

ELSE( UNIX ) # Windows

  FIND_PROGRAM( SIKULI_EXECUTABLE
    NAMES sikuli-ide.exe
    PATHS
     "$ENV{ProgramFiles}/Sikuli-IDE/"
     "$ENV{SystemDrive}/Sikuli-IDE/"
     PATH_SUFFIXES "bin"
    DOC "Specify the path to Sikuli"
  )

ENDIF( UNIX )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Sikuli DEFAULT_MSG Sikuli_EXECUTABLE)

# --------------------------------------------------------------------------
# This variable is meant to be used when developers maintain a image library# for their test.
# This variable can
#   either be set by developer in their main CMakeLists
#   either be set by developer while configuring with CMake
SET( SIKULI_IMAGE_LIBRARY_DIR
  CACHE PATH
  "Image library directory for sikuli test"
)
MARK_AS_ADVANCED( SIKULI_IMAGE_LIBRARY_DIR )

# --------------------------------------------------------------------------
# useful function for adding sikuli tests for CTest
#
#   ADD_SIKULI_TEST
#
# testname is the name that CTest will used
# sikuli_test is the sikuli script e.g. test.sikuli
# args optional arguments to be provided to the sikuli script
# (make use of --args in sikuli)
#
# Usage: add_sikuli_test( <testname> <sikuli_test> [args] )
FUNCTION( add_sikuli_test testname sikuli_test )

  SET( SIKULI_RUNNING_DIR )
  SET( image_lib_dir ${SIKULI_IMAGE_LIBRARY_DIR} )

  IF( image_lib_dir )
    EXECUTE_PROCESS(
      COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_CURRENT_SOURCE_DIR}/${image_lib_dir}/
        ${CMAKE_CURRENT_BINARY_DIR}/${sikuli_test}/
      COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_CURRENT_SOURCE_DIR}/${sikuli_test}
        ${CMAKE_CURRENT_BINARY_DIR}/${sikuli_test}
      )
    SET( SIKULI_RUNNING_DIR ${CMAKE_CURRENT_BINARY_DIR} )
  ELSE( image_lib_dir )
    SET( SIKULI_RUNNING_DIR ${CMAKE_CURRENT_SOURCE_DIR} )
  ENDIF( image_lib_dir )

  FOREACH( f ${ARGN} )
    SET( sikuli_arg_list "${sikuli_arg_list} ${f}" )
  ENDFOREACH()

  LIST( LENGTH sikuli_arg_list sikuli_nb_arg )

  SET( sikuli_args )

  IF( ${sikuli_nb_arg} GREATER 0 )
    SET( sikuli_args "--args${sikuli_arg_list}" )
  ENDIF()

  IF( UNIX )
    add_test( ${testname}
      ${SH_EXECUTABLE} ${SIKULI_EXECUTABLE}
      -t ${SIKULI_RUNNING_DIR}/${sikuli_test}
      ${sikuli_args} )
  ELSE( UNIX )

    add_test( ${testname}
      ${SIKULI_EXECUTABLE}
      -t ${SIKULI_RUNNING_DIR}/${sikuli_test}
      ${sikuli_args}
      )

  ENDIF( UNIX )
ENDFUNCTION( add_sikuli_test )

