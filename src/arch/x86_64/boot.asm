; Real-mode boot prodedure

global start ; Export the `start` symbol

section .text
bits 32 ; Specify the following instr are 32 bit instr
start:
    ; Print `OK` to the screen
    mov dword [0xb8000], 0x2F4B2F4F
    hlt ; Halt
