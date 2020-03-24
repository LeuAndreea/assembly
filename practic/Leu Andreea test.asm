;1
bits 32 

global start        


extern exit              
extern exit,printf, scanf, fopen, fclose, fread, fprintf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll  
                         

segment data use32 class=data

format db '%s',0
format2 db'%d',0
format3 db '%c',0
readFileName times 20 db 0
readMode db "r", 0 
writeMode db "w", 0
file_descriptor dd -1
litera dd 0
writeFileName db "out.txt",0


;readFileName db "in.txt",0

len equ 100
buffer resb len;here we will read the file  

nbOfWords dd 0   
   

segment code use32 class=code
    start:
        
    ;reading file name
    push dword readFileName
    push dword format
    call [scanf]
    add ESP,4*2
    
 
        
    ;push dword readFileName
    ;push dword format
    ;call [printf]
    ;add ESP,4*2
    
    push dword readMode    
    push dword readFileName
    call [fopen]
    add esp, 4*2 

    mov [file_descriptor], EAX
    
    push dword [file_descriptor]
    push dword len
    push dword 1
    push dword buffer      
    call [fread]
    add esp, 4*4
    
    
    push dword buffer
    push dword format
    call [printf]
    add ESP,4*2
    
    
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    push dword writeMode    
    push dword writeFileName
    call [fopen]
    add esp, 4*2 
    
    mov [file_descriptor], EAX
    

    mov ESI,-1; we will increment elemesnt of buffer
    mov ax,0
    
    bucla:
        inc ESI
        
        mov ax,0
        mov al, [buffer+ ESI]
        cmp ax,0
        jz endbucla
        
        mov [nbOfWords],dword 1
        
        phraseloop:
            mov EDI, ESI
            firstwordloop:
                mov eax,0
                mov al,[buffer+EDI]
                
                cmp al, ' '
                jz endfirstwordloop;
            
               
                mov [litera], eax
           
                push litera
                
                call [printf]
                add ESP,4*2
                
                push litera
                push dword [file_descriptor]
                call [fprintf]
                add ESP,4*2
                
                inc EDI
                jmp firstwordloop
            endfirstwordloop:
           
            ;printing word
            
            mov ESI,EDI
        
            wordnumberloop:
                inc ESI
                mov al, [buffer+ESI]
                
                cmp al, '.'
                jz endphraseloop
                
                cmp al, ' '
                jnz wordnumberloop
                
                add [nbOfWords],dword 1
           
                jmp wordnumberloop
           
            endwordnumberloop:
     
            
            
            
    
        endphraseloop:
        
        add [nbOfWords],dword 1;last word
        push dword [nbOfWords]
        push dword format2
        call [printf]
        add ESP,4*2
        
        ;push dword [nbOfWords]
        ;push dword format2
        ;push dword [file_descriptor]
        ;call [fprintf]
        ;add ESP,4*2
        
        jmp bucla
    

    
    
    
    endbucla:
    
    
    
    push dword [file_descriptor]
    call [fclose]
    add esp, 4
    
    
    
    
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
