all: boot.lds dos.lds

boot.lds: ldscript-gen.sh
	./ldscript-gen.sh 0x7c00 > $@

dos.lds: ldscript-gen.sh
	./ldscript-gen.sh 0x0100 > $@

clean:
	rm -f boot.lds dos.lds
