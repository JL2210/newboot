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

ARCH = $(shell gcc -dumpmachine | cut -d- -f1)
BUILD = $(shell echo $(ARCH) | sed s,i[3456789]86,ia32,)

PREFIX = /usr/local/prefix32/usr
OBJS = start.o
SO_TARGET = start.so
TARGET = start.efi

EFIINC = $(PREFIX)/include/efi
EFIINCS = -I$(EFIINC) -I$(EFIINC)/$(BUILD) -I$(EFIINC)/protocol
LIB = $(PREFIX)/lib
EFILIB = $(LIB)

EFI_CRT_OBJS = $(EFILIB)/crt0-efi-$(BUILD).o
EFI_LDS = $(EFILIB)/elf_$(BUILD)_efi.lds

CFLAGS = $(EFIINCS) -fno-stack-protector -fpic \
		-fshort-wchar -mno-red-zone -Wall
ifeq ($(BUILD),x86_64)
 CFLAGS += -DEFI_FUNCTION_WRAPPER
endif

LDFLAGS	 = -nostdlib -znocombreloc -T $(EFI_LDS) -shared \
		-Bsymbolic -L $(EFILIB) -L $(LIB) $(EFI_CRT_OBJS)

all: $(TARGET)

$(SO_TARGET): $(OBJS)
	ld $(LDFLAGS) $(OBJS) -o $@ -lefi -lgnuefi

%.efi: %.so
	objcopy -j .text -j .sdata -j .data -j .dynamic \
		-j .dynsym  -j .rel -j .rela -j .reloc \
		--target=efi-app-$(BUILD) $^ $@

clean:
	rm -f *.o *.so *.efi
