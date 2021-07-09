#!/bin/bash

set -eux

# build/ucx/ucp_client_server &
# sleep 1
# build/ucx/ucp_client_server -a 127.0.0.1
# wait

build/ucx/ucp_hello_world &
pid0=$!
sleep 1
build/ucx/ucp_hello_world -n 127.0.0.1
pid0=$1
wait "${pid0}"
wait "${pid1}"

ip addr
# build/ucx/uct_hello_world -d eth0 -t tcp &
# sleep 1
# build/ucx/uct_hello_world -d eth0 -t tcp  -n 127.0.0.1
# wait
