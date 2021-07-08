# Reference:
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#find-modules

find_package(PkgConfig)
pkg_check_modules(PC_ucc QUIET ucc)

find_path(ucc_INCLUDE_DIR
  NAMES ucc/api/ucc.h
  PATHS ${PC_ucc_INCLUDE_DIRS}
  HINTS "/opt/ucc/include" "/opt/ucf/ucc/include"
)
find_library(ucc_LIBRARY
  NAMES ucc
  PATHS ${PC_ucc_LIBRARY_DIRS}
  HINTS "/opt/ucc/lib" "/opt/ucf/ucc/lib"
)

# TODO: read version from ucc/api/ucc_version.h
set(ucc_VERSION ${PC_ucc_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ucc
  FOUND_VAR ucc_FOUND
  REQUIRED_VARS
    ucc_LIBRARY
    ucc_INCLUDE_DIR
  VERSION_VAR ucc_VERSION
)

if(ucc_FOUND)
  set(ucc_LIBRARIES ${ucc_LIBRARY})
  set(ucc_INCLUDE_DIRS ${ucc_INCLUDE_DIR})
  set(ucc_DEFINITIONS ${PC_ucc_CFLAGS_OTHER})
endif()

if(ucc_FOUND AND NOT TARGET ucc::ucc)
  add_library(ucc::ucc UNKNOWN IMPORTED)
  set_target_properties(ucc::ucc PROPERTIES
    IMPORTED_LOCATION "${ucc_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucc_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucc_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(
  Foo_INCLUDE_DIR
  Foo_LIBRARY
)
