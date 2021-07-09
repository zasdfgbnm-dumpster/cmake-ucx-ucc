# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
Finducc
-------

Finds the `ucc`_ library.

.. _ucc: https://github.com/openucx/ucc

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``ucc::ucc``
  The ucc library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``ucc_FOUND``
  True if the system has the ucc library.
``ucc_VERSION``
  The version of the ucc library which was found.
``ucc_INCLUDE_DIRS``
  Include directories needed to use ucc.
``ucc_LIBRARIES``
  Libraries needed to link to ucc.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``ucc_INCLUDE_DIR``
  The directory containing ``ucc/api/ucc.h``.
``ucc_LIBRARY``
  The path to the ucc library.

#]=======================================================================]

find_path(ucc_INCLUDE_DIR
  NAMES ucc/api/ucc.h
  PATHS ${PC_ucc_INCLUDE_DIRS} "/opt/ucc/include" "/opt/ucf/ucc/include"
)
find_library(ucc_LIBRARY
  NAMES ucc
  PATHS ${PC_ucc_LIBRARY_DIRS} "/opt/ucc/lib" "/opt/ucf/ucc/lib"
)

set(_UCC_VER_FILE "${ucc_INCLUDE_DIR}/ucc/api/ucc_version.h")
if(EXISTS "${_UCC_VER_FILE}")
  file(READ "${_UCC_VER_FILE}" _ver)
  string(REGEX MATCH "#define UCC_VERSION_STRING *\"([0-9]*.[0-9]*.[0-9]*)\"" _ ${_ver})
  set(ucc_VERSION ${CMAKE_MATCH_1})
endif()

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
  ucc_INCLUDE_DIR
  ucc_LIBRARY
)
