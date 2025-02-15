[BITS 16]          ; 16-bit real mode
[ORG 0x7C00]       ; Bootloader loaded at 0x7C00

start:
    cli            ; Disable interrupts
    
    call clear_screen

    mov si, msg_disabled   ; Debug info
    call print_string

    cld            ; Clear direction flag
    mov si, msg_cleared   ; Debug info
    call print_string

    mov ax, 0x07C0 ; Set stack
    mov ss, ax
    mov sp, 0x7C00
    mov si, msg_stack_init   ; Debug info
    call print_string

    sti            ; Enable interrupts
    mov si, msg_sti   ; Debug info
    call print_string

    ; Debug message: Bootloader start
    mov si, boot_msg
    call print_string

    ; Load kernel from disk
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000  ; Memory address to load to
    mov dh, 1       ; Number of sectors

    mov si, divider   
    call print_string
    
    call load_kernel

    mov si, divider   
    call print_string

    mov si, VinuOS   
    call print_string

    jmp 0x1000:start


; Function: Print string
print_string:
    mov ah, 0x0E
.loop:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .loop
.done:
    ret

; Function: Load kernel from disk
load_kernel:
    mov ah, 0x02   ; BIOS function: Read sectors
    mov al, dh     ; Number of sectors
    mov ch, 0x00   ; Cylinder
    mov cl, 0x02   ; Start sector (after boot sector)
    mov dh, 0x00   ; Head
    mov dl, 0x80   ; First hard disk
    int 0x13       ; BIOS interrupt
    mov si, kernel_msg 
    call print_string
    jc load_fail   ; Jump to failure if error
    ret

load_fail:
    ; No message is printed for failure
    hlt


; -----------------------------
; Function: Clear Screen
; -----------------------------
clear_screen:
    mov ax, 0xB800      ; VGA segment address
    mov es, ax
    xor di, di          ; Start at offset 0
    mov cx, 80*25       ; 80 columns x 25 rows
    mov ax, 0x0720      ; Space character (0x20) ; attribute 0x07
    cld                 ; Forward direction
    rep stosw         ; Fill screen with spaces
    ret

; Debug messages
msg_disabled db " [ Interrupts Disabled ]                - s", 13, 10, 0, 
msg_cleared db " [ Direction Flag Cleared - CLD ]       - s", 13, 10, 0, 
msg_stack_init db " [ Stack Initialized to 0x7C00 ]        - s", 13, 10, 0, 
msg_sti db " [ Interrupts Enabled - STI ]           - s", 13, 10, 0, 
msg_loading_kernel db " [ Kernel Loading Started ]             - s", 13, 10, 0, 
boot_msg db " [ Bootloader Started ]                 - s", 13, 10, 0, 
kernel_msg db " Load Vinu-core (v25B13)", 13, 10, 0, 
divider db " ", 13, 10, 0, 
VinuOS db " Starting VinuOS-kerneltasks", 13, 10, 0, 

times 510-($-$$) db 0  ; Fill to 510 bytes
dw 0xAA55               ; Boot signature
