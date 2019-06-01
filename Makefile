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

LANG ?= c

XC = $(CROSS_COMPILE)g$(LANG)c
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
CFLAGS = -ffreestanding -fno-stack-protector -fno-PIE -Wall -Wextra -Os -I./src/$(LANG)

SOURCE = src/$(LANG)/main.$(LANG) src/$(LANG)/putchar.$(LANG) src/$(LANG)/start.$(LANG) src/$(LANG)/write.$(LANG)
OBJ = obj/32/io.o obj/32/keyboard.o obj/32/main.o obj/32/putchar.o obj/32/start.o obj/32/write.o

.PRECIOUS: obj/16/%.o obj/32/%.o

all: ld-scripts test.com libnewboot.a

efi:
	@$(MAKE) -C src/efi all

ld-scripts:
	@$(MAKE) -C ldscripts all

stage2.com: obj/32/start.o obj/32/main.o obj/32/clear.o obj/32/write.o obj/32/putchar.o obj/32/video.o
%.com: obj/16/%.o
	$(LD) $^ -o $@ -Tldscripts/boot.lds

test.com: boot.com stage2.com
	cat boot.com stage2.com > test.com
	truncate --size=8K test.com
	chmod a+x test.com

libnewboot.a: obj/16/newboot.o obj/32/write.o obj/32/putchar.o
	$(AR) rc $@ $^

obj/16/stage2.S: src/clear.s src/error.s src/setcursor.s
obj/16/boot.S: src/getip.s src/error.s src/relocate.s
obj/16/%.o: %.S
	@mkdir -p obj/16 || true
	$(CC) $(CFLAGS) -m16 -c $< -o $@

obj/32/%.o: src/$(LANG)/%.$(LANG)
	@mkdir -p obj/32 || true
	$(XC) $(CFLAGS) -m32 -c $< -o $@
	objcopy --strip-unneeded $@

clean:
	@$(MAKE) -C src/efi clean
	@$(MAKE) -C ldscripts clean
	rm -f *.com *.a
	rm -rf obj/

.PHONY: all clean ld-scripts
