;A negative number a (a: dword) is given. Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = ;<base_16> (base 16)"

bits 32
global start
extern exit,printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
decimalFormat db '%d',0
hexFormat db '%x',0

a dd 0

decimalPrintFormat db 'a= %d (base 10) ',0
hexPrintFormat db 'a= %x (base 16)',0


segment use32 class=code
start:
    ;reading the number
    push dword a
    push dword decimalFormat
    call [scanf]
    add ESP,4*2
    
    push dword [a]
    push dword decimalPrintFormat
    call [printf]
    add ESP,4*2
    
    push dword [a]
    push dword hexPrintFormat
    call [printf]
    add ESP,4*2
    
    
    
    
    push dword 0
    call [exit]
    
    