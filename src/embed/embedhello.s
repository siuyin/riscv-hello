.align 2
.equ UART_REG_TXFIFO, 0
.equ UART_BASE, 0x10013000

.section .text
.globl _start

_start:
	csrr 	t0, mhartid	# load the mhartid (machine hardware thread ID) control and status register into t0
	bnez 	t0, halt	# branch to halt if the hartid is not zero -- all other threads are halted

	la	sp, stack_top	# load address stack_top (from linker script) into stack pointer
	la	a0, msg		# load address of msg into a0 (argument 0) register, t0 above is temporary 0
	jal	puts		# jump and link: call puts 

	la	a0, msg2	# call puts again but now with msg2
	jal	puts

	j	halt		# end the program

puts:
	li	t0, UART_BASE

.puts_loop: lbu	t1, (a0)
	beqz	t1, .puts_leave

.puts_wait: lw	t2, UART_REG_TXFIFO(t0)
	bltz	t2, .puts_wait

	sw	t1, UART_REG_TXFIFO(t0)
	add	a0, a0, 1

	j	.puts_loop

.puts_leave:
	ret


halt: 	j 	halt

.section .rodata
msg:
	.string "Hello risc-v!\n"

msg2:
	.string "This is my second string.\n"
