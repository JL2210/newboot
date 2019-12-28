/*
 *  Copyright (C) 2019 James Larrowe
 *
 *  This file is part of Newboot.
 *
 *  Newboot is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Newboot is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with Newboot.  If not, see <https://www.gnu.org/licenses/>.
 */

#define STACK_INIT push %bp; mov %sp, %bp
#define STACK_FINI leave

/* Stage 2 */
.code16
	jmp _start
gdt_start:
	.quad 0 # Null segment
gdt_code:
	.word 0xffff # Segment limit
	.word 0 # Base
	.byte 0 # Base cont.
	.byte 0b10011010 # Access -- RX
	.byte 0b11001111
	.byte 0
gdt_data:
	.word 0xffff
	.word 0
	.byte 0
	.byte 0b10010010 # RW
	.byte 0b11001111
	.byte 0
gdt_end:
	CODE_SEG = gdt_code - gdt_start
	DATA_SEG = gdt_data - gdt_start
gdt_pointer:
	.word gdt_end - gdt_start - 1
	.long gdt_start
.globl _start
_start:
	/* ch:dh:cl contain the CHS address of this sector */
	call _enable_a20
	test %ax, %ax
	jz _error
	/* TODO: Read FAT and read executable from file */
	mov $0x020a, %ax /* Reduce size by a byte */
	mov $_end, %bx
	inc %cl /* TODO: check for overflow */
	int $0x13
	jc _error
	cli
	lgdt gdt_pointer
	mov %cr0, %eax
	or $0x01, %eax
	mov %eax, %cr0
	ljmp $CODE_SEG, $_enter_pm
#include "a20.s"
#include "error.s"
.code32
_enter_pm:
	mov $DATA_SEG, %ax
	mov %ax, %ds
	mov %ax, %ss
	mov %ax, %es
	jmp _start_c
	hlt
buf:
	. = .text + 0x01fe
magic:
	.word 0xaa55
_end:
