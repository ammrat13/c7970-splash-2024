// Factorial: Compute 10! recursively.

    .section ".text", "ax"
    .global _start
_start:
    mov x0, #10
    bl factorial
    bl putnum
    mov x0, #'\n'
    bl putchar
    bl exit

    .global factorial
    .type factorial, %function
factorial:

    // Check for the base case
    cbnz x0, .Lrecurse
    mov x0, #1
    ret

.Lrecurse:
    // Save the old value so it doesn't get clobbered
    stp x0, lr, [sp, #-16]!
    // Recurse
    sub x0, x0, #1
    bl factorial
    // Do the multiply and return. It's fine that we clobber x1 since we don't
    // have it live across subroutine calls.
    ldp x1, lr, [sp], #16
    mul x0, x0, x1
    ret
