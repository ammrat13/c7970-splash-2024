// Write a program that prints "y" forever.

    // Place the string we want to print in a separate section. We will load the
    // address of this string into a register, then print it.
    .section ".rodata", "a"
.Lstr:
    .string "y\n"

    // This is the entrypoint of the code. The computer will start fetching
    // instructions from here.
    .section ".text", "ax"
    .global _start
_start:

    // Load the address of the string into register x0. The `putstr` function
    // expects the address of the string to be there.
    ldr x0, =.Lstr
    // Call `putstr` to do the printing
    bl putstr
    // Do it again and again forever
    b _start
