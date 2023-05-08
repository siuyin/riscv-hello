OUTPUT_ARCH("riscv")
OUTPUT_FORMAT("elf32-littleriscv")

ENTRY( _start )
SECTIONS
{
	/*
	 https://github.com/qemu/qemu/blob/792f77f376adef944f9a03e601f6ad90c2f891b2/hw/riscv/sifive_e.c#L15
	*/
	. = 0x20400000;
	.text : { *(.text) }
	.gnu_build_id : { *(.note.gnu.build-id) }
	.rodata : { * (.rodata) }

	. = 0x80000000;
	.data : { *(.data) }
	.sdata : { *(.sdata) }
	.debug : { *(.debug) }
	. += 0x1000;
	stack_top = .;

	_end = .;
}
