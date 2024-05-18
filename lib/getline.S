// Function to read a single line of input from the console
//
// The address to write to is passed in x0, and this function leaves all other
// registers unchanged. It does not write the trailing newline, and instead
// null-terminates. Use it like this:
// ```
//  buf:
//      .skip 0x100
//  ...
//      ldr x0, =buf
//      bl getline
// ```

    .section ".text.getline", "ax"
    .global getline
    .type getline, %function
getline:

    // Save x0 and x1 since we'll be using them. Also save the link register
    // since we call functions.
    sub sp, sp, #32
    str lr, [sp, #8]
    stp x0, x1, [sp, #16]
    // Have x1 hold the next address to write
    mov x1, x0

    // Continuously read characters from the input. Remember, the return value
    // is in x0.
.Lloop_body:
    bl getchar
    // If it's a newline, break
    cmp w0, #'\n'
    b.eq .Lloop_done
    // Otherwise, write it into the buffer
    strb w0, [x1], #1
    b .Lloop_body

.Lloop_done:

    // Null-terminate
    strb wzr, [x1]

    // Restore and return
    ldr lr, [sp, #8]
    ldp x0, x1, [sp, #16]
    add sp, sp, #32
    ret
