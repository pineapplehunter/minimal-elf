section .text
global _start
_start:
        mov rax, 1 ; write
        mov rdi, 1 ; stdout
        lea rsi, [rel hello] ; hello ptr
        mov rdx, hellolen ; length
        syscall

        mov rdi, rdx ; exit with return of write
        mov rax, 60 ; exit
        syscall

section .rodata
        hello: db "Hello World!", 0xA, 0
        hellolen: EQU $-hello - 1
