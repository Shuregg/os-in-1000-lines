
/* Kernel entry point is boot func */
ENTRY(boot)

SECTIONS {
    /* Base address */
    . = 0x80200000;

    /* Program code */
    .text :{
        /* Sections text and boot are kept at the beginning   */
        KEEP(*(.text.boot));
        *(.text .text.*)
    }

    /* Constants (read only data) */
    .rodata : ALIGN(4) {
        *(.rodata .rodata.*);
    }

    /* RW data */
    .data : ALIGN(4) {
        *(.data .data.*);

    }

    /* Uninitialized data */
    .bss : ALIGN(4) {
        __bss = .;
        *(.bss .bss.* .sbss .sbss.*);
        __bss_end = .;
    }

    . = ALIGN(4);
    . += 128 * 1024; /* Stack size: 128 KiB */
    __stack_top = .;
}