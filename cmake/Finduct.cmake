# Reference:
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#find-modules

# TODO: add docs

find_package(PkgConfig)
pkg_check_modules(PC_uct QUIET uct)

find_path(uct_INCLUDE_DIR
  NAMES uct/api/uct.h
  PATHS ${PC_uct_INCLUDE_DIRS} "/opt/ucx/include"
)
find_library(uct_LIBRARY
  NAMES uct
  PATHS ${PC_uct_LIBRARY_DIRS} "/opt/ucx/lib"
)

set(_uct_VER_FILE "${uct_INCLUDE_DIR}/uct/api/version.h")
if(EXISTS "${_uct_VER_FILE}")
  file(READ "${_uct_VER_FILE}" _ver)
  string(REGEX MATCH "#define UCT_VERNO_STRING *\"([0-9]*.[0-9]*.[0-9]*)\"" _ ${_ver})
  set(uct_VERSION ${CMAKE_MATCH_1})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(uct
  FOUND_VAR uct_FOUND
  REQUIRED_VARS
    uct_LIBRARY
    uct_INCLUDE_DIR
  VERSION_VAR uct_VERSION
)

if(uct_FOUND)
  set(uct_LIBRARIES ${uct_LIBRARY})
  set(uct_INCLUDE_DIRS ${uct_INCLUDE_DIR})
  set(uct_DEFINITIONS ${PC_uct_CFLAGS_OTHER})
endif()

if(uct_FOUND AND NOT TARGET uct::uct)
  add_library(uct::uct UNKNOWN IMPORTED)
  set_target_properties(uct::uct PROPERTIES
    IMPORTED_LOCATION "${uct_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_uct_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${uct_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(
  uct_INCLUDE_DIR
  uct_LIBRARY
)
