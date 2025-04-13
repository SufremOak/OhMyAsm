; #############################
; #      The OhMyAsm CLI      #
; #     v0.0.1 | x86_nasm     #
; #############################

[org 0x10000]
bits 16

section .data
    prompt db "OhMyAsm> ", 0
    input_buffer db 128, 0  ; Max 128 characters, first byte stores length
    hello_msg db "Hello, world!", 0
    unknown_cmd db "Unknown command.", 0
    newline db 0xA, 0xD, 0  ; Newline (LF + CR)

section .text
start:
    ; Display the prompt
    mov ah, 09h
    lea dx, [prompt]
    int 21h

    ; Read user input
    mov ah, 0Ah
    lea dx, [input_buffer]
    int 21h

    ; Process input
    lea si, [input_buffer + 1]  ; Skip the length byte
    cmp byte [si], 'h'         ; Check if the first character is 'h'
    je cmd_hello
    cmp byte [si], 'e'         ; Check if the first character is 'e'
    je cmd_exit

    ; Unknown command
    mov ah, 09h
    lea dx, [unknown_cmd]
    int 21h
    jmp newline_and_prompt

cmd_hello:
    ; Print "Hello, world!"
    mov ah, 09h
    lea dx, [hello_msg]
    int 21h
    jmp newline_and_prompt

cmd_exit:
    ; Exit the program
    mov ah, 4Ch
    int 21h

newline_and_prompt:
    ; Print a newline
    mov ah, 09h
    lea dx, [newline]
    int 21h
    jmp start