.equ UART_REG_TXFIFO, 0
.equ UART_BASE, 0x10013000

.section .text
.globl main

main:	
	jal	junk
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
