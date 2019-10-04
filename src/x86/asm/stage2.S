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

	VIDEO_MEM = 0x0b8000

/* Stage 2 */
.code16
	jmp _start
gdt_start:
        .quad 0
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
        .word gdt_end - gdt_start
        .long gdt_start
	.byte 0 # Fix objdump output
.globl _start
_start:
	cli
	xor %ax, %ax
	mov %ax, %ss
	mov %ax, %es
	mov $0x0400, %sp
	push %cs
	pop %ds
	sti
	mov $0x2401, %ax
	int $0x15
	jc _error
	push $0
	call bios_setcursor
	pop %ax
	mov $0x02, %ah
	mov $0x0a, %al
	mov $_end, %bx
	mov $0x03, %cl
	int $0x13
	jc _error
	cli
	lgdt gdt_pointer
	mov %cr0, %eax
	or $0x01, %eax
	mov %eax, %cr0
	ljmp $CODE_SEG, $_enter_pm
#include "error.s"
#include "setcursor.s"
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
