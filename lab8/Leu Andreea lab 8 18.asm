;A text file is given. The text contains letters, spaces and points. Read the ;content of the file, determine the number of words and display the result on; ;
;the screen. (A word is a sequence of characters separated by space or point)


bits 32 

global start        


extern exit              
extern exit,printf, scanf, fopen, fclose, fread

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
 
                         

segment data use32 class=data

readMode db "r",0
readTextFile db "in_lab8_18.txt",0

fileDescriptor dd 0

stringFormat db "%s",0
decimalFormat db "%d",0

len equ 100
buffer resb len

wordCount db 0

segment code use32 class=code
start:
    push dword readMode    
    push dword readTextFile
    call [fopen]
    add esp, 4*2 

    mov [fileDescriptor], EAX
    
    push dword [fileDescriptor]
    push dword len
    push dword 1
    push dword buffer      
    call [fread]
    add esp, 4*4
    
    push dword buffer
    push dword stringFormat
    call [printf]
    add ESP,4*2
    
    mov ESI,0 ;we will use esi to loop throught the text
    
    mov al, [buffer+ ESI]
    cmp al,'.'
    jz nocountloop
        
    cmp al,' '
    jz nocountloop
    
    cmp al,0
    jz endloop
    
    jmp wordloop
    
    
    ;I will use 3 loops to count the word, taking in consideration the special cases too
    wordloop:
        inc ESI
        mov al, [buffer+ESI]
        cmp al, ' '
        jz count
        
        cmp al, '.'
        jz count
        
        cmp al, '0'
        jz count
        
        jmp wordloop
        
    nocountloop:
        inc ESI
        mov al, [buffer+ESI]
        
        cmp al,'.'
        jz nocountloop
        
        cmp al,' '
        jz nocountloop
        
        cmp al,'0'
        jz endloop
        
        jmp wordloop
    
    count:
        add [wordCount],byte 1
        
        cmp al, '0'
        jz endloop
        
        
        inc ESI
        mov al, [buffer+ESI]
    
        cmp al, '0'
        jz endloop
        
        cmp al,'.'
        jz nocountloop
        
        cmp al,' '
        jz nocountloop
        
        jmp wordloop
    
    endloop:
    push dword [wordCount]
    push dword decimalFormat
    call [printf]
    add ESP,4*2
    
    
    push dword [fileDescriptor]
    call [fclose]
    add esp, 4
    