#!/bin/bash

#riscv64-linux-gnu-gcc -o hello hello.s -nostdlib -static

riscv64-linux-gnu-as -march=rv64imac -o hello.o src/hello.s
riscv64-linux-gnu-ld -o hello hello.o
