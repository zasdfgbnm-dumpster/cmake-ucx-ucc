find_library(ucc_LIBRARY NAMES ucc HINTS "/opt/ucc/lib" "/opt/ucf/ucc/lib")
find_path(ucc_INCLUDE_DIR NAMES api/ucc.h HINTS "/opt/ucc/include" "/opt/ucf/ucc/include")

set(ucc_LIBRARIES "${ucc_LIBRARY}")
set(ucc_INCLUDE_DIRS "${ucc_INCLUDE_DIR}")

add_library(ucc::ucc INTERFACE IMPORTED)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ucc DEFAULT_MSG ucc_LIBRARY ucc_INCLUDE_DIR)
