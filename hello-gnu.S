.section .text
.global entry
entry:
        mov $1, %rax # write
        mov $1, %rdi # stdout
        mov $hello, %rsi # hello ptr
        mov $13, %rdx # length
        syscall

        mov %rdx, %rdi # exit with return of write
        mov $60, %rax # exit
        syscall

.section .data
hello:
        .ascii "Hello World!\n"
