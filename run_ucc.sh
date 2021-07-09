#!/bin/bash

set -eux

build/ucc/main 2 0 &
build/ucc/main 2 1 &
wait
