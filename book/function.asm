; function.asm
extern printf
section .data
    radius  dq 10.0 ; 64 bits
    pi dq 3.14 ; 64 bits
    fmt db "The area of the circle is %.2f", 10, 0  ; 8 bits
section .bss
section .text
    global main
;----------------------------------------
main:
    push rbp
    mov rbp, rsp
    call area ; call the function 
    mov rdi, fmt ; print format
    movsd xmm1, [radius] ; move float to xmm1
    mov rax, 1
    call printf
leave
ret
;-----------------------------------------
area:
push rbp
mov rbp, rsp
    movsd xmm0, [radius] ; move float to xmm0
    mulsd xmm0,  [radius]; multiply xmm0 by float
    mulsd xmm0, [pi] ; multiply xmm0 by float
leave
ret