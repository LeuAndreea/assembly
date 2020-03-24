;a - byte, b - word, c - double word, d - qword
;c-b-(a+a)-b



bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions

segment  data use32 class=data ; the data segment where the variables are declared 
	a db -10
	b dw 20
	c dd -25
	        
        
segment  code use32 class=code
start:
    mov al, [a]
    cbw;signed conversion from al to ax
    
    adc ax,[b];we add b
    
    mov cx,2;we put 2 in cx to compute 2*(a+b)
    imul cx;now dx;ax=2*(a+b)
    
    mov bx,word [c]
    mov cx,word [c+2];now cx:bx=c
    
    sub bx,ax
    sbb cx,dx;now cx:bx=c-2*(a+b)
    
    push cx
    push bx
    pop eax;now eax=c-2*(a+b)
    
    push dword 0
    call exit
    
    
    
    





