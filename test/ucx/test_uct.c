#include <uct/api/uct.h>
#include <assert.h>

int main(int argc, char **argv)
{
    ucs_async_context_t *async;
    iface_info_t if_info;

    /* Initialize context */
    status = ucs_async_context_create(UCS_ASYNC_MODE_THREAD_SPINLOCK, &async);
    assert(UCS_OK == status);

    /* Create a worker object */
    status = uct_worker_create(async, UCS_THREAD_MODE_SINGLE, &if_info.worker);
    assert(UCS_OK == status);
}
