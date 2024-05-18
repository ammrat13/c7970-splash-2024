// Function to print a number to the console
//
// It takes the number to print in x0, and it leaves all registers unchanged.
// This function does *not* print a newline - you have to do that. It interprets
// `x0` as an unsigned number, and it prints in decimal. Use it like this:
// ```
//      mov x0, #25
//      bl putnum
// ```

    .section ".text.putnum", "ax"
    .global putnum
    .type putnum, %function
putnum:

    // Save x0-x2 and x8 onto the stack, since we'll be using them. We also need
    // to allocate space on the stack for the buffer. It'll use at most 20
    // characters, but we'll bump it up to 32 for alignment and for safety.
    sub sp, sp, #64
    stp x0, x1, [sp, #32]
    stp x2, x8, [sp, #48]

    // Initialize x1 to the end of the buffer. It will wind up holding the start
    // of the buffer, and then we can use sp to calculate the length.
    add x1, sp, #32

    // If the number is zero, just write a single zero into the buffer
    cbnz x0, .Lloop_start
    mov x8, #'0'
    strb w8, [x1, #-1]!
    b .Lbufdone

    // Keep iterating until the number is zero
.Lloop_start:
    mov x8, #10
.Lloop_body:
    cbz x0, .Lbufdone
    // Divide the number by 10, and get the remainder
    mov x2, x0
    udiv x0, x0, x8
    msub x2, x0, x8, x2
    // Convert the remainder to a character and write it to the buffer
    add x2, x2, #'0'
    strb w2, [x1, #-1]!
    // Repeat the loop
    b .Lloop_body

    // At this point, the buffer has been populated
.Lbufdone:

    // The syscall number is 64 (write)
    mov x8, #64
    // The file descriptor is 1 (stdout)
    mov x0, #1
    // The buffer is already in x1
    // Calculate the length of the string and put it in x2
    add x2, sp, #32
    sub x2, x2, x1

    // Do the syscall
    svc #0

    // Restore and return
    ldp x0, x1, [sp, #32]
    ldp x2, x8, [sp, #48]
    add sp, sp, #64
    ret
