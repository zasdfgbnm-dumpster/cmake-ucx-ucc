# Reference:
# https://cmake.org/cmake/help/latest/manual/cmake-developer.7.html#find-modules

# TODO: add docs

find_package(PkgConfig)
pkg_check_modules(PC_ucx QUIET ucx)


# debug
# get_cmake_property(_variableNames VARIABLES)
# list (SORT _variableNames)
# foreach (_variableName ${_variableNames})
#   message("${_variableName} = ${${_variableName}}")
# endforeach()
# PC_ucx_CFLAGS =
# PC_ucx_CFLAGS_I =
# PC_ucx_CFLAGS_OTHER =
# PC_ucx_FOUND = 1
# PC_ucx_INCLUDEDIR = /usr/include
# PC_ucx_INCLUDE_DIRS =
# PC_ucx_LDFLAGS = -lucs;-luct;-lucp
# PC_ucx_LDFLAGS_OTHER =
# PC_ucx_LIBDIR = /usr/lib
# PC_ucx_LIBRARIES = ucs;uct;ucp
# PC_ucx_LIBRARY_DIRS =
# PC_ucx_LIBS =
# PC_ucx_LIBS_L =
# PC_ucx_LIBS_OTHER =
# PC_ucx_LIBS_PATHS =
# PC_ucx_LINK_LIBRARIES = /usr/lib/libucs.so;/usr/lib/libuct.so;/usr/lib/libucp.so
# PC_ucx_MODULE_NAME = ucx
# PC_ucx_PREFIX = /usr
# PC_ucx_STATIC_CFLAGS =
# PC_ucx_STATIC_CFLAGS_I =
# PC_ucx_STATIC_CFLAGS_OTHER =
# PC_ucx_STATIC_INCLUDE_DIRS =
# PC_ucx_STATIC_LDFLAGS = -lucs;-luct;-lucp
# PC_ucx_STATIC_LDFLAGS_OTHER =
# PC_ucx_STATIC_LIBDIR =
# PC_ucx_STATIC_LIBRARIES = ucs;uct;ucp
# PC_ucx_STATIC_LIBRARY_DIRS =
# PC_ucx_STATIC_LIBS =
# PC_ucx_STATIC_LIBS_L =
# PC_ucx_STATIC_LIBS_OTHER =
# PC_ucx_STATIC_LIBS_PATHS =
# PC_ucx_VERSION = 1.12
# PC_ucx_ucx_INCLUDEDIR =
# PC_ucx_ucx_LIBDIR =
# PC_ucx_ucx_PREFIX =
# PC_ucx_ucx_VERSION =

find_path(ucx_ucp_INCLUDE_DIR
  NAMES ucp/api/ucp.h
  PATHS ${PC_ucx_INCLUDEDIR} "/opt/ucx/include"
)
find_path(ucx_uct_INCLUDE_DIR
  NAMES uct/api/uct.h
  PATHS ${PC_ucx_INCLUDEDIR} "/opt/ucx/include"
)
find_path(ucx_ucs_INCLUDE_DIR
  NAMES ucs/config/global_opts.h
  PATHS ${PC_ucx_INCLUDEDIR} "/opt/ucx/include"
)

find_library(ucx_ucp_LIBRARY
  NAMES ucp
  PATHS ${PC_ucx_LIBDIR} "/opt/ucx/lib"
)
find_library(ucx_uct_LIBRARY
  NAMES uct
  PATHS ${PC_ucx_LIBDIR} "/opt/ucx/lib"
)
find_library(ucx_ucs_LIBRARY
  NAMES ucs
  PATHS ${PC_ucx_LIBDIR} "/opt/ucx/lib"
)

if(NOT ${PC_ucx_VERSION})
  set(_ucx_VER_FILE "${ucp_INCLUDE_DIR}/ucp/api/ucp_version.h")
  if(EXISTS "${_ucx_VER_FILE}")
    file(READ "${_ucx_VER_FILE}" _ver)
    string(REGEX MATCH "#define UCP_API_MAJOR *([0-9]*)" _ ${_ver})
    set(_major ${CMAKE_MATCH_1})
    string(REGEX MATCH "#define UCP_API_MINOR *([0-9]*)" _ ${_ver})
    set(_minor ${CMAKE_MATCH_1})
    set(ucx_VERSION "${_major}.${_minor}")
  endif()
else()
  set(ucx_VERSION ${PC_ucx_VERSION})
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ucx
  FOUND_VAR ucx_FOUND
  REQUIRED_VARS
    ucx_ucp_LIBRARY
    ucx_uct_LIBRARY
    ucx_ucs_LIBRARY
    ucx_ucp_INCLUDE_DIR
    ucx_uct_INCLUDE_DIR
  VERSION_VAR ucx_VERSION
)

if(ucx_FOUND)
  set(ucx_LIBRARIES
    ${ucx_ucp_LIBRARY}
    ${ucx_uct_LIBRARY}
    ${ucx_ucs_LIBRARY}
  )
  set(ucx_INCLUDE_DIRS
    ${ucx_ucp_INCLUDE_DIR}
    ${ucx_uct_INCLUDE_DIR}
  )
  set(ucx_DEFINITIONS ${PC_ucx_CFLAGS_OTHER})
endif()

if(ucx_FOUND AND NOT TARGET ucx::ucx)
  add_library(ucx::ucp UNKNOWN IMPORTED)
  set_target_properties(ucx::ucp PROPERTIES
    IMPORTED_LOCATION "${ucx_ucp_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucx_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucx_ucp_INCLUDE_DIR}"
  )

  add_library(ucx::uct UNKNOWN IMPORTED)
  set_target_properties(ucx::uct PROPERTIES
    IMPORTED_LOCATION "${ucx_uct_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucx_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucx_uct_INCLUDE_DIR}"
  )

  add_library(ucx::ucs UNKNOWN IMPORTED)
  set_target_properties(ucx::ucs PROPERTIES
    IMPORTED_LOCATION "${ucx_ucs_LIBRARY}"
    INTERFACE_COMPILE_OPTIONS "${PC_ucx_CFLAGS_OTHER}"
    INTERFACE_INCLUDE_DIRECTORIES "${ucx_ucs_INCLUDE_DIR}"
  )
endif()

mark_as_advanced(
  ucx_ucp_INCLUDE_DIR
  ucx_uct_INCLUDE_DIR
  ucx_ucs_INCLUDE_DIR
  ucx_ucp_LIBRARY
  ucx_uct_LIBRARY
  ucx_ucs_LIBRARY
)
