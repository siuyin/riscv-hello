CC=riscv64-unknown-elf-gcc -nostdlib -Wno-builtin-declaration-mismatch -march=rv32ec -mabi=ilp32e -fpic
AS=riscv64-unknown-elf-as -march=rv32ec
LD=riscv64-unknown-elf-ld -nostdlib -melf32lriscv -Tred-qemu.ld
SIZE=riscv64-unknown-elf-size
OBJDUMP=riscv64-unknown-elf-objdump

OBJS=c_embed startup.o main.o 

all: c_embed

c_embed: startup.o main.o
	$(LD) -o c_embed startup.o main.o
	$(SIZE) c_embed

%.o: %.s
	$(AS) -o $@ $<

main.s: main.c
	$(CC) -o main.s -S main.c

.PHONY: clean
clean:
	rm -f $(OBJS)

.PHONY: dump
dump: c_embed
	$(OBJDUMP) -d c_embed
