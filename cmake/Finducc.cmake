find_library(ucc_LIBRARY NAMES ucc)
find_path(ucc_INCLUDE_DIR NAMES api/ucc.h)

set(ucc_LIBRARIES "${ucc_LIBRARY}")
set(ucc_INCLUDE_DIRS "${ucc_INCLUDE_DIR}")

add_library(ucc::ucc INTERFACE IMPORTED)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ucc DEFAULT_MSG ucc_LIBRARY ucc_INCLUDE_DIR)
