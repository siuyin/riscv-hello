#!/bin/sh
riscv64-unknown-elf-gcc -march=rv32g \
	-mabi=ilp32 -static \
	-mcmodel=medany -fvisibility=hidden \
	-nostdlib -nostartfiles \
	-Tred-v.ld embedhello.s -o embedhello

riscv64-unknown-elf-size embedhello

riscv64-unknown-elf-objcopy -O ihex embedhello embedhello.hex
