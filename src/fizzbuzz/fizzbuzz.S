// FizzBuzz: Print out the numbers 1 to 100. But: if a number is a multiple of
// three, print "Fizz" instead; if a number is a multiple of five, print "Buzz"
// instead. If it's both, print "FizzBuzz".

    .section ".rodata", "a"
.Lfizz:
    .string "Fizz\n"
.Lbuzz:
    .string "Buzz\n"
.Lfizzbuzz:
    .string "FizzBuzz\n"

    .section ".text", "ax"
    .global _start
_start:

    // Initialize the counter in x19, and the upper bound in x20. The counter
    // starts at one less since we'll increment later
    mov x19, #0
    mov x20, #101

    // These constants need to be in registers since we'll be dividing by them
    mov x27, #3
    mov x28, #5

.Lmain_loop:
    // Increment. This is why we start at zero and not one.
    add x19, x19, #1

    // While x19 < x20. In other words, break if x19 >= x20, or x20 <= x19.
    cmp x20, x19
    b.ls .Ldone

    // Compute x19 % 3 and put the result in x21
    udiv x21, x19, x27
    msub x21, x21, x27, x19
    // Same for % 5 into x22
    udiv x22, x19, x28
    msub x22, x22, x28, x19
    // Put their bitwise or into x23. This will be 0 if x19 is divisible by 15.
    orr x23, x21, x22

.Lcheck_fizzbuzz:
    // If x23 is zero, print FizzBuzz
    cbnz x23, .Lcheck_fizz
    ldr x0, =.Lfizzbuzz
    bl putstr
    b .Lmain_loop

.Lcheck_fizz:
    cbnz x21, .Lcheck_buzz
    ldr x0, =.Lfizz
    bl putstr
    b .Lmain_loop

.Lcheck_buzz:
    cbnz x22, .Lnormal
    ldr x0, =.Lbuzz
    bl putstr
    b .Lmain_loop

.Lnormal:
    // Just print the number, followed by a newline
    mov x0, x19
    bl putnum
    mov x0, #'\n'
    bl putchar
    b .Lmain_loop

.Ldone:
    bl exit
