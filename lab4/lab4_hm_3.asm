;x+(2-a*b)/(a*3)-a+c; 
;a-byte; b-word; c-doubleword; x-qword

bits 32
global start

extern exit

import exit msvcrt.dll

segment data use32 class=data

a db 4
b dw -20
c dd 3
x dq -10

segment code use32 class=code
start:
    mov al,3
    imul byte [a]; ax=3*a*
    mov bx,ax; bx=3*a we need eax for computing 2-a*b
    
    
    mov al, [a]; al=a
    cbw ; signed conversion from al to ax
    
    imul word [b]; dx:ax=a*b
    
    push dx
    push ax
    pop ecx; ecx=a*b, we want to compute here 2-a*b
    
    sbb ecx,2; ecx=a*b-2
    neg ecx;ecx=2-a*b
    clc;when negating carry flag is set to 1, we make it 0 again
    
    ;we want to put the result back into dx:ax
    push ecx
    pop ax
    pop dx
    
   
    
    idiv word bx;ax=ax/bx dx=ax%cx
    
    
    
    
    
    
    
    
    