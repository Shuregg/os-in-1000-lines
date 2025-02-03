typedef unsigned char uint8_t;
typedef unsigned int uint32_t;
typedef uint32_t size_t;

extern char __bss[], __bss_end[], __stack_top[];

// __bss[] - Beginning address of .bss section  
// __bss - Value of null byte of .bss section

void *memset(void *buf, char c, size_t n) {
    uint8_t *p = (uint8_t *) buf;

    while(n--) {
        *p++ = c;
    }

    return buf;
}

// Init .bss section
void kernel_main(void) {
    memset(__bss, 0, (size_t) __bss_end - (size_t) __bss);

    for(;;);
}

// boot - Kernel entry point
__attribute__((section(".text.boot")))  // Place boot function on base address (0x80200000)
__attribute__((naked))  // Compiler will not generate unnecessary code before and after function's body (return function)
void boot(void) {
    __asm__ __volatile__(
        "mv sp, %[stack_top]\n"         // Set stack pointer
        "j kernel_main\n"               // Jump to kernel_main function
        :
        : [stack_top] "r" (__stack_top) // Pass an top stack address (using %[stack_top])
    );
}