;a - byte, b - word, c - double word, d - qword
;(a+d)-(c-b)+c


bits 32;

global start

extern exit;

import exit msvcrt.dll;

segment data use32 class=data;

a db 6
b dw 56
c dd 203
d dq 190

segment code use32 class=code;
start:


mov ax,1000000000000001b

mov cl,[a]
mov ch,0

mov ax,[b]
sub cx,ax

mov eax,0
mov ax,cx

mov ebx,0
add eax,dword[d]
add ebx,dword[d+4]

















 

