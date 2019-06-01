/*
 *  Copyright (C) 2019 James Larrowe
 *
 *  This file is part of Newboot.
 *
 *  Newboot is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Newboot is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with Newboot.  If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef NEWBOOT_H
#define NEWBOOT_H 1

#include <stddef.h>
#include <stdint.h>

#define VIDEO_MEM 0x0b8000
#define LIGHT_GRAY 0x07
#define WHITE 0x0f
#define BLACK 0x00
#define COLOR (vga_color(BLACK, LIGHT_GRAY))
#define COLUMNS 80
#define ROWS 25

#ifndef __GNUC__
# define __attribute__(x) /* */
#endif
#define FORCE_INLINE __attribute__((__always_inline__))

extern int pm_putchar(int, int);
extern int putchar(int);
extern size_t pm_write(const char *, size_t, int);
extern size_t write(const char *, size_t);
extern void pm_clear(int);
extern void clear(void);

extern volatile short *vid_mem;
extern int x;
extern int y;

static inline FORCE_INLINE int get_vid_pos(void)
{
	return (y * COLUMNS) + x;
}

static inline FORCE_INLINE int vga_color(int bg, int fg)
{
	return (bg << 12) | (fg << 8);
}

#endif
