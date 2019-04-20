all: build.sh boot.S stage2.S
	@$(MAKE) -C ldscripts all
	@./build.sh

clean: clean.sh
	@$(MAKE) -C ldscripts clean
	@./clean.sh
