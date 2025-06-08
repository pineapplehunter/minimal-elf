BITS 64
        org 0x08048000
ehdr:
        db 0x7f, "ELF", 2, 1, 1, 0
        times 8 db 0
        dw 2 ; e_type
        dw 0x3e ; e_machine
        dd 1 ; e_verison
        dq _start; entry
        dq phdr - $$;
        dq 0
        dd 0
        dw ehdrsize
        dw phdrsize
        dw 1
        dw 0
        dw 0
        dw 0
ehdrsize equ $ - ehdr

phdr:
        dd 1
        dd 5
        dq 0
        dq $$
        dq $$
        dq filesize
        dq filesize
        dq 0x1000
phdrsize equ $ - phdr

_start:
        mov rax, 1 ; write
        mov rdi, 1 ; stdout
        lea rsi, [hello] ; hello ptr
        mov rdx, hellolen ; length
        syscall

        mov rdi, rdx ; exit with return of write
        mov rax, 60 ; exit
        syscall

        hello: db "Hello World!", 0xA
        hellolen: EQU $-hello
filesize equ $ - $$
