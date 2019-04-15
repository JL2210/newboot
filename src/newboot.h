#ifndef NEWBOOT_H
#define NEWBOOT_H 1

#undef __UINTPTR_MAX__
#define __UINTPTR_MAX__ 0xffffU

#include <stdint.h>

void _start(void);
void bios_clear(void);
char bios_putchar(char);
char bios_getchar(void);
void bios_setcursor(int16_t);
int16_t bios_write(int16_t, int16_t);
int16_t bios_read(int16_t, int16_t);
int16_t bios_syscall(
int16_t,
int16_t,
int16_t,
int16_t,
int16_t,
int16_t,
int16_t);

#endif
