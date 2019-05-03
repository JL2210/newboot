#include <newboot.h>

#define KB_ACK 0xFA
#define KB_RESEND 0xFE
#define KB_CON 0x64
#define KB_DATA 0x60

uint8_t kbd_sc[0xff] =
{
	'?', '?', '1', '2', '3', '4', '5', '6',
	'7', '8', '9', '0', '-', '=', '?', '?',
	'q', 'w', 'e', 'r', 't', 'y', 'u', 'i',
	'o', 'p', '[', ']', '?', '?', 'a', 's',
	'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
	'\'', 'z', 'x', 'c', 'v', 'b', 'n', 'm',
	',', '.', '/', '?', '?', '?', ' '
};

int pm_getchar(uint8_t kbd[])
{
	int ch;
	ch = pm_getsc();
	return kbd[ch];
}

int pm_getsc(void)
{
	int ch;
	ch = inb(KB_DATA);
	return ch;
}

void keyboard_init(void)
{
	static int ctr;
	if(!ctr)
	{
		ctr++;
	}
}
