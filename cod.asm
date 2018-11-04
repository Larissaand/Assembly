MAXARGS     equ     3 
sys_exit    equ     1
sys_read    equ     3
sys_write   equ     4
stdin       equ     0
stdout      equ     1
stderr      equ     3

SECTION     .data
szLineFeed  db      10
szErrMsg    db      "Too many arguments.  The max number of args is 2", 10
ERRLEN      equ     $-szErrMsg

section .bss
fd_out resb 1


SECTION     .text
global      _start
     
_start:


    ;mov     ebp, esp
    cmp     dword [esp], 1
    je      NoArgs 
    
    cmp     dword [esp], MAXARGS        ; check total args entered
    ja      TooManyArgs                     ; if total is greater than MAXARGS, show error and quit

    mov     ebx, 3

     

DoNextArg: 
    mov     edi, dword [ebp + 8 * ebx]
    test    edi, edi
    jz      Exit
    
    xor     ecx, ecx
    not     ecx
    xor     eax, eax
    cld
    repne   scasb
    mov     byte [edi - 1], 10
    not     ecx
    lea     edx, [ecx - 1]



    mov     edx, dword [ebp + 8 * ebx]

    
    inc     ebx
    
    mov     edi, dword [ebp + 8 * ebx]
    test    edi, edi
    jz      Exit

    mov     ecx, dword [ebp + 8 * ebx]
    
    ;create the file
    mov  eax, 8
    mov  ebx, ecx
    mov  ecx, 0777        ;read, write and execute by all
    int  0x80             ;call kernel
 	
    mov [fd_out], eax
    mov ecx, edx
    
   ; write into the file
    mov	edx,edx          ;number of bytes
    mov	ebx, [fd_out]    ;file descriptor 
    mov	eax,4            ;system call number (sys_write)
    int	0x80             ;call kernel
	
   ; close the file
    mov eax, 6
    mov ebx, [fd_out]
    mov	eax,1             ;system call number (sys_exit)
    int	0x80

    jmp     Exit
    

NoArgs:
    jmp     Exit     
     
TooManyArgs:
    mov     eax, sys_write
    mov     ebx, stdout
    mov     ecx, szErrMsg
    mov     edx, ERRLEN
    int     80H

     
Exit:
    mov     eax, sys_exit
    int     80H
