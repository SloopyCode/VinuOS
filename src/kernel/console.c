#include "console.h"
//basic test code
static int cursor_x = 0;
static int cursor_y = 0;

uint8_t inb(uint16_t port) {
    uint8_t data;
    __asm__ volatile ("inb %1, %0" : "=a"(data) : "Nd"(port));
    return data;
}

void console_put_char(char c) {
    volatile char* video = (volatile char*)0xB8000;
    if(c == '\n') {
        cursor_x = 0;
        cursor_y++;
        return;
    }
    video[2 * (cursor_y * 80 + cursor_x)]     = c;
    video[2 * (cursor_y * 80 + cursor_x) + 1] = 0x07;
    cursor_x++;
    if(cursor_x >= 80) {
        cursor_x = 0;
        cursor_y++;
    }
    if(cursor_y >= 25) {
        cursor_y = 0;
    }
}

void console_print(const char *str) {
    for (int i = 0; str[i] != '\0'; i++) {
        console_put_char(str[i]);
    }
}

static char nibble_to_hex(uint8_t nibble) {
    if(nibble < 10)
        return '0' + nibble;
    else
        return 'A' + (nibble - 10);
}

void print_hex(uint8_t value) {
    char hex[3];
    hex[0] = nibble_to_hex(value >> 4);
    hex[1] = nibble_to_hex(value & 0x0F);
    hex[2] = '\0';
    console_print("0x");
    console_print(hex);
}

void keyboard_test(void) {
    uint8_t scancode;
    console_print("Test Code - Press a key:\n");
    while (1) {
        while (!(inb(0x64) & 1))
            ;
        scancode = inb(0x60);
        console_print("Scancode: ");
        print_hex(scancode);
        console_print("\n");
    }
}
