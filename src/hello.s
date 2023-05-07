# Simple RISC-V hello world.

.global _start

.text
_start:
	addi	a0, x0, 1		# addi is add immediate. x0 is the zero-value register, 1+0 -> a0
	la	a1, helloworld		# la is load address
	addi	a2, x0, 13

	addi	a7, x0, 64		# 64 is the syscall to write
	ecall

_end:
	addi	a0, x0, 0		# return code is 0

	addi	a7, x0, 93		# 93 is the syscall to terminate
	ecall

.data
helloworld:
	.ascii	"Hello World!\n"
