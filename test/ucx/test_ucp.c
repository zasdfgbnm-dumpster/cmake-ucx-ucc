#include <ucp/api/ucp.h>
#include <assert.h>

int main(int argc, char **argv)
{
    ucp_context_h ucp_context;
    ucp_worker_h ucp_worker;
    ret = init_context(&ucp_context, &ucp_worker, CLIENT_SERVER_SEND_RECV_DEFAULT);
    assert(ret == 0);
}
