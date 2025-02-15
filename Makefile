NASM      = nasm
QEMU      = qemu-system-x86_64
IMG_DIR   = build
IMG       = $(IMG_DIR)/disk.img
GCC       = i686-elf-gcc
LD        = i686-elf-ld
OBJCOPY   = i686-elf-objcopy

CFLAGS    = -m32 -ffreestanding -nostdlib -I./src/kernel
ASFLAGS   = -f elf

all: os

os: boot kernel image

boot:
	@echo "[Building Bootloader]"
	$(NASM) -f bin src/boot/boot.asm -o boot.bin

sys.o:
	@echo "[Assembling sys.asm]"
	$(NASM) $(ASFLAGS) src/kernel/sys.asm -o sys.o

console.o:
	@echo "[Compiling console.c]"
	$(GCC) $(CFLAGS) -c src/kernel/console.c -o console.o

kernel.elf: sys.o console.o link.ld
	@echo "[Linking Kernel]"
	$(LD) -T link.ld -o kernel.elf sys.o console.o

kernel: kernel.elf
	@echo "[Creating kernel.bin]"
	$(OBJCOPY) -O binary kernel.elf kernel.bin

image:
	@echo "[Creating Disk Image]"
	mkdir -p $(IMG_DIR)
	rm -f $(IMG)
	dd if=/dev/zero of=$(IMG) bs=512 count=2880 2>/dev/null
	dd if=boot.bin of=$(IMG) conv=notrunc 2>/dev/null
	dd if=kernel.bin of=$(IMG) bs=512 seek=1 conv=notrunc 2>/dev/null

run:
	@echo "[Running in QEMU]"
	$(QEMU) -drive format=raw,file=$(IMG) -m 256M -accel tcg

clean:
	@echo "[Cleaning Up]"
	rm -f boot.bin kernel.bin kernel.elf sys.o console.o
	rm -rf $(IMG_DIR)
