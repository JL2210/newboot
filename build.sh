#!/bin/sh

runcommand()
{
	echo ${@}
	${@}
}

CC=${CC:=gcc}
LD=${LD:=ld}
AR=${AR:=ar}
CC="${CC} -ffreestanding -fno-stack-protector -fno-PIE -nostdlib"

runcommand ${CC} -m16 -c boot.S -o boot.o
runcommand ${LD} boot.o -o boot.com -Tldscripts/boot.lds
runcommand ${CC} -m16 -c stage2.S -o stage2.o
runcommand ${LD} stage2.o -o stage2.com -Tldscripts/boot.lds
runcommand ${CC} -m16 -c lib/newboot.S -o newboot.o
runcommand ${AR} rc libnewboot.a newboot.o
echo "cat boot.com stage2.com > test.com"
cat boot.com stage2.com > test.com
runcommand chmod a+x test.com
