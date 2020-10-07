section .data
    msg db "Hallo, ich bin ein mega guter Programmierer!",0
section .text
    global main
    global _output
main:
    mov rbp, rsp; for correct debugging
    mov rax, msg
    mov rbx, rax
_do:
    cmp byte[rax], 0
    jz _length
    inc rax
    jmp _do
_length:
    sub rax, rbx
    mov rdx, rax
_output: 
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    ;mov rdx, 5
    syscall
    jmp _finished
_finished:
    mov rdi, 0
    mov rax, 60 
    syscall

    