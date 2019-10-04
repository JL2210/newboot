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

#include <newboot.h>

int color_putchar(int c, int color)
{
	c &= 0x7f;

	switch(c)
	{
	case '\n':
		x = 0;
		y++;
		break;
	case '\v':
		y++;
		break;
	case '\r':
		x = 0;
		break;
	case '\t':
		x += 8 - (x % 8);
		break;
	case '\b':
		x--;
		vid_mem[get_vid_pos()] = 0;
		break;
	default:
		vid_mem[get_vid_pos()] = (short)(c | color);
		x++;
		break;
	}
	return c;
}

int putchar(int c)
{
	return color_putchar(c, COLOR);
}
