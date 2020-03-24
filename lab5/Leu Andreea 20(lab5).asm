;Two byte strings A and B are given. Obtain the string R by ;concatenating the elements of B in reverse order and the even ;elements of A.

bits 32
global start
extern exit,printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
s1 times 20 db 0
s2 times 20 db 0
res times 20 db 0
format db '%s',0

segment use32 class=code
start:
    ;reading first string
    push dword s1
    push dword format
    call [scanf]
    add ESP,4*2
    
    ;reading second string
    push dword s2
    push dword format
    call [scanf]
    add ESP,4*2
    
    mov ESI,-1; using ESI to loop through odd elements of s1
    ;(starting at -1 because we will increment it at the start ;of the loop)
    mov EDI,0; used for inserting in our result string
    
    ;--ax will be used to store single character
    mov ax,0
    
    ;--getting to the last position of s1 in order to
    ;be able to get the elements in reverse order
    repeat1:
        inc ESI
        mov al,[s1+ESI]
        cmp al, 0
        jnz repeat1
    ;we need to copy elements from ESI-1 -> 0,hence 
    ;we will use the loop instruction
    
    mov ecx,esi
    
    ;we put in res the elements of s1 in reverse order
    repeat2:
        mov al,[s1+ECX-1]
        mov [res+EDI],al
        inc EDI
    loop repeat2
    
    mov ESI,1; we reinitialize it to parse the even elements of s2
    ;hence starting from index 1, the second element
    
    ;--we get the first even character, if is 0 we don't enter the loop
    mov ax,0
    mov al, [s2+ESI];moving the current element in ax register   
    cmp ax,0
    jz endrepeat3
    
    repeat3:
        
        mov [res+EDI],al
        add EDI,1
        
        ;we must not only check if  next odd character exists,
        ;but if the next one exists, either way in the case we
        ;are at the second last character ESI will point to the
        ;next variable form memory zone
        mov al, [s2+ESI+1]
        cmp ax,0
        jz endrepeat3
        
        add ESI,2
        mov al, [s2+ESI];the next odd character will be ready
        ;in al if we jump to repeat
        cmp ax,0
        jz endrepeat3
        
        jmp repeat3
    endrepeat3:
    
    
    push dword res
    push dword format
    call [printf]
    add ESP, 4*2
    
    push dword 0
    call [exit]
    
    
        
        
        