// Write a program that puts 50 into a register, and prints whether it is zero.

    // The task says to load the value 50 from memory, so we'll put it here.
    .section ".rodata.memdemo.val", "a"
    .align 3
.Lval:
    .dword 50

    // We also need strings for whether 50 is or is not zero
    .section ".rodata.memdemo.strs", "a"
.Lstr_z:
    .string "Math is broken\n"
.Lstr_nz:
    .string "We're good\n"

    .section ".text", "ax"
    .global _start
_start:

    // Load the address of the value, then load the actual value
    ldr x0, =.Lval
    ldr x0, [x0]

    // Select which string to print based on whether x0 is zero
    ldr x1, =.Lstr_z
    ldr x2, =.Lstr_nz
    cmp x0, #0
    csel x0, x1, x2, eq

    // Print out, then we're done
    bl putstr
    bl exit
