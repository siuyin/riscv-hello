	.file	"main.c"
	.option pic
	.attribute arch, "rv32e1p9_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 4
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.align	1
	.globl	puts
	.type	puts, @function
puts:
.LFB1:
	.file 1 "main.c"
	.loc 1 14 20
	.cfi_startproc
.LVL0:
	.loc 1 15 2
	.loc 1 15 8
	.loc 1 15 9 is_stmt 0
	lbu	a4,0(a0)
.LBB6:
.LBB7:
	.loc 1 8 23
	li	a5,268513280
	lw	a5,0(a5)
.LBE7:
.LBE6:
	.loc 1 15 8
	beq	a4,zero,.L5
.LBB11:
.LBB8:
	.loc 1 9 10
	li	a3,268513280
.L4:
.LBE8:
.LBE11:
	.loc 1 15 13 is_stmt 1 discriminator 2
	.loc 1 15 23 is_stmt 0 discriminator 2
	addi	a0,a0,1
.LVL1:
.LBB12:
.LBB9:
	.loc 1 8 2 is_stmt 1 discriminator 2
.L3:
	.loc 1 8 35
	.loc 1 8 8
	blt	a5,zero,.L3
	.loc 1 9 2
	.loc 1 9 10 is_stmt 0
	sw	a4,0(a3)
	.loc 1 11 2 is_stmt 1
.LVL2:
.LBE9:
.LBE12:
	.loc 1 15 8
.LBB13:
.LBB10:
	.loc 1 9 10 is_stmt 0
	mv	a5,a4
.LBE10:
.LBE13:
	.loc 1 15 9
	lbu	a4,0(a0)
	.loc 1 15 8
	bne	a4,zero,.L4
.L5:
.LBB14:
.LBB15:
	.loc 1 8 35 is_stmt 1
	.loc 1 8 8
	blt	a5,zero,.L5
	.loc 1 9 2
	.loc 1 9 10 is_stmt 0
	li	a5,268513280
	li	a4,10
	sw	a4,0(a5)
	.loc 1 11 2 is_stmt 1
.LBE15:
.LBE14:
	.loc 1 17 1 is_stmt 0
	ret
	.cfi_endproc
.LFE1:
	.size	puts, .-puts
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"Hello RISC-V from C!"
	.align	2
.LC1:
	.string	"bye"
	.section	.text.startup,"ax",@progbits
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB2:
	.loc 1 19 13 is_stmt 1
	.cfi_startproc
	.loc 1 20 2
	.loc 1 19 13 is_stmt 0
	addi	sp,sp,-12
	.cfi_def_cfa_offset 12
	.loc 1 20 2
	lla	a0,.LC0
	.loc 1 19 13
	sw	ra,8(sp)
	.cfi_offset 1, -4
	.loc 1 20 2
	call	puts@plt
.LVL3:
	.loc 1 21 2 is_stmt 1
	.loc 1 22 1 is_stmt 0
	lw	ra,8(sp)
	.cfi_restore 1
	.loc 1 21 2
	lla	a0,.LC1
	.loc 1 22 1
	addi	sp,sp,12
	.cfi_def_cfa_offset 0
	.loc 1 21 2
	tail	puts@plt
