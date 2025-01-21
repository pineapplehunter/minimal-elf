.section .text
.global entry
entry:
        li a7, 64 # write
        li a0, 1 # stdout
        la a1, hello # hello ptr
        li a2, 13 # length
        ecall

        li a7, 93 # exit using the result of a0 as arg
        ecall

.section .data
hello:
        .ascii "Hello World!\n"
