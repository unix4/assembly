section .data
    msg db "Hallo, Welt ich komme gleich",0
section .text
    global main
main:
    mov rax, 4
    mov rdi, 1
    mov rsi,msg
    mov rdx,15
    syscall ; sys_write
    
    mov rax,1
    mov rbx,0
    syscall ; sys_exit
    
    