.LVL4:
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.text
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x113
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.byte	0x1
	.4byte	.LASF5
	.byte	0xc
	.4byte	.LASF6
	.4byte	.LASF7
	.4byte	.Ldebug_ranges0+0x28
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x2
	.4byte	.LASF0
	.byte	0x1
	.byte	0x1
	.byte	0x16
	.4byte	0x31
	.byte	0x3
	.byte	0x4
	.byte	0x7
	.4byte	.LASF2
	.byte	0x2
	.4byte	.LASF1
	.byte	0x1
	.byte	0x2
	.byte	0x17
	.4byte	0x44
	.byte	0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.byte	0x4
	.4byte	.LASF8
	.byte	0x1
	.byte	0x13
	.byte	0x6
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.byte	0x1
	.byte	0x9c
	.4byte	0x8c
	.byte	0x5
	.4byte	.LVL3
	.4byte	0x8c
	.4byte	0x78
	.byte	0x6
	.byte	0x1
	.byte	0x5a
	.byte	0x5
	.byte	0x3
	.4byte	.LC0
	.byte	0
	.byte	0x7
	.4byte	.LVL4
	.4byte	0x8c
	.byte	0x6
	.byte	0x1
	.byte	0x5a
	.byte	0x5
	.byte	0x3
	.4byte	.LC1
	.byte	0
	.byte	0
	.byte	0x8
	.4byte	.LASF9
	.byte	0x1
	.byte	0xe
	.byte	0x6
	.4byte	.LFB1
	.4byte	.LFE1-.LFB1
	.byte	0x1
	.byte	0x9c
	.4byte	0xe5
	.byte	0x9
	.string	"s"
	.byte	0x1
	.byte	0xe
	.byte	0x11
	.4byte	0xe5
	.4byte	.LLST0
	.byte	0xa
	.4byte	0xf2
	.4byte	.LBB6
	.4byte	.Ldebug_ranges0+0
	.byte	0x1
	.byte	0xf
	.byte	0xd
	.4byte	0xce
	.byte	0xb
	.4byte	0x103
	.4byte	.LLST1
	.byte	0
	.byte	0xc
	.4byte	0xf2
	.4byte	.LBB14
	.4byte	.LBE14-.LBB14
	.byte	0x1
	.byte	0x10
	.byte	0x2
	.byte	0xd
	.4byte	0x103
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x4
	.4byte	0xeb
	.byte	0x3
	.byte	0x1
	.byte	0x8
	.4byte	.LASF4
	.byte	0xf
	.4byte	.LASF10
	.byte	0x1
	.byte	0x7
	.byte	0xc
	.4byte	0x10f
	.byte	0x1
	.4byte	0x10f
	.byte	0x10
	.string	"ch"
	.byte	0x1
	.byte	0x7
	.byte	0x1c
	.4byte	0x38
	.byte	0
	.byte	0x11
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0x1b
	.byte	0xe
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x97,0x42
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x89,0x82,0x1
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x8a,0x82,0x1
	.byte	0
	.byte	0x2
	.byte	0x18
	.byte	0x91,0x42
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x89,0x82,0x1
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x95,0x42
	.byte	0x19
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x97,0x42
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x52
	.byte	0x1
	.byte	0x55
	.byte	0x17
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x1d
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x58
	.byte	0xb
	.byte	0x59
	.byte	0xb
	.byte	0x57
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x5
	.byte	0
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0xf
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x49
	.byte	0x13
	.byte	0x20
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x10
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x11
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL1
	.4byte	.LFE1
	.2byte	0x1
	.byte	0x5a
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL1
	.4byte	.LVL2
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x24
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.LFB2
	.4byte	.LFE2-.LFB2
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.4byte	.LBB6
	.4byte	.LBE6
	.4byte	.LBB11
	.4byte	.LBE11
	.4byte	.LBB12
	.4byte	.LBE12
	.4byte	.LBB13
	.4byte	.LBE13
	.4byte	0
	.4byte	0
	.4byte	.Ltext0
	.4byte	.Letext0
	.4byte	.LFB2
	.4byte	.LFE2
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF10:
	.string	"putchar"
.LASF2:
	.string	"unsigned int"
.LASF1:
	.string	"uint8_t"
.LASF0:
	.string	"size_t"
.LASF8:
	.string	"main"
.LASF6:
	.string	"main.c"
.LASF3:
	.string	"unsigned char"
.LASF7:
	.string	"/home/siuyin/riscv64-linux/src/c_embed"
.LASF5:
	.string	"GNU C17 10.2.0 -march=rv32ec -mabi=ilp32e -g -O2 -fpic"
.LASF9:
	.string	"puts"
.LASF4:
	.string	"char"
	.ident	"GCC: () 10.2.0"
