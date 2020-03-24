;A file name is given (defined in the data segment). Create a file with the 
;given name, then read numbers from the keyboard and write those numbers in ;the file, until the value '0' is read from the keyboard.


bits 32 

global start        


extern exit              
extern exit,printf, scanf, fopen, fclose, fprintf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll  
                         

segment data use32 class=data
    fileName db "out_lab8_12.txt",0
    writeMode db "w",0
    fileDescriptor dd -1
    
    stringFormat db'%s',0
    decimalFormat db'%d',0
    
    decimalPrintFormat db '%d ',0
    
    nb dd 0

segment code use32 class=code
start:

    push dword writeMode    
    push dword fileName
    call [fopen]
    add esp, 4*2

    mov [fileDescriptor],EAX

    repeat:
        push dword nb
        push dword decimalFormat
        call [scanf]
        add ESP, 4 *2
        
        cmp [nb],dword 0
        jz endrepeat
        
        push dword [nb]
        push dword decimalPrintFormat
        push dword [fileDescriptor]
        call [fprintf]
        add ESP, 4 *2

        jmp repeat
    
    endrepeat:
    
    
    
    push dword [fileDescriptor]
    call [fclose]
    add esp, 4
    
    
    
    
    
    
    push    dword 0
call    [exit]  