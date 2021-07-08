#!/bin/bash

rm -rf build

mkdir -p build/ucx
cmake -S test/ucx -B build/ucx
cmake --build build/ucx

mkdir -p build/ucc
cmake -S test/ucc -B build/ucc
cmake --build build/ucc
