#include <ucp/api/ucp.h>
#include <assert.h>

int main(int argc, char **argv)
{
    ucp_context_h ucp_context;
    ucp_worker_h ucp_worker;
    ucp_params_t ucp_params;
    ucs_status_t status;

    memset(&ucp_params, 0, sizeof(ucp_params));

    ucp_params.field_mask = UCP_PARAM_FIELD_FEATURES;
    ucp_params.features = UCP_FEATURE_STREAM;

    status = ucp_init(&ucp_params, NULL, ucp_context);
    assert(status == UCS_OK);

    ucp_worker_params_t worker_params;

    memset(&worker_params, 0, sizeof(worker_params));

    worker_params.field_mask  = UCP_WORKER_PARAM_FIELD_THREAD_MODE;
    worker_params.thread_mode = UCS_THREAD_MODE_SINGLE;

    status = ucp_worker_create(ucp_context, &worker_params, ucp_worker);
    assert(status == UCS_OK);
}
