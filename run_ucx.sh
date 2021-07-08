#!/bin/bash
set -eux
build/ucx/ucp_client_server &
sleep 1
build/ucx/ucp_client_server -a 127.0.0.1
wait
