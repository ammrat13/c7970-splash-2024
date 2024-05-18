// Write a program that reads two numbers from the user, adds them together, and
// prints the result.

    // Have all the strings we will print for the user
    .section ".rodata"
.Lfirst_number:
    .string "Enter the first number: "
.Lsecond_number:
    .string "Enter the second number: "
.Lresult:
    .string "The result is: "

    .section ".text", "ax"
    .global _start
_start:

    // Get the first number
    ldr x0, =.Lfirst_number
    bl putstr
    bl getnum
    mov x1, x0

    // Get the second number
    ldr x0, =.Lsecond_number
    bl putstr
    bl getnum
    mov x2, x0

    // Add the two numbers
    add x3, x1, x2

    // Print the result
    ldr x0, =.Lresult
    bl putstr
    mov x0, x3
    bl putnum
    // Don't forget the newline
    mov x0, #'\n'
    bl putchar

    // Done
    bl exit
