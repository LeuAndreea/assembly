;Given an array A of doublewords, build two arrays of bytes:  
; - array B1 contains as elements the lower part of the lower words from A
; - array B2 contains as elements the higher part of the higher words from A

bits 32
global start
extern exit,printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
A times 20 dd 0,0,0,0
len dd 0
B1 times 20 db 0
B2 times 20 db 0
format db '%x',0
texttoprint db 'Introduce double words. Push 0 to stop',0
doubleNumber dd 0h,0
texthelp db 'exited the loop ? why tf'
segment use32 class=code
start:
    push dword texttoprint
    call [printf]
    add ESP,4*2
    
    mov ESI, 0;we will use it to put values in A 
    ;we will read the array of quads here
    
    mov ebx,0;we will compute the length of the string of doublewords here
    readloop:
        push dword doubleNumber
        push dword format
        call [scanf]
        add ESP, 4 *2
        
        
        ;push dword [readNumber]
        ;push dword format
        ;call [printf]
        ;add ESP, 4 *2
        
     
        cmp [doubleNumber],dword 0
        jz endreadloop
        
        mov eax,[doubleNumber]
        mov [A+ESI],eax
        add ESI, 4
        add bl,1
        jmp readloop
    endreadloop:
    
    ;we decrease len because we start from 0
    mov [len],ebx
    
   
    
    mov EDI,0;we will it as an index to insert elemetns
    ;simoultaneously in B1 and B2
    mov ESI,A; ESI is now pointing at the beginning of A
    cld; we parse the string from left to right
    repeat:
        lodsb; the lower byte of the lower word of current element of A will be loaded in AH
        mov [B1+EDI],al
        lodsw; this will move to esi to the higher part of higher word of current elemnt of A
        lodsb; we have the element we need to insert in B2 in ah
        mov [B2+EDI],al
        
        inc EDI
        cmp EDI, [len]
        jz endrepeat
        
        
        jmp repeat
    endrepeat:
    
      
    mov ESI,0; 
    
    ;we have a string of bytes that we need to print as hex values
    ;we can print just a doubleword at a time as a hex value
    ;so we will print 4 bytes at a time, incrementing esi with 4
    ;and checking if there are still elements from the string left
    ;in the next doubleword
    printloop1:
        push dword [B1+ESI]
        push dword format
        call[printf]
        add ESP, 4*2
        
        add ESI, 4
        cmp [len],esi
        jle endprintloop1
        
        jmp printloop1
    endprintloop1: 
       
    ;mov ESI,0;we want to print all nbs of A in hex form
    ;printloop:
            
        ;mov EAX,[A+ESI]
        ;cmp EAX,dword 0
        ;jz endprintloop
        
        ;push dword EAX
        ;push dword format
        ;call [printf]
        ;add ESP, 4 *2
        
        ;add ESI,4
        ;jmp printloop
    ;endprintloop:


    push dword 0
    call [exit]