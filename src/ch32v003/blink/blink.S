.align 2

#include "ch32v003fun.h"
//#define RCC_APB2PCENR (RCC_BASE + 0x18)
//#define GPIOD_CFGLR (GPIOD_BASE + 0x1400)
.equ RCC_APB2PCENR, 0x40021018
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
	li t1, RCC_APB2PCENR
	sw t0, 0(t1)

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
	li t1, 1
	sw t1, 0(t0)

pd0_off:
	li t1, 1<<16
	sw t1, 0(t0)

repeat:
	j pd0_on
	

	j halt

halt: 	j 	halt