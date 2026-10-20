section .data
    ; Структура sockaddr_in для 127.0.0.1:8080
    sock_addr:
        dw 2
        dw 0x901F
        dd 0x0100007F
        dq 0
    sock_addr_len equ $ - sock_addr

    msg db "Hello from clean NASM assembly code!", 10
    msg_len equ $ - msg

section .text
    global _start

_start:
    ; sys_socket
    mov rax, 41
    mov rdi, 2
    mov rsi, 1
    mov rdx, 0
    syscall

    ; Сохраняем дескриптор сокета
    mov r12, rax

    ; sys_connect
    mov rax, 42
    mov rdi, r12
    mov rsi, sock_addr
    mov rdx, sock_addr_len
    syscall

    ; sys_write
    mov rax, 1
    mov rdi, r12
    mov rsi, msg
    mov rdx, msg_len
    syscall

    ; sys_exit
    mov rax, 60
    xor rdi, rdi
    syscall