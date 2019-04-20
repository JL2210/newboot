/* Stage 2 */
.code16
.globl _start
_start:
	cli
	hlt
buf:
	.fill 0x01fe-(.-_start), 1, 0
magic:
	.word 0xaa55
