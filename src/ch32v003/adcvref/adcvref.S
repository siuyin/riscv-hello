/* adcvref.S prints the value on the device's
 * internal voltage reference to the uart.
 * Connect PD5(uart TX) to the RX of your terminal.
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

.equ ADC_BASE, 0x40012400
.equ ADC_STATR, 0x0
.equ ADC_CTLR1, 0x04
.equ ADC_CTLR2, 0x08
.equ ADC_SAMPTR1, 0x0c
.equ ADC_SAMPTR2, 0x10
.equ ADC_RSQR1, 0x2c
.equ ADC_RSQR2, 0x30
.equ ADC_RSQR3, 0x34
.equ ADC_RDATAR, 0x4c

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

	# enable RX,TX on USART_CTLR1
	li t0, USART_BASE
	lw t1, USART_CTLR1(t0)
	li t2, 1<<2 | 1<<3
	or t1, t1, t2
	sw t1, USART_CTLR1(t0)

	# set BR R (bit rate register) 26.042 = 48MHz/(16 * 115200); 0.667 = 0.042*16 => round to 1
	li t1, (26<<4) + 1
	sw t1, USART_BRR(t0)

	# enable uart
	lw t1, USART_CTLR1(t0)
	li t2, 1<<13
	or t1, t1, t2
	sw t1, USART_CTLR1(t0)

send_startup_msg:
	la a0, msg0
	jal Put_string

enable_clock_to_adc:
	# set ADC PRE in RCC CFG R0 to /4 for 12Mhz ADC clock (max permited for 3.3V VDD)
	li t0, RCC_BASE
	lw t1, RCC_APB2PCENR(t0)
	li t2, 1<<9
	or t1, t1, t2
	sw t1, RCC_APB2PCENR(t0)
	
	# turn on ADC with AD ON and wait at least 2 ADC clock cycles (2*4 H CLK cycles)
	li t0, ADC_BASE
	lw t1, ADC_CTLR2(t0)
	ori t1, t1, 1<<0
	sw t1, ADC_CTLR2(t0)

	li t1, 2*2*4 // double the minimum
.adc_wait_init:
	addi t1,t1,-1
	bnez t1, .adc_wait_init

	# reset cal by setting RSTCAL in ADC_CTLR2, wait for bit to clear
	lw t1, ADC_CTLR2(t0)
	ori t1,t1,1<<3
	sw t1, ADC_CTLR2(t0)

	li t2, 1<<3
.adc_wait_cal_reset:
	lw t1, ADC_CTLR2(t0)
	and t1,t1,t2
	bnez t1, .adc_wait_cal_reset
	
	# start cal by setting CAL, wait for bit to clear
	lw t1, ADC_CTLR2(t0)
	ori t1,t1,1<<2
	sw t1, ADC_CTLR2(t0)

	li t2, 1<<2
.adc_wait_cal_done:
	lw t1, ADC_CTLR2(t0)
	and t1,t1,t2
	bnez t1, .adc_wait_cal_done

	# set the number of conversions = 1 in ADC R SQ R1 (regular sequence reg1)
	li t1, 0b0001<<20
	sw t1, ADC_RSQR1(t0)

	# set sampling time for channel 8 and 9
	lw t1, ADC_SAMPTR2(t0)
	li t2, (0b001<<8) | (0b001<<9)
	or t1,t1,t2
	sw t1, ADC_SAMPTR2(t0)
	
	# set the channel to be converted, Vref=ch8, for the 1st conversion, the field is in ADC_RSQR3.
	li t1, 8
	#li t1, 9
	sw t1, ADC_RSQR3(t0)
	
send_conversion_start_msg:
	la a0, msg1
	jal Put_string
.start_conv:
	# ADON to start measuring. Data will be in ADC_RDATAR
	li t0, ADC_BASE
	lw t1, ADC_CTLR2(t0)
	ori t1,t1, 1<<0
	sw t1, ADC_CTLR2(t0)

	# wait for end of conversion
	# EOC in ADC_STATR will be set after converson, cleared by reading ADC_RDATAR.
.wait_for_eoc:
	lw t1, ADC_STATR(t0)
	andi t1, t1, 1<<1
	beqz t1, .wait_for_eoc
	
	li t0, ADC_BASE
	lw a0, ADC_RDATAR(t0)
	jal Put_hex_half_word

	li a0, 4000000
	jal delay


	j .start_conv

	# data alignment in ADC_CTLR2. Default is right-aligned.
	# single channel conversion. following fields are reset: CONT,SCAN, RDISCEN/IDISCEN, IAUTO in CTLR1 and CTLR2
	# EOC in ADC_STATR will be set after converson, cleared by reading ADC_RDATAR.
	# CALVOL in ADC_CTLR1 allows AD9 to be VDD/2 or 3/4*VDD
	# start conversion with SWSTART on ADC_CTLR2 ? may also need to set ADON in ADC_CTLR2.

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


Put_hex_half_word:
	mv a1,a0
	srli a0,a0,8
	li t0, USART_BASE
	jal t0, Put_char 

	mv a0,a1
	jal t0, Put_char

	ret

Put_char:
	li t2, USART_BASE
.put_char_wait:
	lw t1, USART_STATR(t2)
	andi t1, t1, (1<<7)
	beqz t1, .put_char_wait
	sb a0, USART_DATAR(t2)
	jalr zero,t0,0
	
delay:
	addi a0,a0,-1
	bnez a0, delay
	ret

halt: 	j halt

.section .rodata

msg0:
	.string "reading Vref on analog in 7\n"
msg1:
	.string "ADC conversion started.\nPlease switch to hexadecimal mode on your terminal.\n"
