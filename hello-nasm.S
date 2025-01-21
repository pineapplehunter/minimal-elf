section .text
global entry
entry:
        mov rax, 1 ; write
        mov rdi, 1 ; stdout
        lea rsi, [hello] ; hello ptr
        mov rdx, hellolen ; length
        syscall

        mov rdi, rdx ; exit with return of write
        mov rax, 60 ; exit
        syscall

section .data
        hello: db "Hello World!", 0xA
        hellolen: EQU $-hello
