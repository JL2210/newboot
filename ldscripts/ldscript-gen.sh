#!/bin/sh

cat << "_EOF_"
OUTPUT_ARCH(i8086)
SECTIONS {
_EOF_
echo "	. = ${1};"
cat << "_EOF_"
}
ENTRY(_start)
OUTPUT_FORMAT(binary)
_EOF_
