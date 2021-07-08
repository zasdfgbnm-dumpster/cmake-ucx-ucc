# Reference:
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#find-modules

# TODO: add docs

find_package(PkgConfig)
pkg_check_modules(PC_ucs QUIET ucs)

find_path(ucs_INCLUDE_DIR
  NAMES ucs/config/global_opts.h
  PATHS ${PC_ucs_INCLUDE_DIRS} "/opt/ucx/include"
)
find_library(ucs_LIBRARY
  NAMES ucs
  PATHS ${PC_ucs_LIBRARY_DIRS} "/opt/ucx/lib"
)

set(ucs_VERSION ${PC_ucs_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ucs
  FOUND_VAR ucs_FOUND
  REQUIRED_VARS
    ucs_LIBRARY
    ucs_INCLUDE_DIR
  VERSION_VAR ucs_VERSION
)

if(ucs_FOUND)
  set(ucs_LIBRARIES ${ucs_LIBRARY})
  set(ucs_INCLUDE_DIRS ${ucs_INCLUDE_DIR})
  set(ucs_DEFINITIONS ${PC_ucs_CFLAGS_OTHER})
endif()

if(ucs_FOUND AND NOT TARGET ucs::ucs)
  add_library(ucs::ucs UNKNOWN IMPORTED)
  set_target_properties(ucs::ucs PROPERTIES
    IMPORTED_LOCATION "${ucs_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucs_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucs_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(
  ucs_INCLUDE_DIR
  ucs_LIBRARY
)
