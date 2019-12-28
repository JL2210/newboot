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
	/* Sets ds and es so we don't have to here */
	jne _relocate
	cli
	mov $0x0080, %ax /* Set up stack segment */
	mov %ax, %ss
	mov $0x7500, %sp /* Set up temporary stack pointer */
	sti
	/* %ah is already 0 from setting the stack segment */
	int $0x13
	jc _error
	/* Work backwards to find the disk marked "bootable" */
	lea magoff(%bx), %si
	lea mbroff(%bx), %cx
0:
	cmp %cx, %si
	je _error /* End of partition table */
	/* TODO: better error messages */
	sub $0x10, %si
	testb $0x80, (%si)
	jz 0b
	/* When we get here, si holds the bootable record */
	mov 1(%si), %dh
	mov 2(%si), %cl
	mov 3(%si), %ch
	mov $0x0201, %ax /* Save a byte -- one move instead of two */
	mov $_start, %bx
	mov %ah, %cl /* A.K.A. mov $0x02, %cl */
	int $0x13
	jc _error
	cmp $0x01, %al
	jne _error
	mov 510(%bx), %ax
	cmp $0xaa55, %ax
	jne _error
	jmp *%bx
#include "getip.s"
#include "error.s"
#include "relocate.s"
/* Fill to 512 bytes */
buf:
	. = .text + 446
mbr:
	mbroff = . - .text
	. = .text + 510
/* BIOS magic number */
magic:
	magoff = . - .text
	.word 0xaa55
