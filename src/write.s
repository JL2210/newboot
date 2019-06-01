#
#  Copyright (C) 2019 James Larrowe
#
#  This file is part of Newboot.
#
#  Newboot is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  Newboot is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with Newboot.  If not, see <https://www.gnu.org/licenses/>.
#

.globl bios_write
bios_write:
	STACK_INIT
	pusha
	mov 4(%bp), %cx
	mov 6(%bp), %si
0:	cmp $0, %cx
	je 1f
	lodsb
	push %ax
	call bios_putchar
	pop %ax
	dec %cx
	jmp 0b
1:	popa
	STACK_FINI
	ret
#include "putchar.s"
