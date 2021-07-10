add_test(NAME Finducx.Test COMMAND
  ${CMAKE_CTEST_COMMAND} -C $<CONFIGURATION>
  --build-and-test
  "${CMake_SOURCE_DIR}/Tests/Finducx/Test"
  "${CMake_BINARY_DIR}/Tests/Finducx/Test"
  ${build_generator_args}
  --build-project TestFinducx
  --build-options ${build_options}
  --test-command ${CMAKE_CTEST_COMMAND} -V -C $<CONFIGURATION>
  )