; OhMyAsm Module
; Standard library functions and macros

%ifndef OMA_ASM_FRAMEWORK

; Arithmetic operations
%macro add_nums 2
    mov eax, %1
    add eax, %2
%endmacro

%macro sub_nums 2
    mov eax, %1
    sub eax, %2
%endmacro

%macro mul_nums 2
    mov eax, %1
    mul %2
%endmacro

; Control flow
%macro if_eq 2
    cmp %1, %2
    je %%then
    jmp %%end
%%then:
%endmacro

%macro endif 0
%%end:
%endmacro

; String operations
%macro strcpy 2
    push %1
    push %2
    call __strcpy
    add esp, 8
%endmacro

%macro compare_str 2
    push %1
    push %2
    call __strcmp
    add esp, 8
%endmacro

; Memory operations
%macro alloc 1
    push %1
    call __malloc
    add esp, 4
%endmacro

%macro free 1
    push %1
    call __free
    add esp, 4
%endmacro

; Stack operations
%macro push_all 0
    pushad
    pushfd
%endmacro

%macro pop_all 0
    popfd
    popad
%endmacro

%define OMA_ASM

; Useful macros
%macro syscall 0
    call __syscall
%endmacro

%macro exit 1
    mov eax, 1
    mov ebx, %1
    syscall
%endmacro

; String operations
%macro print 1
    push %1
    call __print
    add esp, 4
%endmacro

%macro strlen 1
    push %1
    call __strlen
    add esp, 4
%endmacro

; Required functions
section .text

__syscall:
    int 0x80
    ret

__print:
    push ebp
    mov ebp, esp
    mov edx, [ebp+8]
    mov ecx, edx
    mov ebx, 1
    mov eax, 4
    syscall
    pop ebp
    ret

__strlen:
    push ebp
    mov ebp, esp
    mov edi, [ebp+8]
    xor eax, eax
    mov ecx, -1
    repne scasb
    not ecx
    dec ecx
    mov eax, ecx
    pop ebp
    ret

%endif
