#!/bin/sh

set -e

runcommand()
{
	echo ${@}
	${@}
}

CC=${CC:=gcc}
LD=${LD:=ld}
AR=${AR:=ar}
CC="${CC} -ffreestanding -fno-stack-protector -fno-PIE -nostdlib"

mkdir ./obj || true
runcommand ${CC} -m16 -c boot.S -o obj/boot.o
runcommand ${LD} obj/boot.o -o boot.com -Tldscripts/boot.lds
runcommand ${CC} -m16 -c stage2.S -o obj/stage2.o
runcommand ${CC} -m32 -Os -c src/c/start_c.c -o obj/start_c.o
runcommand ${CC} -m32 -Os -I./lib -c src/c/keyboard.c -o obj/keyboard.o
runcommand ${CC} -m32 -Os -I./lib -c src/c/io.c -o obj/io.o
runcommand ${CC} -m32 -Os -I./lib -c src/c/main.c -o obj/main.o
runcommand ${CC} -m32 -I./lib -c src/pm/write.S -o obj/write.o
runcommand ${LD} obj/stage2.o obj/start_c.o obj/main.o obj/write.o obj/keyboard.o obj/io.o -o stage2.com -Tldscripts/boot.lds
runcommand ${CC} -m16 -c lib/newboot.S -o obj/newboot.o
runcommand ${AR} rc libnewboot.a obj/newboot.o obj/io.o obj/keyboard.o
echo "cat boot.com stage2.com > test.com"
cat boot.com stage2.com > test.com
runcommand truncate --size=1M test.com
runcommand chmod a+x test.com
