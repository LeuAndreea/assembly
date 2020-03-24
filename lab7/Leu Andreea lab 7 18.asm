;Read a decimal number and a hexadecimal number from the keyboard. Display the number of 1's of the sum of the two numbers in decimal format. Example:
;a = 32 = 0010 0000b
;b = 1Ah = 0001 1010b
;32 + 1Ah = 0011 1010b
;The value printed on the screen will be 4


bits 32
global start
extern exit,printf,scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
a dd 0
b dd 0
hexFormat db '%x',0
decimalFormat db '%d',0
count db 0

segment use32 class=code
start:
    push dword a
    push dword decimalFormat
    call [scanf]
    add ESP, 4 *2
    
    push dword b
    push dword hexFormat
    call [scanf]
    add ESP, 4 *2
    
    
    
    ;push dword [b]
    ;push dword decimalFormat
    ;call [printf]
    ;add ESP, 4 *2
    
        
    ;I will assume that the nbs are unsinged .
    mov eax, [b]
    add [a], eax; now var a will store a+b.
    
    ;we will use shl and carry flag to count the nb of 1's
    ;we will store the result in count
    repeat:
        cmp  [a], dword 0
        jz endrepeat
    
        shl dword [a], byte 1
        
        jnc repeat
        
        add [count],byte 1
        jmp repeat
    
    
    endrepeat:
    
    
    push dword [count]
    push dword decimalFormat
    call [printf]
    add ESP, 4 *2




    push dword 0
    
call[exit]