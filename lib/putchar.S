// Function to print a single character to the console
//
// It takes the character to print in x0, and it leaves all registers unchanged.
// Use it like this:
// ```
//      mov x0, #'A'
//      bl putchar
// ```

    .section ".text.putchar", "ax"
    .global putchar
    .type putchar, %function
putchar:

    // Save x0-x2 and x8 onto the stack, since we'll be using them
    stp x2, x8, [sp, #-16]!
    stp x0, x1, [sp, #-16]!

    // The syscall number is 64 (write)
    mov x8, #64
    // The file descriptor is 1 (stdout)
    mov x0, #1
    // The buffer is the address of the character to print, which we stored on
    // the top of the stack
    mov x1, sp
    // The buffer size is 1
    mov x2, #1

    // Do the syscall
    svc #0

    // Restore and return
    ldp x0, x1, [sp], #16
    ldp x2, x8, [sp], #16
    ret
