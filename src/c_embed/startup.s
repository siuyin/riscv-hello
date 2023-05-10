.align 2

.section .text
.globl _start

_start:
	csrr 	t0, mhartid
	bnez 	t0, halt

	la	sp, stack_top

	la	a0, msg
	jal	main

halt: 	j 	halt

.section .rodata
msg:
	.string "Hello multi-file linked risc-v!\n"
