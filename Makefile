CC = gcc
LD = ld
AR = ar
CFLAGS = -ffreestanding -fno-stack-protector -fno-PIE -Wall -Wextra
LDFLAGS =

C_SOURCE = src/c/io.c src/c/keyboard.c src/c/main.c src/c/putchar.c src/c/start_c.c src/c/write.c
C_OBJ = obj/32/io.o obj/32/keyboard.o obj/32/main.o obj/32/putchar.o obj/32/start_c.o obj/32/write.o

all: ld-scripts test.com

clean:
	@$(MAKE) -C ldscripts clean
	rm -f *.com *.a
	rm -rf obj/

stage2.com: obj/32/start_c.o obj/32/main.o obj/32/write.o obj/32/putchar.o obj/32/keyboard.o obj/32/io.o
%.com: obj/16/%.o
	$(LD) $(LDFLAGS) $^ -o $@ -Tldscripts/boot.lds

test.com: boot.com stage2.com
	cat boot.com stage2.com > test.com
	truncate --size=1M test.com
	chmod a+x test.com

obj/16/stage2.S: src/clear.s src/error.s src/setcursor.s
obj/16/boot.S: src/getip.s src/error.s src/relocate.s
obj/16/%.o: %.S
	@mkdir -p obj/16 || true
	$(CC) $(CFLAGS) -m16 -c $< -o $@

obj/32/%.o: src/c/%.c
	@mkdir -p obj/32 || true
	$(CC) $(CFLAGS) -m32 -Os -I./include -c $< -o $@

ld-scripts:
	@$(MAKE) -C ldscripts all
