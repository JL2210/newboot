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

	reloc_addr = 0x0600

/* Relocate the bootloader to a different address */
.globl _relocate
_relocate:
	cld
        mov $0x100, %cx
        xor %ax, %ax
        mov %ax, %ds
        mov %ax, %es
        mov %bx, %si
        mov $reloc_addr, %di
        rep movsw
        jmp reloc_addr
