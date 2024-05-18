// Exit the program
//
// In laymans terms, we have to tell the computer to stop fetching instructions
// after a point. This function does that. Use it like this:
// ```
//      bl exit
// ```

    .section ".text.exit", "ax"
    .global exit
    .type exit, %function
exit:

    // We don't have to care about saving and restoring registers, since the
    // program is about to die.

    // The syscall number is 93 (exit)
    mov x8, #93
    // The exit status is 0
    mov x0, #0

    // Do the syscall
    svc #0

    // If we somehow get back here, try to exit again
    b exit
