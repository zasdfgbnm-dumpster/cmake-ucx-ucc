# Reference:
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#find-modules

# TODO: add docs

find_package(PkgConfig)
pkg_check_modules(PC_ucp QUIET ucp)

find_path(ucp_INCLUDE_DIR
  NAMES ucp/api/ucp.h
  PATHS ${PC_ucp_INCLUDE_DIRS} "/opt/ucx/include"
)
find_library(ucp_LIBRARY
  NAMES ucp
  PATHS ${PC_ucp_LIBRARY_DIRS} "/opt/ucx/lib"
)

set(_ucp_VER_FILE "${ucp_INCLUDE_DIR}/ucp/api/ucp_version.h")
if(EXISTS "${_ucp_VER_FILE}")
  file(READ "${_ucp_VER_FILE}" _ver)
  string(REGEX MATCH "#define UCP_API_MAJOR *([0-9]*)" _ ${_ver})
  set(_major ${CMAKE_MATCH_1})
  string(REGEX MATCH "#define UCP_API_MINOR *([0-9]*)" _ ${_ver})
  set(_minor ${CMAKE_MATCH_1})
  set(ucp_VERSION "${_major}.${_minor}")
endif()

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

if(ucp_FOUND AND NOT TARGET ucp::ucp)
  add_library(ucp::ucp UNKNOWN IMPORTED)
  set_target_properties(ucp::ucp PROPERTIES
    IMPORTED_LOCATION "${ucp_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucp_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucp_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(
  ucp_INCLUDE_DIR
  ucp_LIBRARY
)
