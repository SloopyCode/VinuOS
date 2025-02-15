[BITS 16]
global start

start:
    cli
    ; Set DS (and ES, FS, GS) immediately to 0x1000 - kernel is linked from 0x1000.
    mov ax, 0x1000
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Output debug information
    mov si, msg_disabled      ; " [ Interrupts disabled ]"
    call print_string

    mov si, msg_datasegment   ; " [ Data Segment = 0x1000 ]"
    call print_string

    sti

    mov si, msg_kernelreached ; " [ start at 0x0000 ]"
    call print_string

    ; Wait for keyboard input
    mov ah, 0x00
    int 0x16

    ; Clear screen
    call clear_screen

    mov si, msg_osstart       ; " [ start at 0x0000 ]"
    call print_string

    ; Infinite loop
    jmp $

; -----------------------------
; Function: Print string
; -----------------------------
print_string:
    mov ah, 0x0E
.loop:
    lodsb          ; Load next character from DS:SI
    or al, al      ; Check if NULL ('\0')
    jz .done       ; If yes, done
    int 0x10       ; Output character
    jmp .loop      ; Next character
.done:
    ret

; -----------------------------
; Function: Clear Screen
; -----------------------------
clear_screen:
    mov ax, 0xB800      ; VGA segment address
    mov es, ax
    xor di, di          ; Start at offset 0
    mov cx, 80*25       ; 80 columns x 25 rows
    mov ax, 0x0720      ; Space (0x20) + standard attribute 0x07
    cld
    rep stosw           ; Fill screen
    ret

; -----------------------------
; Debug messages
; -----------------------------
msg_disabled      db " [ Interrupts disabled ]", 13, 10, 0
msg_datasegment   db " [ Data Segment = 0x1000 ]", 13, 10, 0
msg_kernelreached db " [ kernel reached ]", 13, 10, 0
msg_osstart       db " Starting VinuOS", 13, 10, 0
