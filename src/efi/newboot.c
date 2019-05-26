#include <stdint.h>
#define wchar_t int16_t
#define printf(string, ...) Print(L##string, __VA_ARGS__)
#define puts(string) Print(L##string "\n")

#include <efi.h>
#include <efilib.h>

EFI_STATUS
EFIAPI
efi_main (EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) {
   InitializeLib(ImageHandle, SystemTable);
   puts("\t\tWelcome to the strange land of protected mode!\r");

   return EFI_SUCCESS;
}
