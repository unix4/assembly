section .data
    msg1 db "Please enter your name: ", 0h ; message string asking user for input
    msg2 db "Hello, ", 0h ; message string to use after user has entered their name
    
section .bss
    sinput: resb 255  ; reserver a 255 space in memor yfor the users input string
    
section .text
    global main
    
main:
    mov rbp, rsp; for correct debugging
    mov rax, msg1
    call sprint
    
   ; mov rdx, 255 ; number of bytes to read
   ; mov rcx, sinput ; reserved space to store our input (known as a buffer)
   ; mov rbx, 0 ; write to the STDIN file
   ; mov rax, 3 ; invoke SYS_READ (kernel opcode 3)
   ; int 80h
    
    mov rax, 0 ; id for sys_read
    mov rdi, 0 ; file descriptor = 0 (stdin)
    mov rsi, sinput
    mov rdx, 255
    syscall
    
    mov rax, msg2
    call sprint
    
    mov rax, sinput ; move our buffer into rax (Note: input contains a linefeed)
    call sprint ; call our print function
    
    call quit
    
;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    rbx
    mov     rbx, rax
 
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rbx
    pop     rbx
    ret
 
 
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
 
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
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
 
 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     rbx, 0
    mov     rax, 1
    int     80h
    ret