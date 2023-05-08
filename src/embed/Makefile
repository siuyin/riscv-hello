CC=riscv64-unknown-elf-gcc
CFLAGS=-march=rv32ec -mabi=ilp32e -static -mcmodel=medany \
	-fvisibility=hidden -nostdlib -nostartfiles
QEMU_LINKER_SCRIPT=-Tred-qemu.ld
EMBED_LINKER_SCRIPT=-Tred-v.ld

SIZE=riscv64-unknown-elf-size
OBJCOPY=riscv64-unknown-elf-objcopy
OBJDUMP=riscv64-unknown-elf-objdump

.SILENT:

all: embedhello embedhello-qemu

embedhello-qemu: embedhello.s
	$(CC) -o embedhello-qemu $(CFLAGS) $(QEMU_LINKER_SCRIPT) embedhello.s
	$(SIZE) embedhello-qemu

embedhello: embedhello.s
	$(CC) -o embedhello $(CFLAGS) $(EMBED_LINKER_SCRIPT) embedhello.s
	$(SIZE) embedhello
	$(OBJCOPY) -O ihex embedhello embedhello.hex

.PHONY: clean
clean:
	rm -f embedhello.o embedhello embedhello-qemu embedhello.hex

.PHONY: dump
dump: embedhello
	$(OBJDUMP) -d embedhello
