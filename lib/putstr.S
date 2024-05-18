// Function to write a (null-terminated) string to the console
//
// It takes the address of the first character in the string in x0, and it
// leaves all registers unchanged. Use it like this:
// ```
//  string:
//      .asciz "Hello, world!\n"
//  ...
//      ldr x0, =string
//      bl  putstr
// ```

    .section ".text.putstr", "ax"
    .global putstr
    .type putstr, %function
putstr:

    // Save x0-x2 and x8 onto the stack, since we'll be using them
    stp x2, x8, [sp, #-16]!
    stp x0, x1, [sp, #-16]!

    // We need to figure out the length of the string to write since `write`
    // expects a length. We should put the result in x2. We'll actually have x2
    // be the address of the next character to read, and we'll subtract x0 from
    // it at the very end.
    mov x2, x0
.Llen_loop:
    ldrb w8, [x2], #1
    cbnz w8, .Llen_loop
.Llen_done:
    sub x2, x2, x0
    sub x2, x2, #1

    // The syscall number is 64 (write)
    mov x8, #64
    // The buffer is the address of the string, which is provided in x0
    mov x1, x0
    // The file descriptor is 1 (stdout)
    mov x0, #1
    // The buffer size is the length of the string, which is already in x2

    // Do the syscall
    svc #0

    // Restore and return
    ldp x0, x1, [sp], #16
    ldp x2, x8, [sp], #16
    ret
