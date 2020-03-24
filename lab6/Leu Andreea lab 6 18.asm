;A string of doublewords is given. Order in increasing order the ;string of the high words (most significant) from these ;doublewords. The low words (least significant) remain unchanged.

bits 32
global start
extern exit,printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
A dd 0xaabb2335,0xdddd5566,0xaabb8899,0x11222bbcc,0x7788bbcc
len dd 5
indexArray times 20 db 0
format db '%x',0
printFormat db '%x  ',0

doubleNumber dd 0h,0
segment use32 class=code
start:

    
    
    
    mov ESI, 0;we will use it to put values in A 
    
    
    mov ebx,0;we will compute the length of the string of doublewords here
    
    ;loop for reading the array
    readloop:
        ;push dword doubleNumber
        ;push dword format
        ;call [scanf]
        ;add ESP, 4 *2
        
        
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
    
    
    
    
    mov ESI,1
    sortloop:
        
        mov EDI,ESI
        nestedloop:
            mov AX, [A + EDI*4 + 2]
            mov BX, [A + EDI*4 -2]
            cmp AX, BX
            jae endnestedloop
        
            mov word [A+EDI*4 +2],BX
            mov word [A+EDI*4-2],AX
        
            dec EDI
            cmp EDI,0
            jz endnestedloop
            
            jmp nestedloop
        endnestedloop:
        inc ESI
        cmp ESI,[len]
        jz endsortloop
        
        jmp sortloop
    
    endsortloop:
    
    mov ESI,0
    printloop:
            
        mov EAX,[A+ESI]
        cmp EAX,dword 0
        jz endprintloop
        
        push dword EAX
        push dword printFormat
        call [printf]
        add ESP, 4 *2
        
        add ESI,4
        jmp printloop
    endprintloop:
    
    
    push dword 0
    call [exit]  
    
    