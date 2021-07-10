#include <ucp/api/ucp.h>
#include <assert.h>

int main(int argc, char **argv)
{
    ucp_context_h ucp_context;
    ucp_params_t ucp_params;
    ucs_status_t status;
    memset(&ucp_params, 0, sizeof(ucp_params));
    ucp_params.field_mask = UCP_PARAM_FIELD_FEATURES;
    ucp_params.features = UCP_FEATURE_STREAM;

    status = ucp_init(&ucp_params, NULL, ucp_context);
    assert(status == UCS_OK);
}
