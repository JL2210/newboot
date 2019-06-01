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

#include <stdint.h>
#define wchar_t int16_t
#define printf(string, ...) Print(L##string, __VA_ARGS__)
#define puts(string) Print(L##string "\n")

#include <efi.h>
#include <efilib.h>

EFI_STATUS EFIAPI efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable)
{
   InitializeLib(ImageHandle, SystemTable);
   puts("\t\tWelcome to the strange land of protected mode!\r");

   return EFI_SUCCESS;
}
