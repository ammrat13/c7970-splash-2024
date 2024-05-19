// Fibonacci: Compute the 10-th fibonacci number recursively.

    .section ".text", "ax"
    .global _start
_start:
    mov x0, #10
    bl fibonacci
    bl putnum
    mov x0, #'\n'
    bl putchar
    bl exit

    .global fibonacci
    .type fibonacci, %function
fibonacci:

    // Check for the base cases
    cmp x0, #1
    b.hi .Lrecurse
    ret

.Lrecurse:
    // Allocate space on the stack for the link register, n, and F(n-1)
    sub sp, sp, #32
    stp x0, lr, [sp, #16]

    // Compute F(n-1) and save it
    sub x0, x0, #1
    bl fibonacci
    str x0, [sp]
    ldr x0, [sp, #16]

    // Compute F(n-2)
    sub x0, x0, #2
    bl fibonacci
    // Add the saved F(n-1) to F(n-2)
    ldr x1, [sp]
    add x0, x0, x1
    // Restore lr and return
    ldr lr, [sp, #24]
    add sp, sp, #32
    ret
