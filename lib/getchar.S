// Function to read a single character from the console
//
// It returns the character in x0, and leaves all other registers unchanged. Use
// it like this:
// ```
//      bl getchar
// ```

    .section ".text.getchar", "ax"
    .global getchar
    .type getchar, %function
getchar:

    // Save x1, x2, and x8 on the stack since we'll be using them. We'll also be
    // using x0, but that's where the result goes, so we don't have to worry
    // about saving and restoring it. We also allocate space for the buffer,
    // which is just another eight bytes on top of the 24 we're already using.
    sub sp, sp, #32
    str x1, [sp, #8]
    stp x2, x8, [sp, #16]

    // The syscall number is 63 (read)
    mov x8, #63
    // The file descriptor is 0 (stdin)
    mov x0, #0
    // The buffer is just the top of the stack
    mov x1, sp
    // The buffer size is 1
    mov x2, #1

    // Do the syscall
    svc #0
    // Load the result into x0
    ldrb w0, [sp]

    // Restore and return
    ldr x1, [sp, #8]
    ldp x2, x8, [sp, #16]
    add sp, sp, #32
    ret
