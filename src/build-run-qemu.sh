#!/bin/sh
#riscv64-unknown-elf-gcc -march=rv32gc \
riscv64-unknown-elf-gcc -march=rv32ec \
	-mabi=ilp32e -static \
	-mcmodel=medany -fvisibility=hidden \
	-nostdlib -nostartfiles \
	-Tred-qemu.ld embedhello.s -o embedhello

riscv64-unknown-elf-size embedhello

echo "exit QEMU: Ctrl a x\n\n"

qemu-system-riscv32 -machine sifive_e \
        -nographic -bios none \
        -kernel embedhello


