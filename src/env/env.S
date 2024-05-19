// Env: Write a program that prints out all the environment variables at the
// time it was run.

    .section ".text", "ax"
    .global _start
_start:

    // Use a GPR instead of the stack pointer since the stack pointer has
    // alignment restrictions.
    add x19, sp, #16
    // Move by the number of command-line arguments we got, plus two slots for
    // the number of arguments and the null terminator. We did the add earlier.
    ldr x0, [sp]
    add x19, x19, x0, lsl #3

    // Keep printing environment variables until we hit a null pointer
.Lmain_loop:
    ldr x0, [x19], #8
    cbz x0, .Ldone
    bl putstr
    mov x0, #'\n'
    bl putchar
    b .Lmain_loop

.Ldone:
    bl exit
