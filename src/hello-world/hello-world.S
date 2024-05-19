// Hello World: No explanation needed.

    // Put the string somewhere
    .section ".rodata", "a"
.Lstr:
    .string "Hello world!\n"

    .section ".text", "ax"
    .global _start
_start:
    // Load the address of the string to print, print it, then exit
    ldr x0, =.Lstr
    bl putstr
    bl exit
