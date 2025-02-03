#!/bin/bash
set -xue

# QEMU path
QEMU=qemu-system-riscv32

CC=clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32 -ffreestanding -nostdlib"

# Build kernel

$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    kernel.c

# Run QEMU:
# 1. -machine virt: run `virt` machine
# 2. -bios default: use default firmware (OpenSBI)
# 3. -nographic: run QEMU without GUI
# 4. -serial mon:stdio: Connect standart QEMU input/output to VM's serial port
# 5. --no-reboot: Stop emulator without reboot
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf
