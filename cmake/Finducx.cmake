# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
Finducx
-------

Finds the `ucx`_ library.

.. _ucx: https://github.com/openucx/ucx

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``ucx::ucp``
  The ucp library

``ucx::uct``
  The uct library

``ucx::ucs``
  The ucs library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ucx_FOUND``
  True if the system has the ucx library.
``ucx_VERSION``
  The version of the ucx library which was found.
``ucx_INCLUDE_DIRS``
  Include directories needed to use ucx.
``ucx_LIBRARIES``
  Libraries needed to link to ucx.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``ucx_ucp_INCLUDE_DIR``
  The directory containing ``ucp/api/ucp.h``.
``ucx_uct_INCLUDE_DIR``
  The directory containing ``uct/api/uct.h``.
``ucx_ucs_INCLUDE_DIR``
  The directory containing ``ucs/config/global_opts.h``.
``ucx_ucp_LIBRARY``
  The path to the ucp library.
``ucx_uct_LIBRARY``
  The path to the uct library.
``ucx_ucs_LIBRARY``
  The path to the ucs library.

#]=======================================================================]

find_package(PkgConfig)
pkg_check_modules(PC_ucx QUIET ucx)

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
