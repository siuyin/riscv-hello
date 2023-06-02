/* blink24.S sets the HPRE field in RCC_CFGR0
 * to enable HCLK to run at 24 MHz
 */ 

.align 2

.equ RCC_BASE, 0x40021000
.equ RCC_CFGR0, 0x4
.equ RCC_APB2PCENR, 0x18

.equ GPIOD_CFGLR, 0x40011400
.equ GPIOD_BSHR, 0x40011410

.section .text
.globl _start

_start:
	# load address _eusrstack (from linker script) into stack pointer
	la sp, _eusrstack

gpiod_clk_en:
	# turn on clock to GPIOD to enable it
	li t0, 1<<5
	li t1, RCC_BASE
	# set RCC CFG R0 to zero as documented in the reference manual to get 24MHz HSI to HCLK.
	sw zero, RCC_CFGR0(t1)
	sw t0, RCC_APB2PCENR(t1)

gpiod_pd0_out:
	# configure GPIOD
	li t0, GPIOD_CFGLR
	lw t1, 0(t0)
	andi t1,t1,~(0xf)
	ori t1,t1,1
	sw t1, 0(t0)

pd0_on:
	# turn on LED connected to PD0
	li t0, GPIOD_BSHR
.pd0_on_1:
	li t1, 1
	sw t1, 0(t0)
	jal delay

pd0_off:
	li t1, 1<<16
	sw t1, 0(t0)
	jal delay

repeat:
	j .pd0_on_1

delay:
	li a0, 500000
.delay_1:
	addi a0,a0,-1
	beqz a0, .delay_end
	j .delay_1
	
.delay_end:
	ret


	j halt

halt: 	j 	halt
