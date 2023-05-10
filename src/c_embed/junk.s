	.file	"junk.c"
	.option nopic
	.attribute arch, "rv32e1p9_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 4
	.text
	.align	1
	.globl	junk
	.type	junk, @function
junk:
	addi	sp,sp,-4
	sw	s0,0(sp)
	addi	s0,sp,4
	nop
	lw	s0,0(sp)
	addi	sp,sp,4
	jr	ra
	.size	junk, .-junk
	.ident	"GCC: () 10.2.0"
