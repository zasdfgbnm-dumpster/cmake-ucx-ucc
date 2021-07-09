#include <ucc/api/ucc.h>
#include <cstring>
#include <cassert>

int main(int argc, char *argv[]) {
  ucc_lib_config_h lib_config;
  ucc_lib_params_t lib_params;
  ucc_status_t st;
  ucc_lib_h lib;

  st = ucc_lib_config_read(nullptr, nullptr, &lib_config);
  assert(st == UCC_OK);
  memset(&lib_params, 0, sizeof(ucc_lib_params_t));
  lib_params.mask = UCC_LIB_PARAM_FIELD_THREAD_MODE;
  lib_params.thread_mode = UCC_THREAD_MULTIPLE;
  st = ucc_init(&lib_params, lib_config, &lib);
  assert(st == UCC_OK);
  ucc_lib_config_release(lib_config);
}
