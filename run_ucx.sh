#!/bin/bash

set -eux

build/ucx/test_ucp

# build/ucx/ucp_hello_world -p 13338 &
# pid0=$!
# sleep 1
# build/ucx/ucp_hello_world -p 13338 -n 127.0.0.1 &
# pid1=$!
# wait "${pid0}"
# wait "${pid1}"

# ip addr
# build/ucx/uct_hello_world -d eth0 -t tcp &
# pid0=$!
# sleep 1
# build/ucx/uct_hello_world -d eth0 -t tcp -n 127.0.0.1 &
# wait "${pid0}"
# wait "${pid1}"
