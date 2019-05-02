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
	int ch = 0;
	while(!(ch = pm_getsc()))
		;
	if(ch == -1) return ch;
	else return kbd[ch];
}

int pm_getsc(void)
{
	int ch = 0;
	ch = inb(KB_DATA);
	return ch;
}

int keyboard_init(void)
{
	int ch;
	static int ctr;
	if(!ctr)
	{
		ctr++;
l0:		outb(KB_DATA, 0xFF);
		ch = inb(KB_DATA);
		if(ch != 0xAA) goto l0;
l1:		outb(KB_DATA, 0xF5);
		ch = inb(KB_DATA);
		if(ch != KB_ACK) goto l1;
l2:		outb(KB_DATA, 0xEE);
		ch = inb(KB_DATA);
		if(ch != 0xEE) goto l2;
l3:		outb(KB_DATA, 0xF0);
		ch = inb(KB_DATA);
		if(ch != KB_ACK) goto l3;
		outb(KB_DATA, 0x01);
		ch = inb(KB_DATA);
		if(ch != KB_ACK) goto l3;
l4:		outb(KB_DATA, 0xF4);
		ch = inb(KB_DATA);
		if(ch != KB_ACK) goto l4;
	}
	return 0;
}
