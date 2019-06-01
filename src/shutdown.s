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

.globl bios_shutdown
bios_shutdown:
	pusha
	xor %bx, %bx
	mov $0x5301, %ax
	int $0x15
	jc _error
	xor %cx, %cx
	mov $0x530e, %ax
	int $0x15
	jc _error
	mov $0x5307, %ax
	inc %bx
	mov $0x03, %cx
	int $0x15
	jc _error
	popa
	ret
