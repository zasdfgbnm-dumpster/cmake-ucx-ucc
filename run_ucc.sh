#!/bin/bash

set -eux

build/ucc/main 2 0 &
pid0=$!

build/ucc/main 2 1 &
pid1=$!

wait "${pid0}"
wait "${pid1}"

echo "Succeed"
