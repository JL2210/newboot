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

int pm_putchar(int c, int color)
{
	c &= 0x7f;

	if(c == '\n' || c == '\v')
	{
		y++;
		goto ret;
	}
	else if(c == '\r')
	{
		x = 0;
		goto ret;
	}
	else if(c == '\t')
	{
		x += 8 - (x % 8);
		goto ret;
	}
	else if(c == '\b')
	{
		x--;
		vid_mem[get_vid_pos()] = 0;
		goto ret;
	}

	vid_mem[get_vid_pos()] = (short)(c | color);
	x++;
ret:	return c;
}

int putchar(int c)
{
	return pm_putchar(c, COLOR);
}
