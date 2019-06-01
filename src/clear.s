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

.globl bios_clear
bios_clear:
	pusha
	xor %ah, %ah
	mov $0x03, %al
	int $0x10
	mov $0x07, %ah
	mov %ah, %bh
	xor %cx, %cx
	mov $80-1, %dl
	mov $25-1, %dh
	int $0x10
	mov $0x01, %ah
	mov $0x2607, %cx
	int $0x10
	popa
	ret
