// Guessing Game: Pick a number, and have the user tell you whether the number
// they’re thinking of is higher or lower. Try to guess the user’s number in as
// few turns as possible.

    .section ".rodata", "a"
.Lstr_intro:
    .string "Think of a number in [0, 128). I will try to guess it.\n"
.Lstr_my_guess:
    .string "I guess: "
.Lstr_prompt:
    .string "Is your number higher, lower, or equal? (h/l/e) "
.Lstr_win:
    .string "I win!\n"
.Lstr_lose:
    .string "... Wait what?\n"

    .section ".data", "aw"
.Lbuf:
    .skip 32

    .section ".text", "ax"
    .global _start
_start:

    // Print out the instructions first
    ldr x0, =.Lstr_intro
    bl putstr

    // Initialize our variables:
    //  * x19: lower bound (inclusive)
    //  * x20: upper bound (inclusive)
    mov x19, #0
    mov x20, #128
    sub x20, x20, #1

.Lmain_loop:

    // Check to see if the lower bound is strictly greater than the upper bound.
    // If it is, we have lost. Make sure to do signed comparisons just in case
    // we get a negative index.
    cmp x19, x20
    b.gt .Llose

    // Compute the midpoint and store it in x21
    add x21, x19, x20
    asr x21, x21, #1
    // Guess the midpoint
    ldr x0, =.Lstr_my_guess
    bl putstr
    mov x0, x21
    bl putnum
    mov x0, #'\n'
    bl putchar

.Lprompt:
    // Prompt the user
    ldr x0, =.Lstr_prompt
    bl putstr
    // Get the response
    ldr x0, =.Lbuf
    bl getline

    // Check the first character, and convert it to lowercase
    ldrb w0, [x0]
    orr w0, w0, #0x20

    // If equal, we're done
    cmp w0, #'e'
    b.eq .Lwin
    // Check for higher and lower. If the user doesn't give us a valid response,
    // just prompt again.
    cmp w0, #'h'
    b.eq .Lhigher
    cmp w0, #'l'
    b.ne .Lprompt

.Llower:
    // Adjust the upper bound to be one less than the midpoint
    sub x20, x21, #1
    b .Lmain_loop

.Lhigher:
    // Adjust the lower bound to be one more than the midpoint
    add x19, x21, #1
    b .Lmain_loop

    // What to do when we win
.Lwin:
    ldr x0, =.Lstr_win
    bl putstr
    bl exit

    // What to do when we lose
.Llose:
    ldr x0, =.Lstr_lose
    bl putstr
    bl exit
