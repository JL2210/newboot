#!/bin/sh

gcc -m16 -c boot.S -o boot.o
ld -melf_i386 boot.o -o boot.com -Tldscripts/dos.lds
gcc -m16 -c lib/newboot.S -o newboot.o
ar rc libnewboot.a newboot.o
