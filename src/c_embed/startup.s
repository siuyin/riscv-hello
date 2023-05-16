.align 2

.section .text
.globl _start

_start:
	csrr 	t0, mhartid
	bnez 	t0, halt

	la	sp, stack_top	# initialize stack

	j	main		# jump to main

halt: 	j 	halt

