// Function to read a number from a line of input in the console
//
// This function returns the number read in x0, and leaves all other registers
// unchanged. Use it like this:
// ```
//      bl getnum
// ```

    .section ".text.getnum", "ax"
    .global getnum
    .type getnum, %function
getnum:

    // Save x1, x2, and x3 since we will use them. We'll also use x0, but that
    // stores the return value, so we don't have to save and restore it. We have
    // to save lr as well since we call functions. Also allocate space for the
    // buffer. We need space for 20 characters, plus a null, so we'll round up
    // to 32.
    //
    // Note that this is a massive security risk since we don't check for buffer
    // overflow. Oh well.
    sub sp, sp, #64
    stp lr, x1, [sp, #32]
    stp x2, x3, [sp, #48]

    // Read the line into the buffer on the stack
    mov x0, sp
    bl getline

    // Accumulate into x0, with x2 as our index
    mov x0, #0
    mov x2, sp
    mov x3, #10
.Lloop_body:
    // Read the current character. Break out if it's a null.
    ldrb w1, [x2], #1
    cbz w1, .Lloop_done
    // Otherwise, multiply x0 by 10 and add the digit. Remember to correct for
    // the shift.
    sub w1, w1, #'0'
    madd x0, x0, x3, x1
    b .Lloop_body
.Lloop_done:

    // Restore and return
    ldp lr, x1, [sp, #32]
    ldp x2, x3, [sp, #48]
    add sp, sp, #64
    ret
