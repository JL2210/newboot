#!/bin/sh

gcc -m16 -c boot.S -o boot.o
ld boot.o -o boot.com -Tldscripts/boot.lds
gcc -m16 -c pbr.S -o pbr.o
ld pbr.o -o pbr.com -Tldscripts/boot.lds
gcc -m16 -c lib/newboot.S -o newboot.o
ar rc libnewboot.a newboot.o
