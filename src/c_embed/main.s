	.file	"main.c"
	.option pic
	.attribute arch, "rv32e1p9_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 4
	.text
	.align	1
	.type	putchar, @function
putchar:
	addi	sp,sp,-8
	sw	s0,4(sp)
	addi	s0,sp,8
	mv	a5,a0
	sb	a5,-5(s0)
	nop
.L2:
	li	a5,268513280
	lw	a5,0(a5)
	blt	a5,zero,.L2
	li	a5,268513280
	lbu	a4,-5(s0)
	sw	a4,0(a5)
	lbu	a5,-5(s0)
	mv	a0,a5
	lw	s0,4(sp)
	addi	sp,sp,8
	jr	ra
	.size	putchar, .-putchar
	.align	1
	.globl	puts
	.type	puts, @function
puts:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	sw	a0,-16(s0)
	j	.L5
.L6:
	lw	a5,-16(s0)
	addi	a4,a5,1
	sw	a4,-16(s0)
	lbu	a5,0(a5)
	mv	a0,a5
	call	putchar
.L5:
	lw	a5,-16(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L6
	li	a0,10
	call	putchar
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	puts, .-puts
	.section	.rodata
	.align	2
.LC0:
	.string	"Hello RISC-V from C"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-12
	sw	ra,8(sp)
	sw	s0,4(sp)
	addi	s0,sp,12
	lla	a0,.LC0
	call	puts@plt
	nop
	lw	ra,8(sp)
	lw	s0,4(sp)
	addi	sp,sp,12
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 10.2.0"
