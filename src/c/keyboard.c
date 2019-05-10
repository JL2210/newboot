#include <newboot.h>

#define KB_ACK 0xFA
#define KB_RESEND 0xFE
#define PS2_CON 0x64
#define KB_DATA 0x60

uint8_t kbd_sc[0xff] =
{
	0, 27, '1', '2', '3', '4', '5', '6',
	'7', '8', '9', '0', '-', '=', '\b',
	'\t', 'q', 'w', 'e', 'r', 't', 'y',
	'u', 'i', 'o', 'p', '[', ']', '\r' | '\n',
	0, 'a', 's', 'd', 'f', 'g', 'h',
	'j', 'k', 'l', ';', '\'', '`', 0,
	'\\', 'z', 'x', 'c', 'v', 'b', 'n',
	'm', ',', '.', '/', 0, '*', 0, ' ',
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, '-', 0, 0, 0, '+', 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0, 0
};

uint8_t pm_getchar(uint8_t kbd[])
{
	uint8_t ch = 0;
	ch = pm_getsc();
	if( ch & 0x80 )
		ch &= ~0x80;
	return kbd[ch];
}

uint8_t pm_getsc(void)
{
	uint8_t ch = 0;
	ch = inb(KB_DATA);
	return ch;
}
