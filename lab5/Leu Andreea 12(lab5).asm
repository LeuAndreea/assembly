;Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found 
;on even positions in S2 and the elements found on odd positions in S1


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
    
    mov ESI,0; using ESI to loop through odd elements of s1
    ;(hence starting at 0, which is the first)
    mov EDI,0; used for inserting in our result string
    
    ;--ax will be used to store the  character we need
    ;--we get the first odd character, if is 0 we don't enter the loop
    mov ax,0
    mov al, [s1+ESI];moving the current element in ax register   
    cmp ax,24h
    jz endrepeat;
    
    repeat:
        
       
        mov [res+EDI],al
        add EDI,1
        
        ;we must not only check if  next odd character exists,
        ;but if the next one exists, either way in the case we
        ;are at the second last character ESI will point to the
        ;next variable form memory zone
        mov al, [s1+ESI+1]
        cmp ax,0
        jz endrepeat
        
        add ESI,2
        mov al, [s1+ESI];the next odd character will be ready
        ;in al if we jump to repeat
        cmp ax,0
        jz endrepeat
        
        jmp repeat
    endrepeat:
        
 
    mov ESI,1; using ESI to loop through even elements of s2
    ;(hence starting at 1, which is the second)
    ;EDI will remain unchanged, we want to pick up where we left
    
    ;--ax will be used to store the  character we need
    ;--we get the first even character, if is 0 we don't enter the loop
    mov ax,0
    mov al, [s2+ESI];moving the current element in ax register   
    cmp ax,0
    jz endrepeat2
    
    
    ;this loop works similarly to the first one
    repeat2:
        
        ;push dword format2
        ;call [scanf]
        ;add ESP,4
        
        mov [res+EDI],al
        add EDI,1
        
        ;we must not only check if  next odd character exists,
        ;but if the next one exists, either way in the case we
        ;are at the second last character ESI will point to the
        ;next variable form memory zone
        mov al, [s2+ESI+1]
        cmp ax,0
        jz endrepeat2
        
        add ESI,2
        mov al, [s2+ESI];the next odd character will be ready
        ;in al if we jump to repeat
        cmp ax,0
        jz endrepeat2
        
        jmp repeat2
    endrepeat2:
    
    
    
    
    
  
    
    push dword res
    push dword format
    call [printf]
    add ESP, 4*2
    
    push dword 0
    call [exit]
    
    
    


