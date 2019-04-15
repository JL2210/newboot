#!/bin/sh

gcc -c boot.S
ld boot.o -o boot -Tldscripts/boot.lds
ld boot.o -o boot.com -Tldscripts/dos.lds
gcc -c src/newboot.S
ar rc libbios.a newboot.o
