/* blink48.S sets the device to run at 48MHz.
 */ 

.align 2

.equ RCC_BASE, 0x40021000
.equ RCC_CTLR, 0x0
.equ RCC_CFGR0, 0x4
.equ RCC_INTR, 0x8
.equ RCC_APB2PCENR, 0x18

.equ FLASH_BASE, 0x40022000
.equ FLASH_ACTLR, 0x0

.equ GPIOD_BASE, 0x40011400
.equ GPIOD_CFGLR, 0x0
.equ GPIOD_BSHR, 0x10

.section .text
.globl _start

_start:
	# load address _eusrstack (from linker script) into stack pointer
	la sp, _eusrstack

RCC_set_48MHz:
	li t0, RCC_BASE

	# set AHB divider to /1
	sw zero, RCC_CFGR0(t0)

	# turn on PLL
	lw t1, RCC_CTLR(t0)
	li t2, 1<<24
	or t1, t1, t2
	sw t1, RCC_CTLR(t0)

	# set flash latency to 1 cycle
	li t2, FLASH_BASE
	li t1, 0x01
	sw t1, FLASH_ACTLR(t2)

	# clear PLL, CSSC, HSE, HSI and LSI ready flags 
	li t1, 0x009F0000
	sw t1, RCC_INTR(t0)

	# wait till PLL is ready
	li t2, 1<<25
.rcc_ctlr_pll_not_ready:
	lw t1, RCC_CTLR(t0)
	and t1, t1, t2
	beqz t1, .rcc_ctlr_pll_not_ready

	# set PLL as clock source
	lw t1, RCC_CFGR0(t0)
	ori t1, t1, 0b10
	sw t1, RCC_CFGR0(t0)

GPIOD_clk_en:
	# turn on clock to GPIOD to enable it
	li t0, RCC_BASE
	li t1, 1<<5
	sw t1, RCC_APB2PCENR(t0)

gpiod_pd0_out:
	# configure GPIOD
	li t0, GPIOD_BASE
	lw t1, GPIOD_CFGLR(t0)
	andi t1,t1,~(0xf)
	ori t1,t1,1
	sw t1, GPIOD_CFGLR(t0)

pd0_on:
	# turn on LED connected to PD0
	li t0, GPIOD_BASE
.pd0_on_1:
	li t1, 1
	sw t1, GPIOD_BSHR(t0)
	jal delay

pd0_off:
	li t1, 1<<16
	sw t1, GPIOD_BSHR(t0)
	jal delay

repeat:
	j .pd0_on_1


delay:
	li a0, 500000
.delay_1:
	addi a0, a0, -1
	beqz a0, .delay_end
	j .delay_1
	
.delay_end:
	ret

halt: 	j halt
