/* uart.S prints hello world to the UART.
 * 112500 8 N 1
 */ 

.align 2
.option rvc

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

.equ USART_BASE, 0x40013800
.equ USART_STATR, 0x0
.equ USART_DATAR, 0x04
.equ USART_BRR, 0x08
.equ USART_CTLR1, 0x0c

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

USART_115200:
	# send clock to to USART(TX=PDr) and GPIOD to enable it
	li t0, RCC_BASE
	lw t1, RCC_APB2PCENR(t0)
	li t2, 1<<14 | 1<<5
	or t1, t1, t2
	sw t1, RCC_APB2PCENR(t0)

	# make GPIOD PD5 alternate function (serial)
	li t0, GPIOD_BASE
	lw t1, GPIOD_CFGLR(t0)
	li t2, ~(0b1111<<(4*5))
	and t1,t1,t2
	li t2, 0b1001<<(4*5)
	or t1, t1, t2
	sw t1, GPIOD_CFGLR(t0)

	# enable RX,TX  USART_CTLR1
	li t0, USART_BASE
	lw t1, USART_CTLR1(t0)
	li t2, 1<<2 | 1<<3
	or t1, t1, t2
	sw t1, USART_CTLR1(t0)

	# set BR R (bit rate register) 26.042 = 48MHz/(16 * 115200). 0.667 = 0.42*16 => round to 1
	li t1, (26<<4) | 1
	sw t1, USART_BRR(t0)

	# enable uart
	lw t1, USART_CTLR1(t0)
	li t2, 1<<13
	or t1, t1, t2
	sw t1, USART_CTLR1(t0)

send_msg:
	la a0, msg
	jal Put_string

	j halt

Put_string:
	li t0, USART_BASE

.puts_loop:
	lbu t1, (a0)
	beqz t1, .puts_leave

.puts_wait:
	# check TX E (TX Empty) in status register
	lw t2, USART_STATR(t0)
	andi t2, t2,(1<<7)
	beqz t2, .puts_wait

	sw t1, USART_DATAR(t0)
	add a0,a0,1

	j .puts_loop
	
.puts_leave:
	ret


halt: 	j halt

.section  .rodata

msg:
	.string "Hello risc-v!\n"
