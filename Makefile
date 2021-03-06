# OS Makefile

arch ?= x86_64
kernel := build/kernel-$(arch).bin
iso := build/os-$(arch).iso

# Resources
linker_script := src/arch/$(arch)/linker.ld
grub_cfg := src/arch/$(arch)/grub.cfg
asm_srcs := $(wildcard src/arch/$(arch)/*.asm)
asm_objs := $(patsubst src/arch/$(arch)/%.asm, \
	build/arch/$(arch)/%.o, \
	$(asm_srcs))

.PHONY: all clean run iso

all: $(kernel)

clean:
	rm -r build

run: $(iso)
	qemu-system-$(arch) -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	mkdir -p build/isofiles/boot/grub
	cp $(kernel) build/isofiles/boot/kernel.bin
	cp $(grub_cfg) build/isofiles/boot/grub
	grub-mkrescue -o $(iso) build/isofiles
	rm -r build/isofiles

$(kernel): $(asm_objs) $(linker_script)
	ld -n -T $(linker_script) -o $(kernel) $(asm_objs)

build/arch/$(arch)/%.o: src/arch/$(arch)/%.asm
	mkdir -p $(shell dirname $@)
	nasm -felf64 $< -o $@
