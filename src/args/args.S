// Write a program that prints out all the command-line arguments given to it.

    .section ".text", "ax"
    .global _start
_start:

    // Use a GPR instead of the stack pointer since the stack pointer has
    // alignment restrictions. Also, skip the number of command-line arguments.
    // We don't need it since the list of pointers is null-terminated.
    add x19, sp, #8

    // Keep printing arguments until we hit a null pointer
.Lmain_loop:
    ldr x0, [x19], #8
    cbz x0, .Ldone
    bl putstr
    mov x0, #'\n'
    bl putchar
    b .Lmain_loop

.Ldone:
    bl exit
