# QEMU path
QEMU = qemu-system-riscv32

# Compiler
CC = clang

# Compiler flags
CFLAGS = -std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib

# Linker script
LDSCRIPT = kernel.ld

# Output file
OUTPUT = kernel.elf

# Map file
MAPFILE = kernel.map

# Source files
SRCS = kernel.c

# Default target
all: kernel run

# Rule to build the kernel
kernel: $(SRCS) $(LDSCRIPT)
	$(CC) $(CFLAGS) -Wl,-T$(LDSCRIPT) -Wl,-Map=$(MAPFILE) -o $(OUTPUT) $(SRCS)

# Rule to run QEMU
run: kernel
	$(QEMU) -machine virt -bios default -nographic -serial mon:stdio --no-reboot -kernel $(OUTPUT)

# Clean up generated files
clean:
	rm -f $(OUTPUT) $(MAPFILE)

.PHONY: all clean
