#include <ucp/api/ucp.h>
#include <cassert>

int main(int argc, char **argv)
{
    send_recv_type_t send_recv_type = CLIENT_SERVER_SEND_RECV_DEFAULT;
    ucp_context_h ucp_context;
    ucp_worker_h  ucp_worker;
    ret = init_context(&ucp_context, &ucp_worker, send_recv_type);
    assert(ret == 0, "failed to initialize context");
}
