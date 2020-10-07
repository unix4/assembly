section .data
    msg db "Hello World"
section .text
    global main
main:
    mov rdx, 11 ; number of bytes to write - one for each letter plus 0Ah (line feed character)
    mov rcx, msg ; move the memory address of our message string into ecx
    mov rbx, 1 ; write to the STDOUT file
    mov rax, 4 ; invoke SYS_WRITE (kernel opcode 4)
    syscall
    mov eax, 1
    mov ebx, 0
    syscall
    