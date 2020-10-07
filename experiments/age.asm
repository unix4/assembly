section .data
    msg db "What is your name?",0Ah,0Ah
section .bss
    sinput resb 6
section .text
    ; Step 1 Ausgabe von msg
    global main
main:
    ; output
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, 20
    syscall
    ; 
    ; input
    mov rax, 0
    mov rdi, 0
    mov rsi, sinput
    mov rdx, 6
    syscall
    ;
    
    ; output
    mov rax, sinput
    call sprintLF
    call _exit

slen:
    push    rbx
    mov     rbx, rax    
;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    rdx
    push    rcx
    push    rbx
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rcx, rax
    mov     rbx, 1
    mov     rax, 4
    int     80h
 
    pop     rbx
    pop     rcx
    pop     rdx
    ret    
    
sprintLF:
    call    sprint
 
    push    rax         ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     rax, 0Ah    ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    rax         ; push the linefeed onto the stack so we can get the address
    mov     rax, rsp    ; move the address of the current stack pointer into eax for sprint
    call    sprint      ; call our sprint function
    pop     rax         ; remove our linefeed character from the stack
    pop     rax         ; restore the original value of eax before our function was called
    ret                 ; return to our program
    
_exit:
    mov rax, 60 
    mov rdi, 0