#!/bin/bash

set -eux

build/ucx/ucp_client_server &
pid0=$!
sleep 1
build/ucx/ucp_client_server -a 127.0.0.1 &
pid1=$!
wait "${pid0}"
wait "${pid1}"

build/ucx/ucp_hello_world &
pid0=$!
sleep 1
build/ucx/ucp_hello_world -n 127.0.0.1 &
pid1=$!
wait "${pid0}"
wait "${pid1}"

ip addr
build/ucx/uct_hello_world -d eth0 -t tcp &
pid0=$!
sleep 1
build/ucx/uct_hello_world -d eth0 -t tcp  -n 127.0.0.1 &
wait "${pid0}"
wait "${pid1}"
