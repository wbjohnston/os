/* Linker script
 */
ENTRY(start)

SECTIONS {
    . = 1M; /* Set the load address to the first megabyte */

    .boot :
    {
        /* Put multiboot header at beginning of binary */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }
}
