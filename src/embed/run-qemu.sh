#!/bin/sh
echo "exit QEMU: Ctrl a x\n\n"

qemu-system-riscv32 -machine sifive_e \
        -nographic -bios none \
        -kernel embedhello-qemu


