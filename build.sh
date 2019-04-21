#!/bin/sh

gcc -m16 -c boot.S -o boot.o
ld boot.o -o boot.com -Tldscripts/boot.lds
gcc -m16 -c stage2.S -o stage2.o
ld stage2.o -o stage2.com -Tldscripts/boot.lds
gcc -m16 -c lib/newboot.S -o newboot.o
ar rc libnewboot.a newboot.o
cat boot.com stage2.com > test.com
chmod a+x test.com
