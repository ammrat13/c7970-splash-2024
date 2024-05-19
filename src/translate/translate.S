// Translate the code from three slides ago into assembly.

    .section ".rodata", "a"
.Lstart:
    .string "In _start()\n"
.Lf1a:
    .string "In f1a()\n"
.Lf1b:
    .string "In f1b()\n"
.Lf2a:
    .string "In f2a()\n"
.Lf2b:
    .string "In f2b()\n"

    .section ".text", "ax"

    .global _start
_start:
    ldr x0, =.Lstart
    bl putstr
    bl f1a
    bl f1b
    bl exit

    .global f1a
    .type f1a, %function
f1a:
    stp x0, lr, [sp, #-16]!
    ldr x0, =.Lf1a
    bl putstr
    bl f2a
    bl f2b
    ldp x0, lr, [sp], #16
    ret

    .global f1b
    .type f1b, %function
f1b:
    stp x0, lr, [sp, #-16]!
    ldr x0, =.Lf1b
    bl putstr
    bl f2b
    bl f2a
    ldp x0, lr, [sp], #16
    ret

    .global f2a
    .type f2a, %function
f2a:
    stp x0, lr, [sp, #-16]!
    ldr x0, =.Lf2a
    bl putstr
    ldp x0, lr, [sp], #16
    ret

    .global f2b
    .type f2b, %function
f2b:
    stp x0, lr, [sp, #-16]!
    ldr x0, =.Lf2b
    bl putstr
    ldp x0, lr, [sp], #16
    ret
