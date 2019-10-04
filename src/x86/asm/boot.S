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

.code16
/* Load and jump to second stage */
.globl _start
_start:
	call _GetIP
	cmp $reloc_addr, %bx
	jne _relocate
	cli
	mov $0x8000, %ax
	mov %ax, %ss
	xor %ax, %ax
	mov %ax, %es
	mov %ax, %sp
	push %cs
	pop %ds
	sti
	xor %ah, %ah
	int $0x13
	jc _error
	xor %dh, %dh
	mov $0x02, %ah
	mov $0x01, %al
	mov $_start, %bx
	xor %ch, %ch
	mov %ah, %cl /* A.K.A. mov $0x02, %cl */
	int $0x13
	jc _error
	cmp $0x01, %al
	jne _error
	mov %bx, %si
	add $0x01fe, %si
	mov (%si), %ax
	cmp $0xaa55, %ax
	jne _error
	jmp *%bx
#include "getip.s"
#include "error.s"
#include "relocate.s"
/* Fill to 512 bytes */
buf:
	. = .text + 0x01fe
/* BIOS magic number */
magic:
	.word 0xaa55
