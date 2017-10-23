; Multiboot header
;
; Header following the `Multiboot 2` specification
;
; Arranged in the following way
; |---------------|-----------------|--------------------------------|
; | Field         | Type            | Value                          |
; |:--------------|:----------------|:-------------------------------|
; | Magic Number  | u32             | `0xE85250D6`                   |
; | Architetcture | u32             | `0` for `i386`, `4` for `MIPS` |
; | Header Length | u32             | total header size              |
; | Checksum      | u32             | `-(magic + arch + len)`        |
; | Optional Tags |  ?              |                                |
; | End Tag       | (u16, u16, u32) | (0, 0, 8)                      |
; |---------------|-----------------|--------------------------------|


section .multiboot_header
header_start:
    dd 0xE85250D6                ; Magic number
    dd 0                         ; Architecture
    dd header_end - header_start ; Header length

    ; Checksum
    dd 0x1000000000 - (0xE85250D6 + 0 + (header_end - header_start))

    ; Optional multiboot tags

    ; End tags
    dw 0    ; Type
    dw 0    ; Flags
    dd 8    ; Size
header_end:
