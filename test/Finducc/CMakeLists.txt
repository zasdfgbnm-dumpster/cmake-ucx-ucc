add_test(NAME Finducc.Test COMMAND
  ${CMAKE_CTEST_COMMAND} -C $<CONFIGURATION>
  --build-and-test
  "${CMake_SOURCE_DIR}/Tests/Finducc/Test"
  "${CMake_BINARY_DIR}/Tests/Finducc/Test"
  ${build_generator_args}
  --build-project TestFinducc
  --build-options ${build_options}
  --test-command ${CMAKE_CTEST_COMMAND} -V -C $<CONFIGURATION>
  )