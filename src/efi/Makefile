ARCH = $(shell gcc -dumpmachine | cut -d- -f1)
BUILD = $(shell echo $(ARCH) | sed s,i[3456789]86,ia32,)

PREFIX = /usr/local/prefix32/usr
OBJS = newboot.o
SO_TARGET = newboot.so
TARGET = newboot.efi

EFIINC = $(PREFIX)/include/efi
EFIINCS = -I$(EFIINC) -I$(EFIINC)/$(BUILD) -I$(EFIINC)/protocol
LIB = $(PREFIX)/lib
EFILIB = $(LIB)

EFI_CRT_OBJS = $(EFILIB)/crt0-efi-$(BUILD).o
EFI_LDS = $(EFILIB)/elf_$(BUILD)_efi.lds

CFLAGS = $(EFIINCS) -fno-stack-protector -fpic \
		-fshort-wchar -mno-red-zone -Wall
ifeq ($(BUILD),x86_64)
 CFLAGS += -DEFI_FUNCTION_WRAPPER
endif

LDFLAGS	 = -nostdlib -znocombreloc -T $(EFI_LDS) -shared \
		-Bsymbolic -L $(EFILIB) -L $(LIB) $(EFI_CRT_OBJS)

all: $(TARGET)

$(SO_TARGET): $(OBJS)
	ld $(LDFLAGS) $(OBJS) -o $@ -lefi -lgnuefi

%.efi: %.so
	objcopy -j .text -j .sdata -j .data -j .dynamic \
		-j .dynsym  -j .rel -j .rela -j .reloc \
		--target=efi-app-$(BUILD) $^ $@

clean:
	rm -f *.o *.so *.efi
