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

ARCH ?= x86

ASM_DIR = src/$(ARCH)/asm

vpath %.c src/$(ARCH)
vpath %.c src/all

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
CFLAGS = -ffreestanding -fno-stack-protector -fno-PIE \
	 -Wall -Wextra -Os -I. -I./include

ALL_SRC = src/all/main.c src/all/start.c src/all/write.c
ARCH_SRC = src/$(ARCH)/clear.c src/$(ARCH)/video.c src/$(ARCH)/putchar.c
ALL_OBJ = obj/32/main.o obj/32/start.o obj/32/write.o
ARCH_OBJ = obj/32/clear.o obj/32/video.o obj/32/putchar.o

.PRECIOUS: obj/16/%.o obj/32/%.o

all: ld-scripts test.com

efi:
	@$(MAKE) -C src/efi all

ld-scripts:
	@$(MAKE) -C ldscripts all

stage2.com: $(ALL_OBJ) $(ARCH_OBJ)
%.com: obj/16/%.o
	$(LD) $^ -o $@ -Tldscripts/boot.lds

test.com: boot.com stage2.com
	cat boot.com stage2.com > test.com
	truncate --size=8K test.com
	chmod a+x test.com

obj/16/stage2.o: $(ASM_DIR)/error.s $(ASM_DIR)/setcursor.s
obj/16/boot.o: $(ASM_DIR)/getip.s $(ASM_DIR)/error.s $(ASM_DIR)/relocate.s
obj/16/%.o: src/$(ARCH)/asm/%.S
	@mkdir -p obj/16 || true
	$(CC) $(CFLAGS) -m16 -c $< -o $@

obj/32/%.o: %.c
	@mkdir -p obj/32 || true
	$(CC) $(CFLAGS) -m32 -c $< -o $@
	objcopy --strip-unneeded $@

clean:
	@$(MAKE) -C src/efi clean
	@$(MAKE) -C ldscripts clean
	rm -f *.com *.a
	rm -rf obj/

.PHONY: all clean ld-scripts
