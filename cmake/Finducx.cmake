# Reference:
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#find-modules

# TODO: add docs

find_package(PkgConfig)
pkg_check_modules(PC_ucp QUIET ucp)

find_path(ucp_INCLUDE_DIR
  NAMES ucp/api/ucp.h
  PATHS ${PC_ucp_INCLUDE_DIRS}
  HINTS "/opt/ucx/include"
)
find_library(ucp_LIBRARY
  NAMES ucp
  PATHS ${PC_ucp_LIBRARY_DIRS}
  HINTS "/opt/ucx/lib"
)

# TODO: read version from ucp/api/ucp_version.h
set(ucp_VERSION ${PC_ucp_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ucp
  FOUND_VAR ucp_FOUND
  REQUIRED_VARS
    ucp_LIBRARY
    ucp_INCLUDE_DIR
  VERSION_VAR ucp_VERSION
)

if(ucp_FOUND)
  set(ucp_LIBRARIES ${ucp_LIBRARY})
  set(ucp_INCLUDE_DIRS ${ucp_INCLUDE_DIR})
  set(ucp_DEFINITIONS ${PC_ucp_CFLAGS_OTHER})
endif()

if(ucp_FOUND AND NOT TARGET ucx::ucp)
  add_library(ucx::ucp UNKNOWN IMPORTED)
  set_target_properties(ucx::ucp PROPERTIES
    IMPORTED_LOCATION "${ucp_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucp_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucp_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(
  ucp_INCLUDE_DIR
  ucp_LIBRARY
)
